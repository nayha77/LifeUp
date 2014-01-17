package salesman.login.dao;

import salesman.vo.login.LoginVO;
import salesman.vo.login.SessionVO;

public interface AccountDao {
	boolean chkExistUser(LoginVO login);
	SessionVO tryLogin(LoginVO login);
	boolean modifyUserInfo(SessionVO user);
	
	SessionVO getUserById(LoginVO login);
	SessionVO getUserByEmail(LoginVO login);
}
