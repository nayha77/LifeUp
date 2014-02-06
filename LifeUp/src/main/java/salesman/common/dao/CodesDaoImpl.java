package salesman.common.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class CodesDaoImpl extends SqlSessionDaoSupport implements CodesDao{

	@Override
	public List<HashMap<String, Object>> getVendorCodes() {
		List<HashMap<String, Object>> codes = new ArrayList<HashMap<String, Object>>();
		codes = getSqlSession().selectList("common.getVendorCodes");
		return codes;		
	}
}
