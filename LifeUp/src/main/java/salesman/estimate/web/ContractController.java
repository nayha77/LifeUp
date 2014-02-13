package salesman.estimate.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contract/*")
public class ContractController {
	 
	/*
	 * 견적서 요청에 대한 견적 작성 폼
	 */
    @RequestMapping("/writeform")
//    public String write(@RequestParam int requestId)
    public String write()
    {
    	// 1. 파라메터 수신
    	
    	// 2. 견적요청 내용 가져오기    	
    	
    	return "estimate/contract/contractForm";
    }    
}