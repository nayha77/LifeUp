package salesman.account.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;

public class AccountDaoImpl extends SqlSessionDaoSupport implements AccountDao {
	
	@Override
	public SessionVO getUserInfo(LoginVO login) {
		SessionVO user = null;
		if(login.getUserType() == 1)
			user = (SessionVO) getSqlSession().selectOne("account.getUserInfo", login);
		else
			user = (SessionVO) getSqlSession().selectOne("account.getSalesmanInfo", login);
		
		return user;
	}
	
	@Override
	public SessionVO tryLogin(LoginVO login) {
		SessionVO user = null;
		if(login.getUserType() == 1)
			user = (SessionVO) getSqlSession().selectOne("account.getUser", login);		
		else
			user = (SessionVO) getSqlSession().selectOne("account.getSalesman", login);
		
		if(user != null)
			user.setUserType(login.getUserType());
		
		return user;
	}

	@Override
	public boolean modifyUserInfo(SessionVO user) {
		int result = getSqlSession().insert("account.userModify", user);
		
		return result == 0 ? false : true;
	}
	
	@Override
	public boolean modifyUserPasswd(SessionVO user) {
		int rtnValue = 0;
		if(user.getUserType() == 1)
			rtnValue = getSqlSession().update("account.modifyCustomerPasswd", user);		
		else
			rtnValue = getSqlSession().update("account.modifySalesmanPasswd", user);
			
		return rtnValue > 0 ? true : false;
	}
	
	@Override
	public SessionVO getUserByEmail(LoginVO login) {
		SessionVO user = null;		
		if(login.getUserType() == 1)
			user = (SessionVO) getSqlSession().selectOne("account.getUserByEmail", login);		
		else
			user = (SessionVO) getSqlSession().selectOne("account.getSalesmanByEmail", login);
		
		return user;
	}
	
	@Override
	public SessionVO getUserById(LoginVO login) {
		SessionVO user = null;		
		if(login.getUserType() == 1)
			user = (SessionVO) getSqlSession().selectOne("account.getUserById", login);		
		else
			user = (SessionVO) getSqlSession().selectOne("account.getSalesmanById", login);
		
		return user;
	}
}
