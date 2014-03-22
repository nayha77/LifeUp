package salesman.mypage.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import salesman.common.service.StorageService;
import salesman.common.util.FileScrty;
import salesman.estimate.service.RequestService;
import salesman.mypage.service.MypageService;
import salesman.vo.account.SessionVO;



@Controller
@RequestMapping("/mypage/*")
public class MypageController {
	
	@Autowired
	private MypageService mypageService;
	
    @Autowired
    private StorageService storageService;	
    
	@Autowired
	private RequestService requestService;
   
    @RequestMapping("/list")
    public String list(ModelMap model)
    {
		SessionVO userInfo = storageService.getAuthenticatedUser();		
		if(userInfo == null) {
			//message = "failed";
			model.put("mypageList","로그인 후 견적등록을 할 수 있습니다.");
		} else {
			model.put("mypageList",mypageService.getMypagelist(userInfo.getUserId(),userInfo.getUserType() ));
		}
        
    	return "mypage/myList";
    } 
    
    @RequestMapping("/detail")
    public String detail(@RequestParam int id, ModelMap model)
    {
    	Map<String, Object> request = new HashMap<String, Object>();
    	request = requestService.getRequestDetail(id);	
    	
		model.put("requestDetail",request);
    	return "mypage/myDetail";
    	
    }
    
    /*
     * 현재_비밀번호 검사
     */
    @RequestMapping(value="/chkExistUserPassword")
    public void passchk(@RequestParam String password, @RequestParam String user_id, HttpServletResponse response)throws Exception
    {
		SessionVO userInfo = storageService.getAuthenticatedUser();	
		Map<String, Object> passMap = new HashMap<String, Object>();
		password = FileScrty.encryptPassword(password);
		passMap.put("password", password);
		passMap.put("user_id", user_id);
		
		System.out.println("passMap ===== "  +passMap.toString() );
		
		String message= "1";
		if(userInfo == null) {
			message = "failed";
		} else {
			try {  			
				int result =  mypageService.getPasschk(passMap,userInfo.getUserType());
				if( result <= 0){
					response.getWriter().print("false"); 
				}else{
					response.getWriter().print("true"); 
				}
		 	} catch(Exception ex) {
	    		response.getWriter().print("false");
	    	} 			
			
		}  
		
 	 }
   
 
}
