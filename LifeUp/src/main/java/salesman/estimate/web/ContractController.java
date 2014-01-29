package salesman.estimate.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contract/*")
public class ContractController {
	    
    @RequestMapping("/write")
    public String write() 
    {
    	return "estimate/contract/contractList";
    }    
}