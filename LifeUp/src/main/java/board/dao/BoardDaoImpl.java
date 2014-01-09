package board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class BoardDaoImpl extends SqlSessionDaoSupport implements iBoarddao{

	@Override
	public List<HashMap<String, Object>> selectTestTable() {
		// TODO Auto-generated method stub
		List<HashMap<String, Object>> testTableList = new ArrayList<HashMap<String,Object>>();
		testTableList = getSqlSession().selectList("main.getList");
		return testTableList;
	}
	
	

}
