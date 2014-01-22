package salesman.account.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.support.SqlSessionDaoSupport;
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
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;

@Controller
public class AccountController extends SqlSessionDaoSupport {
    
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private MailingService mailingService;
	
	@Autowired
	private MailingMessage mailingMessage;
	
    @RequestMapping("/login")
    public void login() { }
    
    /*
     * 비밀번호 변경화면 호출
     */
    @RequestMapping(value="/account/ModifyPwd", method=RequestMethod.GET)
    public void ModifyPwd(@RequestParam Map<String,Object> paramMap, ModelMap model, HttpServletRequest request) {
    	LoginVO loginVO = new LoginVO(); 
    	loginVO.setUserType(Integer.parseInt(paramMap.get("userType").toString()));
    	loginVO.setUserId(paramMap.get("userId").toString());
    	SessionVO userInfo = accountService.getUserInfo(loginVO);
    	
    	String message = "잘못된 사용자 요청입니다";
    	if(userInfo != null) {
    		if(userInfo.getInitPwd() != null && userInfo.getInitPwd().equals("Y"))
    			message = "";
    		else
    			message = "만료된 페이지 입니다. 다시 요청하세요";
    	} 
    	
    	model.addAttribute("user", paramMap);
    	model.addAttribute("message", message);
    }
    
    /*
     * 비밀번호 변경처리
     */
    @RequestMapping("/account/tryModifyPwd")
    public String tryModifyPwd(@RequestParam Map<String,Object> paramMap, HttpServletRequest request) {
    	SessionVO user = new SessionVO();
    	user.setUserId(paramMap.get("userId").toString());
    	user.setPassword(paramMap.get("pwd").toString());
    	user.setUserType(Integer.parseInt(paramMap.get("userType").toString()));    	
    	
    	if(accountService.modifyUserPasswd(user))
    		return "redirect:/main";    	
    	
    	return "redirect:/account/ModifyPwd"; 
    }    	
    
    /*
     * 로그인처리
     */
    @RequestMapping("/actionLogin")
    public @ResponseBody Map<String, Object> actionLogin(@RequestBody Map<String, String> loginVO, HttpServletRequest request) {     
    	
    	String message = "success";    	
    	SessionVO sessionInfo = null;    	
    	LoginVO user = new LoginVO();    	
    	
    	Map<String, Object> result = new HashMap<String, Object>();
    	
    	try {
	    	if(loginVO != null && loginVO.get("userId") != null && loginVO.get("password") != null) {    	
	    		user.setUserType(Integer.parseInt(loginVO.get("userType")));
		    	user.setUserId(loginVO.get("userId"));
		    	user.setPassword(loginVO.get("password"));
	    		
		    	if(accountService.getUserInfo(user) != null) {	    	
			    	sessionInfo = accountService.tryLogin(user);	    	
			    	if (sessionInfo == null) {
			    		message = "로그인에 실패했습니다. 입력정보를 확인하세요";
		    		} else {
		    			message = "success";
			    		request.getSession().setAttribute("userInfo", sessionInfo);
			    	}
		    	} else {
		    		message = "회원가입 후 로그인 해주세요";
		    	}	    			    		    
	    	} else {
	    		message = "아이디와 비밀번호를 입력하세요";
	    	}
	    	
	    	result.put("message", message);
	    	
    	} catch (Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	}
    	
    	return result;
    }   

    /*
     * 사용자 찾기
     */
    @RequestMapping("/findUser")
    public @ResponseBody Map<String, Object> findUser(@RequestBody Map<String, String> loginVO, HttpServletRequest request) {
    	LoginVO user = new LoginVO();    	    	
    	Map<String, Object> result = new HashMap<String, Object>();
    	
    	try {    		    		
    		user.setEmail(loginVO.get("email"));
    		user.setUserType(Integer.parseInt(loginVO.get("userType")));
    		
    		mailingMessage.setHtmlContent("ID", user);
    		mailingService.sendMail("hk@retailtech.co.kr", loginVO.get("email"), "[HK] 계정정보 안내메일", mailingMessage);
    		
    		result.put("message", "success");
    	} catch(Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	}
    	
    	return result;
    }
    
    /*
     * 사용자비밀번호 찾기
     */
    @RequestMapping("/findPwd")
    public @ResponseBody Map<String, Object> findPwd(@RequestBody Map<String, String> loginVO, HttpServletRequest request) {
    	LoginVO user = new LoginVO();    	    	
    	Map<String, Object> result = new HashMap<String, Object>();    	
    	
    	try {    		    		
    		user.setEmail(loginVO.get("email"));
    		user.setUserType(Integer.parseInt(loginVO.get("userType")));
    		user.setInitPwd("Y");
    		
    		mailingMessage.setHtmlContent("PWD", user);
    		mailingService.sendMail("hk@retailtech.co.kr", loginVO.get("email"), "[HK] 계정정보 안내메일", mailingMessage);
    		    		
    		result.put("message", "success");
    	} catch(Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	}
    	
    	return result;
    }          
    
    @RequestMapping("/fnMyInfo")
    public @ResponseBody Map<String, Object> fnMyInfo(HttpServletRequest request) {
    	Map<String, Object> result = new HashMap<String, Object>();    	
    	SessionVO userInfo = new SessionVO();    	    	
    	LoginVO user = new LoginVO(); 
    	
    	try {
        	user.setUserType(1);
        	user.setUserId("tester");

    		userInfo = accountService.getUserInfo(user);
    		result.put("message", "success");
    		result.put("userInfo", userInfo);
    	} catch(Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	} 
    	
    	return result;
    }
    
    @RequestMapping("/fnMyInfoUpdate")
    public @ResponseBody Map<String, Object> fnMyInfoUpdate(@RequestBody Map<String, String> loginVO, HttpServletRequest request) {
    	Map<String, Object> result = new HashMap<String, Object>();    	
    	SessionVO userInfo = new SessionVO();    	    	
   	
    	try {
        	userInfo.setUserType(1);
        	userInfo.setUserId("tester");
        	userInfo.setEmail(loginVO.get("email").toString());
        	userInfo.setMobile(loginVO.get("mobile").toString());
        	userInfo.setPassword(loginVO.get("password").toString());

    		if(accountService.modifyUserInfo(userInfo))
    			result.put("message", "success");
    		else
    			result.put("message", "failed");
    	} catch(Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	} 
    	
    	return result;
    }
    
    @RequestMapping(value="/Logout")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
    	return "redirect:/login.do";
    }
    
    @RequestMapping("/main")
	public void main(ModelMap model) throws Exception {
    	
    }   
}