package salesman.estimate.dao;

import java.util.HashMap;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.estimate.ContractVO;

public class ContractDaoImpl extends SqlSessionDaoSupport implements ContractDao{
	
	@Override
	public HashMap<String, Object> getContractDetail(int reqId) {
		return getSqlSession().selectOne("contract.getContractDetail", reqId);	
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
