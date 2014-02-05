package salesman.main.web;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.common.define.RegionVo;
import salesman.common.service.RegionSelectImpl;
import salesman.common.service.StorageService;

@Controller
public class mainController {
    @Autowired
    private StorageService storageService;
    
    @Autowired
    private RegionSelectImpl regionService;
		           
    @RequestMapping("/main")
	public void main() { 
		//throw new CustomException("Biz error test message");
    }
    
    @RequestMapping("/selectBoxTest")
	public  String list(ModelMap model) {
         model.put("Sido", regionService.selectRegionSidoTable());
    	return "common/selectBox";
    }
    
    @ResponseBody
    @RequestMapping("/selectBoxTestJson")
	public ModelMap listJson(HttpServletRequest req,ModelMap model) throws UnsupportedEncodingException{
    	// vo 객체를 넘겨서 받아볼려고 했는데 자꾸 애러가 남;;;
    	// @ModelAttribute ( http://linuxism.tistory.com/651 )
    	//req.setCharacterEncoding("UTF-8");
 		String sido = req.getParameter("sido");
    	System.out.println("---sido---" + sido );
    	if( sido == null || sido.equals("") ){
    		model.put("Sido", regionService.selectRegionSidoTable());
    	}else{
    		model.put("Sido2", regionService.selectRegionGuTable(sido));
        	System.out.println("---else---" + model.toString());
    	}
    	System.out.println("----" + model.toString());
    	return model;
    }                 
}