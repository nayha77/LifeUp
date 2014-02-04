package salesman.main.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.common.define.RegionVo;
import salesman.common.service.RegionSelectServiceImpl;
import salesman.common.service.StorageService;

@Controller
public class mainController {
    @Autowired
    private StorageService storageService;
    
    @Autowired
    private RegionSelectServiceImpl regionService;
		           
    @RequestMapping("/main")
	public void main() { 
		//throw new CustomException("Biz error test message");
    }
    
    @RequestMapping("/selectBoxTest")
	public  String list(ModelMap model) {
    		model.put("sidoone", "test");
          model.put("Sido", regionService.selectRegionSidoTable());
    	return "common/selectBox";
    }
    
    @RequestMapping("/selectBoxTestJson")
	public  @ResponseBody Map<?,?> listJson(ModelMap model){
          model.put("Sido", regionService.selectRegionSidoTable());
    	return model;
    }                 
}