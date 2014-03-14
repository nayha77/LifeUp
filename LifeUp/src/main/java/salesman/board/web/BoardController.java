package salesman.board.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import salesman.board.service.NoticeService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	private NoticeService noticeService;
	
    @RequestMapping("/Notice")
    public String Notice(ModelMap model) 
    {    	    
    	model.put("noticeList", noticeService.getNoticeList());
    	return "board/noticeList";
    }
    
    @RequestMapping("/FAQ")
    public String FAQ() 
    {    	    
    	return "board/faqList";
    }    
}
