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
	public HashMap<String, Object> getRequestDetail(int ReqId) {
		// 견적의뢰 상세 가져오기
		return  requestDao.getRequestDetail(ReqId);
	}
	
	@Override
	public int registerRequest(RequestVO estimateReqVO) {
		return requestDao.registerRequest(estimateReqVO);
	}

	@Override
	public List<HashMap<String, Object>> getRequestList(int currentSeq) {
		// TODO Auto-generated method stub
		return requestDao.getRequestList(currentSeq);
	}	
}
