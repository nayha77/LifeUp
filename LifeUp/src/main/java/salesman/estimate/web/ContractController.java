package salesman.estimate.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import salesman.common.support.CustomException;
import salesman.estimate.service.RequestService;

@Controller
@RequestMapping("/contract/*")
public class ContractController {
	 
	@Autowired
	private RequestService requestService;
	
	@RequestMapping("/writeform")
    public String write(@RequestParam(value="requestId", required=false) String requestId, ModelMap model)
    {
		int id = 0;
		Map<String, Object> result = new HashMap<String, Object>();
		
		requestId = "4";
				
		if(requestId == null || requestId == "")
			throw new CustomException("유효하지 않은 정보로 인해 페이지를 열 수 없습니다");
			
		id = Integer.parseInt(requestId);  
		result = requestService.EstimateDetail(id);		
		model.put("requestDetail", result);		
		
    	return "estimate/contract/contractForm";
    }    
}