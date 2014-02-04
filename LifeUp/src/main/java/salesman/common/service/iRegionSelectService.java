package salesman.common.service;

import java.util.HashMap;
import java.util.List;

import salesman.common.define.RegionVo;

public interface iRegionSelectService {
	
	public List<RegionVo> selectRegionSidoTable();
	
	public List<HashMap<String, Object>> selectRegionGuTable();
	
}
