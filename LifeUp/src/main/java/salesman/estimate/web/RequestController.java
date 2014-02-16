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

import salesman.board.service.BoardService;
import salesman.common.service.CodesService;
import salesman.model.EstimateReqVO;


@Controller
@RequestMapping("/request/*")
public class RequestController {
	
	@Autowired
	private BoardService boardService;
	
    @Autowired
    private  CodesService codeService;	
	    
    @RequestMapping("/list")
    public String list( ModelMap model)
    {
    	int currentSeq = 0;
        model.put("estimateRegList", boardService.EstimateRegList(currentSeq));
    	return "estimate/request/requestList";
    } 
    
    @RequestMapping(value="/listJson", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> listJson(@RequestBody int currentSeq)
    {
    	Map<String, Object> result = new HashMap<String, Object>();    	
    	List<HashMap<String, Object>> list = boardService.EstimateRegList(currentSeq);    	
    	    
    	result.put("list", list);    	
    	result.put("currentSeq", currentSeq + 2);
    	
    	return result;
    }     
    
    @RequestMapping("/writeform")
    public String addForm(ModelMap model) {
    	model.put("sidos", codeService.selectRegionSidoTable());
    	model.put("venders", codeService.getVendorCodes());
        return "estimate/request/writeform";
    }
    // 견적의뢰 등록
    @RequestMapping("/regform")
    public String writing(EstimateReqVO estimateReqVO, ModelMap model) {
    	estimateReqVO.setCar_model("뭐델");
    	estimateReqVO.setCar_option("carop");
    	int wireResult = boardService.EstimateReg(estimateReqVO);
        return "estimate/request/requestList";
    }
    
    @RequestMapping("/detail")
    public String detail(@RequestParam Integer ID ,ModelMap model) {
    	Map<String, Object> result = new HashMap<String, Object>();  
    	result = boardService.EstimateDetail(ID);
    	model.put("result", result);
        return "estimate/request/detail";
    }
    

}