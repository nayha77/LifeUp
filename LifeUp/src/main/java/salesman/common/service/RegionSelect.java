package salesman.common.service;

import java.util.List;

import salesman.common.define.RegionVo;

public interface RegionSelect {
	
	public List<RegionVo> selectRegionSidoTable();
	
	public List<RegionVo> selectRegionGuTable(String sido);
	
}
