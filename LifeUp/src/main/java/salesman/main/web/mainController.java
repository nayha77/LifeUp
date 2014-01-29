package salesman.main.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import salesman.common.service.StorageService;
import salesman.common.support.CustomException;

@Controller
public class mainController {
    @Autowired
    private StorageService storageService;
		           
    @RequestMapping("/main")
	public void main() { 
		//throw new CustomException("Biz error test message");
    }         
}