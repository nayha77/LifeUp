	package salesman.estimate.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.common.service.CodesService;
import salesman.common.service.StorageService;
import salesman.estimate.service.ContractService;
import salesman.estimate.service.RequestService;
import salesman.vo.account.SessionVO;
import salesman.vo.estimate.RequestVO;


@Controller
@RequestMapping("/request/*")
public class RequestController {
	
	@Autowired
	private RequestService requestService;
	
	@Autowired
	private ContractService contractService;
	
    @Autowired
    private CodesService codeService;	
	    
    @Autowired
    private StorageService storageService;	
    
    @RequestMapping("/list")
    public String list(@RequestParam (value="currentSeq", required=false) String currentSeq, ModelMap model)
    {
    	if(currentSeq == null || currentSeq == "")
    		currentSeq = "7";
    	
        model.put("estimateRegList", requestService.getRequestList(Integer.parseInt(currentSeq)));
    	return "estimate/request/requestList";
    } 
    
    @RequestMapping(value="/listJson", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> listJson(@RequestBody int currentSeq)
    {
    	Map<String, Object> result = new HashMap<String, Object>();    	
    	List<HashMap<String, Object>> list = requestService.getRequestListMore(currentSeq);    	
    	    
    	result.put("list", list);    	
    	result.put("currentSeq", currentSeq + 7);
    	
    	return result;
    }     
    
    @RequestMapping("/writeform")
    public String addForm(ModelMap model) {
    	model.put("sidos", codeService.selectRegionSidoTable());
    	model.put("venders", codeService.getVendorCodes());
        return "estimate/request/writeform";
    }
    
    @RequestMapping(value="/writing", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> writing(@RequestBody RequestVO requestVO)
    {    	
    	String message = "success";
    	Map<String, Object> result = new HashMap<String, Object>();
    	
		SessionVO userInfo = storageService.getAuthenticatedUser();
		if(userInfo == null) {
			message = "로그인 후 등록할 수 있습니다";
		} else {			    	
	    	requestVO.setStatus("0001");
	    	requestVO.setCustomer_id(userInfo.getUserId());
	    	
	    	if(requestService.registerRequest(requestVO) <= 0)
	    		message = "failed";
		}
		
    	result.put("message", message);
    	return result;
    } 
    
    @RequestMapping("/detail")
    public String detail(@RequestParam int ID, ModelMap model) {    	    
    	Map<String, Object> request = requestService.getRequestDetail(ID);
    	List<HashMap<String, Object>> contract = contractService.getContractList(ID, null);
    	
    	model.put("request", request);   	    	
    	model.put("contract", contract);
    	
        return "estimate/request/detail";
    }
}