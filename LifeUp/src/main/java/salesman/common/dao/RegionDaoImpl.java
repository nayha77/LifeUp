package salesman.common.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.model.Post;

public class RegionDaoImpl extends SqlSessionDaoSupport implements iRegiondao{

	@Override
	public List<HashMap<String, Object>> selectTestTable() {
		// TODO Auto-generated method stub
		List<HashMap<String, Object>> testTableList = new ArrayList<HashMap<String,Object>>();
		testTableList = getSqlSession().selectList("main.getList");
		return testTableList;
	}

	@Override
	public int writeProc(Post post) {
		// TODO Auto-generated method stub
		return getSqlSession().insert("main.formInsert",post);

	}

/*	@Override
	public String getView(String postNo) {
		// TODO Auto-generated method stub
		return getSqlSession().selectOne(postNo, "main.getView");
	}*/

	@Override
	public  Post getBoard(int num) {
		// TODO Auto-generated method stub
		
		//Post dto = (Post) getSqlSession().selectOne("main.getView",num);
		//System.out.println(dto.toString());
		return getSqlSession().selectOne("main.getView",num);
	}

	@Override
	public Post editing(Post post) {
		// TODO Auto-generated method stub
		return getSqlSession().selectOne("main.editPost",post);
	}

	@Override
	public int erase(Integer postNo) {
		// TODO Auto-generated method stub
		return getSqlSession().delete("main.erasePost",postNo);
	}
	
	

}
