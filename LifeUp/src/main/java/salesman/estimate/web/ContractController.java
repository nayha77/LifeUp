package salesman.estimate.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.common.service.StorageService;
import salesman.common.support.CustomException;
import salesman.estimate.service.ContractService;
import salesman.estimate.service.RequestService;
import salesman.vo.account.SessionVO;
import salesman.vo.estimate.ContractVO;

@Controller
@RequestMapping("/contract/*")
public class ContractController {
	 
	@Autowired
	private RequestService requestService;
	
	@Autowired
	private ContractService contractService;
	
    @Autowired
    private StorageService storageService;	
	
	@RequestMapping("/writeform")
    public String writeform(@RequestParam(value="requestId", required=false) String requestId, ModelMap model) {
		int id = 0;
		Map<String, Object> request = new HashMap<String, Object>();
		Map<String, Object> contract = new HashMap<String, Object>();
		
		requestId = "4";
				
		if(requestId == null || requestId == "")
			throw new CustomException("유효하지 않은 정보로 인해 페이지를 열 수 없습니다");
			
		id = Integer.parseInt(requestId);  
		request = requestService.getRequestDetail(id);
		contract = contractService.getContractDetail(id);
		
		model.put("requestDetail", request);
		model.put("contractDetail", contract);
		
    	return "estimate/contract/contractForm";
    }  
	
	@RequestMapping(value="/registContract", produces={"application/xml", "application/json"} )
	public @ResponseBody Map<String, Object> registContract(@RequestBody ContractVO contractVO) {
		
		String message = "success";
		Map<String, Object> result = new HashMap<String, Object>();
		
		SessionVO userInfo = storageService.getAuthenticatedUser();		
		if(userInfo == null) {
			message = "failed";
			result.put("detail", "로그인 후 견적등록을 할 수 있습니다");			
		} else {
			contractVO.setSalesman_id(userInfo.getUserId());
			if(contractService.modifyContract(contractVO) == 0) {
				if(contractService.registerContract(contractVO) <= 0) {							
					message = "failed";
					result.put("detail", "견적등록 중 오류가 발생했습니다");
				}
			}
		}
		
		result.put("message", message);
		
		return result;
	}
}