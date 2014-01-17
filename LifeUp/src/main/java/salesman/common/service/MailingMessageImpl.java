package salesman.common.service;

import org.springframework.beans.factory.annotation.Autowired;

import salesman.login.dao.AccountDao;
import salesman.vo.login.LoginVO;
import salesman.vo.login.SessionVO;

public class MailingMessageImpl implements MailingMessage {
	
	@Autowired
	public AccountDao accountDao;
	
    public void setAccountDao(AccountDao accountDao) {  
        this.accountDao = accountDao;  
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
		String message = "";
				
		userInfo = accountDao.getUserByEmail(user);
		
		if(type.equals("ID"))
			message = userInfo.getUserId() + "님의 ID는 " + userInfo.getUserId() + "입니다";
		else
			message = userInfo.getUserId() + "님의 새로 발급된 비밀번호는 **** 입니다. 접속 후 변경해주세요";
		
		StringBuilder sb = new StringBuilder();
		sb.append("<div>");
		sb.append("<span><b>" + message + "</b></span>");
		sb.append("</div>");
		
		this.content = sb.toString();
	}
}