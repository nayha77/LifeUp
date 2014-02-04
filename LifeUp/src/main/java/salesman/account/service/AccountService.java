package salesman.account.service;

import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;

public interface AccountService {
	SessionVO getUserInfo(LoginVO login);
	SessionVO tryLogin(LoginVO login);
	
	boolean modifyUserInfo(SessionVO user);
	boolean modifyUserPasswd(SessionVO user);
	
	SessionVO getUserByEmail(LoginVO login);
	SessionVO getUserById(LoginVO login);
	
	boolean registerAccount(LoginVO userInfo);
}
