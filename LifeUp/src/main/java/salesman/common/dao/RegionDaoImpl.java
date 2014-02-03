package salesman.common.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class RegionDaoImpl extends SqlSessionDaoSupport implements iRegiondao{

	@Override
	public List<HashMap<String, Object>> selectSidoTable() {
		List<HashMap<String, Object>> sidoTableList = new ArrayList<HashMap<String,Object>>();
		sidoTableList = getSqlSession().selectList("common.getSido");
		return sidoTableList;
	}

}
