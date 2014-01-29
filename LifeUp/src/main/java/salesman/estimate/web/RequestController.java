package salesman.estimate.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/request/*")
public class RequestController {
	    
    @RequestMapping("/list")
    public String list() 
    {
    	return "estimate/request/requestList";
    }    
}