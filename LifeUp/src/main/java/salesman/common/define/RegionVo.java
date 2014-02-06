package salesman.common.define;

public class RegionVo {
	
	String sido;
	String gugun;
	
	public String getGugun() {
		return gugun;
	}

	public void setGugun(String gugun) {
		this.gugun = gugun;
	}

	public String getSido() {
		return sido;
	}

	public void setSido(String sido) {
		this.sido = sido;
	}

	@Override
	public String toString() {
		return "RegionVo [sido=" + sido + ", gugun=" + gugun + "]";
	}
	
	

}
