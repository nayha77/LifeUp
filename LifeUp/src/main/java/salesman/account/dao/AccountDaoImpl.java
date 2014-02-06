package salesman.account.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;

public class AccountDaoImpl extends SqlSessionDaoSupport implements AccountDao {
	
	@Override
	public SessionVO getUserInfo(LoginVO login) {
		SessionVO userInfo;
		if(login.getUserType() == 1)
			userInfo = (SessionVO) getSqlSession().selectOne("account.getUserInfo", login);
		else
			userInfo = (SessionVO) getSqlSession().selectOne("account.getSalesmanInfo", login);
		
		return userInfo;
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
		int rtnValue = 0;
		if(user.getUserType() == 1)
			rtnValue = getSqlSession().update("account.modifyCustomerInfo", user);		
		else
			rtnValue = getSqlSession().update("account.modifySalesmanInfo", user);
			
		return rtnValue > 0 ? true : false;
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
	
	@Override
	public boolean registerAccount(LoginVO userInfo) {
		int rtnValue = 0;
		if(userInfo.getUserType() == 1)
			rtnValue = getSqlSession().update("account.registerCustomer", userInfo);		
		else
			rtnValue = getSqlSession().update("account.registerSalesman", userInfo);
			
		return rtnValue > 0 ? true : false;
	}
}
