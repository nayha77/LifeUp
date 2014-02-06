package salesman.estimate.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;

import salesman.common.service.RegionSelectImpl;
import salesman.model.EstimateRequestVo;

@Controller
@RequestMapping("/request/*")
public class RequestController {
	
    @Autowired
    private RegionSelectImpl regionService;	
	    
    @RequestMapping("/list")
    public String list() 
    {
    	return "estimate/request/requestList";
    }    
    
    @RequestMapping("/writeform")
    public String addForm(ModelMap model) {
    	model.put("sido", regionService.selectRegionSidoTableMap());
        return "estimate/request/writeform";
    }

}