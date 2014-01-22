package salesman.vo.account;

import java.io.Serializable;

public class LoginVO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	/** 사용자 타입 (일본사용자/영업사원) */
	private int userType;
	/** 사용자 ID */
	private String userId;
	/** 이메일주소 */
	private String email;
	/** 비밀번호 */
	private String password;
	/** 비밀번호 초기화 유무*/
	private String initPwd;
	
	public int getUserType() {
		return userType;
	}
	public void setUserType(int userType) {
		this.userType = userType;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getInitPwd() {
		return initPwd;
	}
	public void setInitPwd(String initPwd) {
		this.initPwd = initPwd;
	}
}