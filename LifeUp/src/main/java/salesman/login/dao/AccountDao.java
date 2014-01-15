package salesman.login.dao;

import salesman.vo.login.LoginVO;
import salesman.vo.login.SessionVO;

public interface AccountDao {
	public boolean chkExistUser(LoginVO login);
	public SessionVO tryLogin(LoginVO login);
	public boolean modifyUserInfo(SessionVO user);
}
