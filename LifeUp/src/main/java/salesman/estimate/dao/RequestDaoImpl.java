package salesman.estimate.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import salesman.model.EstimateReqVO;

public class RequestDaoImpl extends SqlSessionDaoSupport implements RequestDao{
	
	@Override
	public int EstimateReg(EstimateReqVO estimateReqVO) {
		return getSqlSession().insert("request.EstimateReg",estimateReqVO);
	}

	@Override
	public List<HashMap<String, Object>> EstimateRegList(int currentSeq) {
		List<HashMap<String, Object>> estimateReglist = new ArrayList<HashMap<String,Object>>();
		estimateReglist = getSqlSession().selectList("request.estimateReglist", currentSeq);
		return estimateReglist;
	}
	
	@Override
	public  HashMap<String, Object> getEstimateDetail(int ReqId) {
		return getSqlSession().selectOne("request.getEstimateDetail",ReqId);
	}
}
