package salesman.common.define;

public class RegionVo {
	
	String sido;
	String region_cd;
	String gugun;
	
	public String getRegion_cd() {
		return region_cd;
	}
	
	public void setRegion_cd(String region_cd) {
		this.region_cd = region_cd;
	}
	
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
