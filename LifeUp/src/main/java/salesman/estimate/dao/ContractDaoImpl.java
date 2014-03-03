package salesman.estimate.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.estimate.ContractReplyVO;
import salesman.vo.estimate.ContractVO;

public class ContractDaoImpl extends SqlSessionDaoSupport implements ContractDao{
	
	@Override
	public List<HashMap<String, Object>> getContractList(int reqId, String userId) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reqId", reqId);
		param.put("salesman_id", userId);
		
		return getSqlSession().selectList("contract.getContractList", param);	
	}
	
	@Override
	public int registerContract(ContractVO contractVO) {
		return getSqlSession().insert("contract.registerContract", contractVO);		
	}
	
	@Override
	public int modifyContract(ContractVO contractVO) {
		return getSqlSession().update("contract.modifyContract", contractVO);		
	}	
	
	@Override
	public int registerContractReply(ContractReplyVO contractReplyVO) {
		return getSqlSession().insert("contract.registerContractReply", contractReplyVO);
	}
	
	@Override
	public List<HashMap<String, Object>> getContractReplyList(int request_id, String salesman_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("request_id", request_id);
		param.put("salesman_id", salesman_id);
		
		return getSqlSession().selectList("contract.getContractReplyList", param);	
	}		
	
	@Override
	public int updateContractStatus(ContractVO contractVO) {
		return getSqlSession().update("contract.updateContractStatus", contractVO);
	}
}
