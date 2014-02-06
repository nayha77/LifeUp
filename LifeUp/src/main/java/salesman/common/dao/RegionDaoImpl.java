package salesman.common.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.common.define.RegionVo;

public class RegionDaoImpl extends SqlSessionDaoSupport implements Regiondao{

	@Override
	public List<RegionVo> selectSidoTable() {
		List<RegionVo> sidoTableList = new ArrayList<RegionVo>();
		sidoTableList = getSqlSession().selectList("common.getSido");
		return sidoTableList;
	}

	@Override
	public List<RegionVo> selectGuTable(String sido) {
		List<RegionVo> guTableList = new ArrayList<RegionVo>();
		guTableList = getSqlSession().selectList("common.getGu",sido);
		return guTableList;
	}
	
	@Override
	public List<RegionVo> selectSidoTableMap() {
		List<RegionVo> sidoTableList = new ArrayList<RegionVo>();
		sidoTableList = getSqlSession().selectList("common.getSido"); 
		return sidoTableList; 
	}

}
