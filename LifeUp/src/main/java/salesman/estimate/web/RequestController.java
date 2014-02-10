package salesman.estimate.web;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
        model.put("estimateRegList", boardService.EstimateRegList());
    	return "estimate/request/requestList";
    } 
    
    @RequestMapping("/listJson")
    public @ResponseBody Map<String,Object> listJson(@RequestParam Map<String,Object> paramMap, ModelMap model)
    {
    	// 
        model.put("estimateRegListJson", boardService.EstimateRegList());
    	return model;
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
    

}