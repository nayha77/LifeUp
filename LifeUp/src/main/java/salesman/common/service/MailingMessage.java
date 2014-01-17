package salesman.common.service;

import salesman.vo.login.LoginVO;

public interface MailingMessage {
	boolean useHtml();
	
	String getTextContent();
	void setTextContent(String message);	
	
	String getHtmlContent();
	void setHtmlContent(String type, LoginVO user);
}
