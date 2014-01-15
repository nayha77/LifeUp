package salesman.login.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.login.service.AccountService;
import salesman.vo.login.LoginVO;
import salesman.vo.login.SessionVO;

@Controller
public class AccountController extends SqlSessionDaoSupport {
    
	@Autowired
	private AccountService accountService;
	
    @RequestMapping("/login")
    public void login() { }
    
    @RequestMapping("/actionLogin")
    public @ResponseBody Map<String, Object> actionLogin(@RequestBody Map<String, String> loginVO, HttpServletRequest request) throws Throwable {     
    	
    	String message = "success";    	
    	SessionVO sessionInfo = null;    	
    	LoginVO user = new LoginVO();    	
    	
    	Map<String, Object> result = new HashMap<String, Object>();
    	
    	if(loginVO != null && loginVO.get("userId") != null && loginVO.get("password") != null) {    	
    		user.setUserType(Integer.parseInt(loginVO.get("userType")));
	    	user.setUserId(loginVO.get("userId"));
	    	user.setPassword(loginVO.get("password"));
    		
	    	if(accountService.chkExistUser(user)) {	    	
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