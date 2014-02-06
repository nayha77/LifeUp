package salesman.common.service;

import java.util.List;
import java.util.Map;

import salesman.common.define.RegionVo;

public interface RegionSelect {

	public List<RegionVo> selectRegionSidoTableMap();
	
	public List<RegionVo> selectRegionSidoTable();
	
	public List<RegionVo> selectRegionGuTable(String sido);
	
}
