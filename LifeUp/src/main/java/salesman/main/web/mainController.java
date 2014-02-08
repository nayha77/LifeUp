package salesman.main.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.common.service.CodesService;
import salesman.common.service.StorageService;
import salesman.vo.account.SessionVO;

@Controller
public class mainController {
    @Autowired
    private StorageService storageService;
    
    @Autowired
    private CodesService codeService;
    
    @RequestMapping("/test")
    public String test() { 
    	return "account/test";
    }    		
		               
    @RequestMapping("/main")    
	public String main(HttpServletRequest request, HttpServletResponse response, @RequestParam(required=false) String saveYn){
    	
    	Cookie cookie = null;
    	SessionVO session = storageService.getAuthenticatedUser();
    	
    	// 로그인을 한 경우 쿠키로직 수행
    	if(session != null) { 
	    	if(saveYn.equals("N")) { // 저장하지 않도록 설정한 경우 (로그인해서 호출한 경우만 'N' 값이 넘어올 수 있다)
	    		Cookie []cookies = request.getCookies();
	    		if(cookies != null) {
		    		for(int i=0; i<cookies.length; i++) {
		    			cookies[i].setMaxAge(0);
		    			response.addCookie(cookies[i]);
		    		}
	    		}    	
	    	} else if (saveYn.equals("Y")) { // 로그인 완료 후     		
	    		cookie = new Cookie("userId", session.getUserId());	
		    	cookie.setMaxAge(60*60*24*30);
		    	response.addCookie(cookie);
	    	}
    	}
    	
    	return "main";
    }
    
    @RequestMapping("/selectBoxTest")
	public  String list(ModelMap model) {
         model.put("Sido", codeService.selectRegionSidoTable());
    	return "common/selectBox";
    }
    
    @RequestMapping("/regionSecondJson")
	public @ResponseBody Map<String, Object> listJson(@RequestBody String sido, HttpServletRequest request) {
    	Map<String, Object> result = new HashMap<String, Object>();
    	
    	if( sido == null || sido.equals("") ){
    		result.put("Sido", codeService.selectRegionSidoTable());
    	}else{
    		result.put("Sido2", codeService.selectRegionGuTable(sido));
    	}

    	return result;
    }    
    @RequestMapping("/selectCarJson")
	public @ResponseBody Map<String, Object> carlistJson(@RequestBody String venderId) {
    	
    	Map<String, Object> result = new HashMap<String, Object>();
    	result.put("carCodeList", codeService.getCarCodeList(venderId));
    	return result;
    }  
}
