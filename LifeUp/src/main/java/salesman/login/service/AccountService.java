package salesman.login.service;

import salesman.vo.login.LoginVO;
import salesman.vo.login.SessionVO;

public interface AccountService {
	boolean chkExistUser(LoginVO login);
	SessionVO tryLogin(LoginVO login);
	boolean modifyUserInfo(SessionVO userInfo);
	
	SessionVO getUserByEmail(LoginVO login);
	SessionVO getUserById(LoginVO login);
}
