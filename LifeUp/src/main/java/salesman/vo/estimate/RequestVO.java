package salesman.vo.estimate;

public class RequestVO {
	
	private String customer_id;
	private String region_cd;
	private String car_id;
	private String car_trim;
	private String car_option;
	private String customer_region;
	private String customer_req;	
	private String status;
	
	public String getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}
	public String getRegion_cd() {
		return region_cd;
	}
	public void setRegion_cd(String region_cd) {
		this.region_cd = region_cd;
	}
	public String getCar_id() {
		return car_id;
	}
	public void setCar_id(String car_id) {
		this.car_id = car_id;
	}
	public String getCar_model() {
		return car_trim;
	}
	public void setCar_trim(String car_trim) {
		this.car_trim = car_trim;
	}
	public String getCar_option() {
		return car_option;
	}
	public void setCar_option(String car_option) {
		this.car_option = car_option;
	}
	public String getCustomer_region() {
		return customer_region;
	}
	public void setCustomer_region(String customer_region) {
		this.customer_region = customer_region;
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
	}}
