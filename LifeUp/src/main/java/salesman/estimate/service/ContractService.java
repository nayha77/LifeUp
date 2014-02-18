package salesman.estimate.service;

import java.util.HashMap;

import salesman.vo.estimate.ContractVO;

public interface ContractService {
	public int modifyContract(ContractVO contractVO);
	public int registerContract(ContractVO contractVO);
	public HashMap<String, Object> getContractDetail(int reqId);
}
