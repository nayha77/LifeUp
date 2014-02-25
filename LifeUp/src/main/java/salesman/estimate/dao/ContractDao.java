package salesman.estimate.dao;

import java.util.HashMap;
import java.util.List;

import salesman.vo.estimate.ContractVO;

public interface ContractDao {
	public int registerContract(ContractVO contractVO);
	public int modifyContract(ContractVO contractVO);	
	public List<HashMap<String, Object>> getContractDetail(int reqId, String userId);
}
