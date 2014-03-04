package salesman.estimate.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.common.service.CodesService;
import salesman.common.service.StorageService;
import salesman.estimate.service.ContractService;
import salesman.estimate.service.RequestService;
import salesman.vo.account.SessionVO;
import salesman.vo.estimate.ContractVO;
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
    
    private int pageRecordCnt = 7;
    
    @RequestMapping("/list")
    public String list(@RequestParam (value="currentSeq", required=false) String currentSeq, ModelMap model)
    {
    	if(currentSeq == null || currentSeq == "")
    		currentSeq = String.valueOf(this.pageRecordCnt);
    	
    	Map<String, Object> param = new HashMap<String, Object>();
    	param.put("startIdx", 0);
    	param.put("endIdx", Integer.parseInt(currentSeq));
    	
        model.put("estimateRegList", requestService.getRequestList(param));
    	return "estimate/request/requestList";
    } 
    
    @RequestMapping(value="/listJson", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> listJson(@RequestBody String currentSeq)
    {
    	if(currentSeq == null || currentSeq == "")
    		return null;
    	
    	Map<String, Object> arrData = new HashMap<String, Object>();     	    	
    	arrData.put("startIdx", Integer.parseInt(currentSeq));
    	arrData.put("endIdx", this.pageRecordCnt);
    	
    	List<HashMap<String, Object>> list = requestService.getRequestList(arrData);    	
    	arrData.clear();    
    	
    	arrData.put("list", list);    	
    	arrData.put("currentSeq", currentSeq + 7);
    	
    	return arrData;
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
	    		message = "등록 중 오류가 발생했습니다";
		}
		
    	result.put("message", message);
    	return result;
    } 
    
    @RequestMapping("/detail")
    public String detail(@RequestParam int request_id, ModelMap model) {    	        	
    	// 조회수 업데이트
    	requestService.updateRequestHitCnt(request_id);
    	// 요구사항 상세
    	Map<String, Object> request = requestService.getRequestDetail(request_id);
    	// 견적서 등록리스트
    	List<HashMap<String, Object>> contract = contractService.getContractList(request_id, null);
    	
    	model.put("request", request);   	    	
    	model.put("contract", contract);
    	
        return "estimate/request/detail";
    }
    
    @RequestMapping(value="/updateContractStatus", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> updateContractStatus(@RequestBody RequestVO requestVO)
    {    	
    	String message = "success";
    	Map<String, Object> result = new HashMap<String, Object>();
    	
		SessionVO userInfo = storageService.getAuthenticatedUser();
		if(userInfo == null) {
			message = "로그인 후 등록할 수 있습니다";
		} else {			
	    	if(requestService.updateRequestStatus(requestVO) <= 0) {
	    		message = "상태 업데이트 중 오류가 발생했습니다";
	    	} else {
	    		if(requestVO.getStatus().equals("0002")) { // 확정
	    			ContractVO contractVO = new ContractVO();
	    			contractVO.setRequest_id(requestVO.getRequest_id());
	    			contractVO.setSalesman_id(requestVO.getSalesman_id());
	    			contractVO.setStatus(requestVO.getStatus());
	    			contractService.updateContractStatus(contractVO);
	    		}
	    	}
		}
		
    	result.put("message", message);
    	return result;
    }
    
    @RequestMapping(value="/app" ,method=RequestMethod.POST)
    public String appPost(@RequestParam String user_id,@RequestParam String user_pw,@RequestParam String user_hpid ,ModelMap model){

    	model.put("user_id", user_id);
    	model.put("user_pw", user_pw);   	
    	model.put("user_hpid", user_hpid);

    	System.out.println("HP >>>>>>>>>>>>>" + user_id);
    	System.out.println("HP >>>>>>>>>>>>>" + user_pw);
    	System.out.println("HP >>>>>>>>>>>>>" + user_hpid);
    	
    	// 사용자 찾기 .. 일반 회원인지 영업 사원인지..
    	/*
    	
		SELECT customer_id userId, customer_nm userNm, '' vendor_id, '' vendorLoc, '1' userType, mobile
		  FROM CUSTOMER
		 WHERE customer_id = 'sijm@naver.com'
		UNION
		SELECT salesman_id userId, salesman_nm userNm, vendor_id vendorId, location vendorLoc, '2' userType, mobile
		  FROM SALESMAN
		 WHERE salesman_id = 'sijm@naver.com'
		 
    	 */
    	// 있으면 해당 회원 타입으로 업데이트
    	
    	// 없으면 더미 사용자로 업데이트.. (이게 필요할려나 ...) 
    	
    	return "estimate/request/app";
    }
}
