package salesman.estimate.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.estimate.RequestVO;

public class RequestDaoImpl extends SqlSessionDaoSupport implements RequestDao{
	
	@Override
	public int registerRequest(RequestVO estimateReqVO) {
		return getSqlSession().insert("request.registerRequest",estimateReqVO);
	}

	@Override
	public List<HashMap<String, Object>> getRequestList(int currentSeq) {
		List<HashMap<String, Object>> estimateReglist = new ArrayList<HashMap<String,Object>>();
		estimateReglist = getSqlSession().selectList("request.getRequestList", currentSeq);
		return estimateReglist;
	}
	
	@Override
	public  HashMap<String, Object> getRequestDetail(int ReqId) {
		return getSqlSession().selectOne("request.getRequestDetail",ReqId);
	}
}
