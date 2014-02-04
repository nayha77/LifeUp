package salesman.common.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.common.define.RegionVo;

public class RegionDaoImpl extends SqlSessionDaoSupport implements iRegiondao{

	@Override
	public List<RegionVo> selectSidoTable() {
		List<RegionVo> sidoTableList = new ArrayList<RegionVo>();
		sidoTableList = getSqlSession().selectList("common.getSido");
		return sidoTableList;
	}

}
