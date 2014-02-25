package salesman.estimate.service;

import java.util.HashMap;
import java.util.List;

import salesman.estimate.dao.RequestDao;
import salesman.vo.estimate.RequestVO;

public class RequestServiceImpl implements RequestService {

	private RequestDao requestDao;	    
    
	public void setRequestDao(RequestDao requestDao){
		this.requestDao = requestDao;
	}	
	
	@Override
	public int registerRequest(RequestVO estimateReqVO) {
		return requestDao.registerRequest(estimateReqVO);
	}

	@Override
	public HashMap<String, Object> getRequestDetail(int ReqId) {
		return  requestDao.getRequestDetail(ReqId);
	}
	
	@Override
	public List<HashMap<String, Object>> getRequestList(int currentSeq) {
		return requestDao.getRequestList(currentSeq);
	}	
	
	@Override
	public List<HashMap<String, Object>> getRequestListMore(int currentSeq) {
		return requestDao.getRequestListMore(currentSeq);
	}	
}
