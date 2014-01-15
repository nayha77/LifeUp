package salesman.login.service;

import salesman.vo.login.LoginVO;
import salesman.vo.login.SessionVO;

public interface AccountService {
	public boolean chkExistUser(LoginVO login);
	public SessionVO tryLogin(LoginVO login);
	public boolean modifyUserInfo(SessionVO userInfo);
}
