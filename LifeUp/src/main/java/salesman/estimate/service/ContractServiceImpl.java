package salesman.estimate.service;

import java.util.HashMap;

import salesman.estimate.dao.ContractDao;
import salesman.vo.estimate.ContractVO;

public class ContractServiceImpl implements ContractService {

	private ContractDao contractDao;	    
    
	public void setContractDao(ContractDao contractDao){
		this.contractDao = contractDao;
	}		
	
	@Override
	public HashMap<String, Object> getContractDetail(int reqId) {
		return contractDao.getContractDetail(reqId);
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
