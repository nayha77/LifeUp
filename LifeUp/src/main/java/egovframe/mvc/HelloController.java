package egovframe.mvc;

import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HelloController extends SqlSessionDaoSupport {
    
    @RequestMapping("/hello")
    public void hello(@RequestParam(defaultValue="") String name
                    , Model model) {     
        model.addAttribute("name", name);
    }
    
    @RequestMapping("/today")
    public void today(@RequestParam Map<String,Object> paramMap, ModelMap modelMap) throws Throwable {     
    	//modelMap.put("today", (String)getSqlSession().selectOne("main.getList"));
    	modelMap.put("today", getSqlSession().selectOne("main.getList"));
    	
    	System.out.println("modelMap===============" + modelMap.toString());
    }
    
}
