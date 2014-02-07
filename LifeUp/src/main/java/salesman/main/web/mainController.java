package salesman.main.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.common.service.CodesService;
import salesman.common.service.StorageService;

@Controller
public class mainController {
    @Autowired
    private StorageService storageService;
    
    @Autowired
    private CodesService codeService;
		           
    @RequestMapping("/main")
	public void main() { 
		//throw new CustomException("Biz error test message");
    }
    
    @RequestMapping("/selectBoxTest")
	public  String list(ModelMap model) {
         model.put("Sido", codeService.selectRegionSidoTable());
    	return "common/selectBox";
    }
    
    @RequestMapping("/selectBoxTestJson")
	public @ResponseBody Map<String, Object> listJson(@RequestBody String sido, HttpServletRequest request) {
    	Map<String, Object> result = new HashMap<String, Object>();
    	
    	if( sido == null || sido.equals("") ){
    		result.put("Sido", codeService.selectRegionSidoTable());
    	}else{
    		result.put("Sido2", codeService.selectRegionGuTable(sido));
    	}

    	return result;
    }                         
}