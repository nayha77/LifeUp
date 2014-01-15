package salesman.login.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.login.LoginVO;
import salesman.vo.login.SessionVO;

public class AccountDaoImpl extends SqlSessionDaoSupport implements AccountDao {
	
	@Override
	public boolean chkExistUser(LoginVO login) {
		String userId = "";
		if(login.getUserType() == 1)
			userId = (String) getSqlSession().selectOne("login.chkUserCheck", login.getUserId());
		else
			userId = (String) getSqlSession().selectOne("login.chkSalesman", login.getUserId());
		
		return userId == null ? false : true;
	}
	
	@Override
	public SessionVO tryLogin(LoginVO login) {
		SessionVO user = null;
		if(login.getUserType() == 1)
			user = (SessionVO) getSqlSession().selectOne("login.getUser", login);		
		else
			user = (SessionVO) getSqlSession().selectOne("login.getSalesman", login);
		
		if(user != null)
			user.setUserType(login.getUserType());
		
		return user;
	}

	@Override
	public boolean modifyUserInfo(SessionVO user) {
		int result = getSqlSession().insert("login.userModify", user);
		
		return result == 0 ? false : true;
	}
}
