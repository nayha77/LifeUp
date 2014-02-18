package salesman.estimate.dao;

import java.util.HashMap;

import salesman.vo.estimate.ContractVO;

public interface ContractDao {
	public int registerContract(ContractVO contractVO);
	public int modifyContract(ContractVO contractVO);	
	public HashMap<String, Object> getContractDetail(int reqId);
}
