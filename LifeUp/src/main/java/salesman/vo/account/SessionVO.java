package salesman.vo.account;

import java.io.Serializable;

public class SessionVO implements Serializable{
		
	private static final long serialVersionUID = 1L;
	
	/** 사용자 타입 (일본사용자/영업사원) */
	private int userType;
	/** 사용자 ID */
	private String userId;
	/** 이름 */
	private String userNm;
	/** 업체 */
	private String vendorId;
	/** 소속 지점 */
	private String vendorLoc;
	/** 핸드폰번호 */
	private String mobile;
	
	/** 이전 등록 비번 **/
	private String prevPassword;
	/** 비밀번호 (수정시 사용 ) */
	private String password;
	
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
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String name) {
		this.userNm = name;
	}
	public String getVendorId() {
		return vendorId;
	}
	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}
	public String getVendorLoc() {
		return vendorLoc;
	}
	public void setVendorLoc(String vendorLoc) {
		this.vendorLoc = vendorLoc;
	}
	public String getPrevPassword() {
		return prevPassword;
	}
	public void setPrevPassword(String prevPassword) {
		this.prevPassword = prevPassword;
	}	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}	
}