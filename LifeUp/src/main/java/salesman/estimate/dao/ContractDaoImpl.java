package salesman.estimate.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.estimate.ContractVO;

public class ContractDaoImpl extends SqlSessionDaoSupport implements ContractDao{
	
	@Override
	public List<HashMap<String, Object>> getContractDetail(int reqId, String userId) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reqId", reqId);
		param.put("salesman_id", userId);
		
		return getSqlSession().selectList("contract.getContractDetail", param);	
	}
	
	@Override
	public int registerContract(ContractVO contractVO) {
		return getSqlSession().insert("contract.registerContract", contractVO);		
	}
	
	@Override
	public int modifyContract(ContractVO contractVO) {
		return getSqlSession().update("contract.modifyContract", contractVO);		
	}	
}
