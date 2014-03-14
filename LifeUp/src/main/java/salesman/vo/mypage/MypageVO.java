package salesman.vo.mypage;

import java.io.Serializable;

public class MypageVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int req_id; 			// content no
	private String customer_req; 
	private String status;
	private String create_date;
	private String user_id;   // login id
	
	
	@Override
	public String toString() {
		return "MypageVO [req_id=" + req_id + ", customer_req=" + customer_req
				+ ", status=" + status + ", create_date=" + create_date
				+ ", user_id=" + user_id + "]";
	}
	
	public int getReq_id() {
		return req_id;
	}
	public void setReq_id(int req_id) {
		this.req_id = req_id;
	}
	public String getCustomer_req() {
		return customer_req;
	}
	public void setCustomer_req(String customer_req) {
		this.customer_req = customer_req;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}




}
