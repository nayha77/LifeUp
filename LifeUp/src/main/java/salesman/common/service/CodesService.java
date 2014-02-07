package salesman.common.service;

import java.util.HashMap;
import java.util.List;

import salesman.common.define.RegionVo;

public interface CodesService {	
	public List<HashMap<String, Object>> getVendorCodes();
	
	public List<RegionVo> selectRegionSidoTable();
	public List<RegionVo> selectRegionGuTable(String sido);
}
