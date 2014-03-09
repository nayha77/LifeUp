package salesman.account.dao;

import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;

public interface AccountDao {
	SessionVO getUserInfo(LoginVO login);
	SessionVO tryLogin(LoginVO login);
	
	boolean modifyUserInfo(SessionVO user);
	boolean modifyUserPasswd(SessionVO user);
	
	SessionVO getUserById(LoginVO login);
	
	boolean registerAccount(LoginVO user);
	
	boolean modifyAppId(String userType, String userId, String appId);
}
