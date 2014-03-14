package salesman.board.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
    @RequestMapping("/Notice")
    public String Notice() 
    {    	    
    	return "board/noticeList";
    }
    
    @RequestMapping("/FAQ")
    public String FAQ() 
    {    	    
    	return "board/faqList";
    }    
}
