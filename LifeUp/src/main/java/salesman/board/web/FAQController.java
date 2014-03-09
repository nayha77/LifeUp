package salesman.board.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/faq/*")
public class FAQController {
	
    @RequestMapping("/list")
    public String list() 
    {    	    
    	return "post/faqList";
    }
}
