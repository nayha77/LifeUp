package salesman.account.service;

import salesman.account.dao.AccountDao;
import salesman.common.util.FileScrty;
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
		
		String password = "";
		SessionVO loginInfo = null;
		
		try {			
			password = FileScrty.encryptPassword(login.getPassword());
			login.setPassword(password);
			
			loginInfo = this.accountDao.tryLogin(login);	
		} catch (Exception e) {
			return null;
		}		
		
		return loginInfo;
	}

	@Override
	public boolean modifyUserInfo(SessionVO userInfo) {
		String password = "";
		
		try {			
			if(userInfo.getPassword() != null) {
				password = FileScrty.encryptPassword(userInfo.getPassword());
				userInfo.setPassword(password);
			}
			
			this.accountDao.modifyUserInfo(userInfo);
			
			return true;
		} catch (Exception e) {
			return false;
		}		
	}	
	
	@Override
	public boolean modifyUserPasswd(SessionVO userInfo) {
		String password = "";
		
		try {			
			if(userInfo.getPassword() != null) {
				password = FileScrty.encryptPassword(userInfo.getPassword());
				userInfo.setPassword(password);
			}
			
			return this.accountDao.modifyUserPasswd(userInfo);
		} catch (Exception e) {
			return false;
		}
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
