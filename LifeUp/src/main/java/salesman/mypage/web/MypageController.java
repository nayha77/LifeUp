package salesman.mypage.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import salesman.common.service.StorageService;
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
			model.put("mypageList",mypageService.getMypagelist(userInfo.getUserId()));
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
    public String passchk(@RequestParam String password, ModelMap model)
    {
    	return "mypage/List";
    }
   
 
}
