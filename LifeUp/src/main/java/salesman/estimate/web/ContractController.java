package salesman.estimate.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/contract/*")
public class ContractController {
	 
	/*
	 * 견적서 요청에 대한 견적 작성 폼
	 */
    @RequestMapping("/write")
    public String write(@RequestParam Map<String,Object> paramMap, ModelMap model, HttpServletRequest request)
    {
    	// 1. 파라메터 수신
    	
    	// 2. 견적요청 내용 가져오기    	
    	
    	return "estimate/contract/contractForm";
    }    
}