package salesman.login.service;

import salesman.login.dao.AccountDao;
import salesman.vo.login.LoginVO;
import salesman.vo.login.SessionVO;

public class AccountServiceImpl implements AccountService {
	private AccountDao accountDao;
	
	public void setAccountDao(AccountDao accountDao){
		this.accountDao = accountDao;
	}

	@Override
	public boolean chkExistUser(LoginVO login) {		
		return this.accountDao.chkExistUser(login);
	}
	
	@Override
	public SessionVO tryLogin(LoginVO login) {
		SessionVO loginInfo = this.accountDao.tryLogin(login);			
		return loginInfo;
	}

	@Override
	public boolean modifyUserInfo(SessionVO userInfo) {
		return this.accountDao.modifyUserInfo(userInfo);
	}
	
	@Override
	public SessionVO getUserByEmail(LoginVO login) {
		return this.accountDao.getUserByEmail(login);
	}
	
	@Override
	public SessionVO getUserById(LoginVO login) {
		return this.accountDao.getUserById(login);
	}
}
