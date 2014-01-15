package salesman.vo.login;

import java.io.Serializable;

public class SessionVO implements Serializable{
	
	/** 사용자 타입 (일본사용자/영업사원) */
	private int userType;
	/** 사용자 ID */
	private String userId;
	/** 이름 */
	private String userNm;
	/** 이메일주소 */
	private String email;
	/** 업체 */
	private String vendorId;
	/** 소속 지점 */
	private String vendorLoc;
	
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
}