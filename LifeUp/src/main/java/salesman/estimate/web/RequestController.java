package salesman.estimate.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/request/*")
public class RequestController {
	    
    @RequestMapping("/list")
    public String list() 
    {
    	return "estimate/request/requestList";
    }    
    
    @RequestMapping(value="/write", method=RequestMethod.GET)
    public String write(
            Integer articleNo, 
            String boardCd, 
            Integer curPage, 
            String searchWord, 
            Model model) throws Exception {
         
        //게시판 이름
        String boardNm = boardService.getBoardNm(boardCd);
        model.addAttribute("boardNm", boardNm);
         
        return "bbs/writeform";
    }    
}