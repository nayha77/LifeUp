package salesman.estimate.service;

import salesman.estimate.dao.ContractDao;
import salesman.vo.estimate.ContractVO;

public class ContractServiceImpl implements ContractService {

	private ContractDao contractDao;	    
    
	public void setContractDao(ContractDao contractDao){
		this.contractDao = contractDao;
	}		
	
	@Override
	public int registerContract(ContractVO contractVO) {
		return contractDao.registerContract(contractVO);
	}
}
