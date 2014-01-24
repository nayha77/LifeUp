package salesman.account.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.account.service.AccountService;
import salesman.common.service.MailingMessage;
import salesman.common.service.MailingService;
import salesman.common.service.StorageService;
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;

@Controller
public class AccountController {
    @Autowired
    private StorageService storageService;
	
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private MailingService mailingService;
	
	@Autowired
	private MailingMessage mailingMessage;
	       
    @RequestMapping("/logout")
    public String logout() 
    {
    	storageService.SessionOut();
    	return "redirect:/main.do";    	
    }
    
    /*
     * 로그인처리
     */
    @RequestMapping("/account/actionLogin")
    public @ResponseBody Map<String, Object> actionLogin(@RequestBody LoginVO loginVO, HttpServletRequest request) {     
    	
    	String message = "success";    	
    	SessionVO userInfo = null;    	  	
    	
    	Map<String, Object> result = new HashMap<String, Object>();    	
    	
    	try {    		
        	if(loginVO == null || loginVO.getUserId() == null || loginVO.getPassword() == null) {
        		message = "아이디와 비밀번호를 입력하세요";
        	} else {  
        		if(storageService.getAuthenticatedUser() != null) {
        			message = "duplicated";
        		} else if(accountService.getUserInfo(loginVO) != null) {	    	
        			userInfo = accountService.tryLogin(loginVO);	    	
			    	if (userInfo == null) {
			    		message = "로그인에 실패했습니다. 입력정보를 확인하세요";
		    		} else {
		    			message = "success";		    			
			    	}
		    	} else {
		    		message = "회원가입 후 로그인 해주세요";
		    	}	    			    		    
        	}	    		        	
    		
    		result.put("message", message);
    	} catch (Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	}
    	
    	return result;
    }   

    /*
     * 비밀번호 변경화면 호출 (e-mail을 통한 연결)
     */
    @RequestMapping(value="/account/ModifyPwd", method=RequestMethod.GET)
    public void ModifyPwd(@RequestParam Map<String,Object> paramMap, ModelMap model, HttpServletRequest request) {
    	LoginVO loginVO = new LoginVO(); 
    	loginVO.setUserType(Integer.parseInt(paramMap.get("userType").toString()));
    	loginVO.setUserId(paramMap.get("userId").toString());
    	SessionVO userInfo = accountService.getUserInfo(loginVO);
    	
    	String message = "잘못된 사용자 요청입니다";
    	if(userInfo != null) {
    		if(userInfo.getInit_pwd() != null && userInfo.getInit_pwd().equals("Y"))
    			message = "";
    		else
    			message = "만료된 페이지 입니다. 다시 요청하세요";
    	} 
    	
    	model.addAttribute("user", paramMap);
    	model.addAttribute("message", message);
    }
        
    /*
     * 비밀번호 변경처리 (e-mail을 통한 변경)
     */
    @RequestMapping("/account/tryModifyPwd")
    public String tryModifyPwd(@RequestParam Map<String,Object> paramMap, HttpServletRequest request) {
    	
    	LoginVO login = new LoginVO();
    	SessionVO user = new SessionVO();    	
    	user.setUserId(paramMap.get("userId").toString());
    	user.setPassword(paramMap.get("password").toString());
    	user.setUserType(Integer.parseInt(paramMap.get("userType").toString()));    	
    	
    	if(accountService.modifyUserPasswd(user))    		
    		return "redirect:/main.do";    	
    	
    	return "redirect:/account/ModifyPwd.do"; 
    }    
    
    /*
     * 사용자 찾기
     */
    @RequestMapping("/account/findUser")
    public @ResponseBody Map<String, Object> findUser(@RequestBody LoginVO loginVO, HttpServletRequest request) {
    	
    	Map<String, Object> result = new HashMap<String, Object>();
    	
    	try {    		    		     		
    		mailingMessage.setHtmlContent("ID", loginVO);
    		
    		if(mailingMessage.getHtmlContent().equals("")) {
    			result.put("message", "등록되지 않은 사용자입니다. 입력정보를 확인하세요");
    		} else {
    			mailingService.sendMail("hk@retailtech.co.kr", loginVO.getEmail(), "[HK] 계정정보 안내메일", mailingMessage);    		
    			result.put("message", "success");
    		}
    	} catch(Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	}
    	
    	return result;
    }
    
    /*
     * 사용자비밀번호 찾기
     */
    @RequestMapping("/account/findPwd")
    public @ResponseBody Map<String, Object> findPwd(@RequestBody LoginVO loginVO, HttpServletRequest request) {

    	Map<String, Object> result = new HashMap<String, Object>();    	
    	
    	try {    		    		    		
    		loginVO.setInitPwd("Y");    		
    		mailingMessage.setHtmlContent("PWD", loginVO);
    		
    		if(mailingMessage.getHtmlContent().equals("")) {
    			result.put("message", "등록되지 않은 사용자입니다. 입력정보를 확인하세요");
    		} else {
    			mailingService.sendMail("hk@retailtech.co.kr", loginVO.getEmail(), "[HK] 계정정보 안내메일", mailingMessage);
    			result.put("message", "success");
    		}    		    		
    	} catch(Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	}
    	
    	return result;
    }          
    
    @RequestMapping("/account/fnMyInfo")
    public @ResponseBody Map<String, Object> fnMyInfo(HttpServletRequest request) {
    	
    	SessionVO userInfo = null;
    	LoginVO user = new LoginVO();
    	Map<String, Object> result = new HashMap<String, Object>();
    	
    	try {
    		userInfo = storageService.getAuthenticatedUser();
    		
    		if(userInfo == null) {
	    		result.put("message", "로그인한 사용자가 아닙니다");    			
    		} else {
	        	user.setUserType(userInfo.getUserType());
	        	user.setUserId(userInfo.getUserId());
	        	
	    		userInfo = accountService.getUserInfo(user);
	    		
	    		result.put("message", "success");
	    		result.put("userInfo", userInfo);
    		}
    	} catch(Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	} 
    	
    	return result;
    }
    
    @RequestMapping("/account/fnMyInfoUpdate")
    public @ResponseBody Map<String, Object> fnMyInfoUpdate(@RequestBody SessionVO param, HttpServletRequest request) {

    	Map<String, Object> result = new HashMap<String, Object>();
    	SessionVO userInfo = null;
    	
    	try {    		
    		userInfo = storageService.getAuthenticatedUser();
    		
    		if(userInfo == null) {
	    		result.put("message", "로그인한 사용자가 아닙니다");    			
    		} else {
	    		param.setUserId(userInfo.getUserId());
	    		param.setUserType(userInfo.getUserType());    		
	
	        	if(accountService.modifyUserInfo(param))
	    			result.put("message", "success");
	    		else
	    			result.put("message", "정보수정에 실패했습니다. 입력정보를 확인하세요");
    		}
    	} catch(Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	} 
    	
    	return result;
    }    
    
    @RequestMapping("/main")
	public void main() {
//    	if(storageService.getAuthenticatedUser() == null)
//    		return "redirect:/login.do";
//    	
//    	return "forward:/main.do";
    }   
    
    @RequestMapping("/account/Membership")
	public void Membership() {
    	
    }    
}