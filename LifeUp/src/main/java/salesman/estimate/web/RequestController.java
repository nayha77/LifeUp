package salesman.estimate.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.ModelMap;
import salesman.common.service.RegionSelectImpl;


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
    	model.put("sidos", regionService.selectRegionSidoTableMap());
        return "estimate/request/writeform";
    }

}