package salesman.common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import salesman.common.define.RegionVo;
import salesman.model.Post;

public interface Regiondao {
	
	public List<RegionVo> selectSidoTable();
	
	public List<RegionVo> selectGuTable(String sido);

}
