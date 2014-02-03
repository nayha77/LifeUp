package salesman.main.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import salesman.common.service.RegionSelectServiceImpl;
import salesman.common.service.StorageService;
import salesman.common.service.iRegionSelectService;
import salesman.common.support.CustomException;

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
    	//System.out.println("============= " + regionService.selectRegionSidoTable());
        model.put("DBSido", regionService.selectRegionSidoTable());
        System.out.println("===========    ===================="+  model.toString());
        System.out.println("```````````````"+ model.size());
    	return "common/selectBox";
    }             
}