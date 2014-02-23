package salesman.estimate.service;

import java.util.HashMap;
import java.util.List;

import salesman.estimate.dao.ContractDao;
import salesman.vo.estimate.ContractVO;

public class ContractServiceImpl implements ContractService {

	private ContractDao contractDao;	    
    
	public void setContractDao(ContractDao contractDao){
		this.contractDao = contractDao;
	}		
	
	@Override
	public List<HashMap<String, Object>> getContractDetail(int reqId, String userId) {
		return contractDao.getContractDetail(reqId, userId);
	}
	
	@Override
	public int registerContract(ContractVO contractVO) {
		return contractDao.registerContract(contractVO);
	}
	
	@Override
	public int modifyContract(ContractVO contractVO) {
		return contractDao.modifyContract(contractVO);
	}	
}
