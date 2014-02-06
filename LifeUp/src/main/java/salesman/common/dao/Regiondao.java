package salesman.common.dao;

import java.util.List;
import java.util.Map;

import salesman.common.define.RegionVo;

public interface Regiondao {
	
	public List<RegionVo> selectSidoTable();
	
	public List<RegionVo> selectSidoTableMap();
	
	public List<RegionVo> selectGuTable(String sido);
	
	

}
