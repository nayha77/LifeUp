package salesman.estimate.service;

import java.util.HashMap;
import java.util.List;

import salesman.vo.estimate.ContractVO;

public interface ContractService {
	public int modifyContract(ContractVO contractVO);
	public int registerContract(ContractVO contractVO);
	public List<HashMap<String, Object>> getContractDetail(int reqId, String userId);
}
