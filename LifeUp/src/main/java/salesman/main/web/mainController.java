package salesman.main.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import salesman.common.service.StorageService;

@Controller
public class mainController {
    @Autowired
    private StorageService storageService;
		           
    @RequestMapping("/main")
	public void main() { }         
}