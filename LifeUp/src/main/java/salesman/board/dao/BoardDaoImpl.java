package salesman.board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.model.EstimateReqVO;
import salesman.model.Post;

public class BoardDaoImpl extends SqlSessionDaoSupport implements Boarddao{

	@Override
	public List<HashMap<String, Object>> selectTestTable() {

		List<HashMap<String, Object>> testTableList = new ArrayList<HashMap<String,Object>>();
		testTableList = getSqlSession().selectList("main.getList");
		return testTableList;
	}

	@Override
	public int writeProc(Post post) {

		return getSqlSession().insert("main.formInsert",post);

	}

/*	@Override
	public String getView(String postNo) {

		return getSqlSession().selectOne(postNo, "main.getView");
	}*/

	@Override
	public  Post getBoard(int num) {

		
		//Post dto = (Post) getSqlSession().selectOne("main.getView",num);
		//System.out.println(dto.toString());
		return getSqlSession().selectOne("main.getView",num);
	}

	@Override
	public Post editing(Post post) {

		return getSqlSession().selectOne("main.editPost",post);
	}

	@Override
	public int erase(Integer postNo) {

		return getSqlSession().delete("main.erasePost",postNo);
	}

	@Override
	public int EstimateReg(EstimateReqVO estimateReqVO) {

		return getSqlSession().insert("request.EstimateReg",estimateReqVO);
	}

	@Override
	public List<HashMap<String, Object>> EstimateRegList() {
		List<HashMap<String, Object>> estimateReglist = new ArrayList<HashMap<String,Object>>();
		estimateReglist = getSqlSession().selectList("request.estimateReglist");
		return estimateReglist;
	}
	
	

}
