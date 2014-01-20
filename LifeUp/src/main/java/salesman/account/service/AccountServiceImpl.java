package salesman.account.service;

import salesman.account.dao.AccountDao;
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;

public class AccountServiceImpl implements AccountService {
	private AccountDao accountDao;
	
	public void setAccountDao(AccountDao accountDao){
		this.accountDao = accountDao;
	}

	@Override
	public SessionVO getUserInfo(LoginVO login) {		
		SessionVO loginInfo = this.accountDao.getUserInfo(login);
		return loginInfo;
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
	public boolean modifyUserPasswd(SessionVO userInfo) {
		return this.accountDao.modifyUserPasswd(userInfo);
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
