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
    //public String list(@RequestParam (value="currentSeq", required=false) String currentSeq, ModelMap model)
    public String list(@RequestParam (value="currentSeq", required=false) String currentSeq, 
    		@RequestParam (value="sidoCd", required=false) String sidoCd, 
    		@RequestParam (value="gugunCd", required=false) String gugunCd, 
    		@RequestParam (value="vendorCd", required=false) String vendorCd, 
    		@RequestParam (value="status_cd", required=false) String status_cd, ModelMap model) {
    	
    	if(currentSeq == null || currentSeq == "") {
    		currentSeq = String.valueOf(this.pageRecordCnt);
    	}
    	
    	Map<String, Object> args = new HashMap<String, Object>();
    	args.put("startIdx", 0);
    	args.put("endIdx", Integer.parseInt(currentSeq));
    	args.put("sido_cd", sidoCd != null ? (sidoCd.equals("") ? null : sidoCd) : null);
    	args.put("region_cd", gugunCd != null ? (gugunCd.equals("") ? null : gugunCd) : null);
    	args.put("vendor_id", vendorCd != null ? (vendorCd.equals("") ? null : vendorCd) : null);
    	args.put("status_cd", status_cd != null ? (status_cd.equals("") ? null : status_cd) : null);
    	
    	List<HashMap<String, Object>> requestList = requestService.getRequestList(args);
    	
        model.put("estimateRegList", requestList);        
        model.put("sidos", codeService.selectRegionSidoTable());
        model.put("venders", codeService.getVendorCodes());       
        model.put("listCnt", requestList.size());
    	
        return "estimate/request/requestList";    	
    } 
    
    @RequestMapping(value="/listJson", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> listJson(@RequestBody Map<String, Object> param)
    {
    	String currentSeq = param.get("currentSeq") == null ? "" : param.get("currentSeq").toString();
    	    	
    	if( currentSeq != null && !currentSeq.equals("") ) {    	     	   
    		param.put("startIdx", Integer.parseInt(currentSeq));
    		param.put("endIdx", this.pageRecordCnt);
    		param.put("sido_cd",   param.get("sido_cd").toString()   == "" ? null : param.get("sido_cd").toString());
        	param.put("region_cd", param.get("region_cd").toString() == "" ? null : param.get("region_cd").toString());
        	param.put("vendor_id", param.get("vendor_id").toString() == "" ? null : param.get("vendor_id").toString());    		
        	param.put("status_cd", param.get("status_cd").toString() == "" ? null : param.get("status_cd").toString());
	    	
	    	List<HashMap<String, Object>> list = requestService.getRequestList(param);	    	
	    	param.clear();
	    	
	    	param.put("list", list);    	
	    	param.put("currentSeq", String.valueOf(Integer.parseInt(currentSeq) + 7));
    	}
    	    	
    	return param;
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
}
