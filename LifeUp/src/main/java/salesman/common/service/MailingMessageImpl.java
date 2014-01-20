package salesman.common.service;

import org.springframework.beans.factory.annotation.Autowired;

import salesman.account.service.AccountService;
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;

public class MailingMessageImpl implements MailingMessage {
	
	@Autowired
	public AccountService accountService;
	
    public void setAccountService(AccountService accountService) {  
        this.accountService = accountService;  
    }
	
	private boolean useHtml = false;
	private String content = "";
	
	@Override
	public boolean useHtml() {
		return this.useHtml;
	}
	
	@Override
	public String getTextContent() {
		return content;
	}
	
	@Override
	public void setTextContent(String message) {			
		this.content = message;
		this.useHtml = false;
	}

	@Override
	public String getHtmlContent() {
		return content;
	}
	
	@Override
	public void setHtmlContent(String type, LoginVO user) {
		this.useHtml = true;	
		
		SessionVO userInfo = null;
		StringBuilder message = new StringBuilder();
		String newPasswd = "";
		
		userInfo = accountService.getUserByEmail(user);
		
		if(type.equals("ID")) {
			message.append("<span>");
			message.append(userInfo.getUserId()).append("님의 ID는 ");
			message.append("<b>").append(userInfo.getUserId()).append("</b>");
			message.append(" 입니다");
			message.append("</span>");
		} else {
			newPasswd = "12345";
			userInfo.setPassword(newPasswd);
			userInfo.setInitPwd(user.getInitPwd());
			accountService.modifyUserPasswd(userInfo);
			
			message.append("<div>");
			message.append(userInfo.getUserId()).append("님의 새로 발급된 비밀번호는 ");
			message.append("<b>").append(newPasswd).append("</b>");
			message.append(" 입니다");
			message.append("</div>");
			message.append("<div>");
			message.append("<a href='http://localhost:8080/account/ModifyPwd?userId=" + userInfo.getUserId() + "&userType=" + userInfo.getUserType() + "'><b>비밀번호 변경</b></a>");
			message.append("</div>");
			message.append("<div>");
			message.append("<a href='http://localhost:8080/login'><b>로그인</b></a>");
			message.append("</div>");
		}		
		
		StringBuilder sb = new StringBuilder();
		sb.append("<div>");
		sb.append("<span><b>" + message.toString() + "</b></span>");
		sb.append("</div>");
		
		this.content = sb.toString();
	}
}