package salesman.estimate.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.estimate.ContractVO;

public class ContractDaoImpl extends SqlSessionDaoSupport implements ContractDao{
	
	@Override
	public int registerContract(ContractVO contractVO) {
		return getSqlSession().insert("contract.registerContract", contractVO);		
	}
}
