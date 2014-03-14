package salesman.mypage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import salesman.common.service.StorageService;
import salesman.mypage.service.MypageService;
import salesman.vo.account.SessionVO;


@Controller
@RequestMapping("/mypage/*")
public class MypageController {
	
	@Autowired
	private MypageService mypageService;
	
    @Autowired
    private StorageService storageService;	
   
    @RequestMapping("/list")
    public String list(ModelMap model)
    {
		SessionVO userInfo = storageService.getAuthenticatedUser();		
		if(userInfo == null) {
			//message = "failed";
			model.put("mypageList","로그인 후 견적등록을 할 수 있습니다");
		} else {
			model.put("mypageList",mypageService.getMypagelist(userInfo.getUserId()));
		}
        
    	return "mypage/myList";
    } 
    
   
 
}
