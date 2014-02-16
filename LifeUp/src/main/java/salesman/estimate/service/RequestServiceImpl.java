package salesman.estimate.service;

import java.util.HashMap;
import java.util.List;

import salesman.estimate.dao.RequestDao;
import salesman.model.EstimateReqVO;

public class RequestServiceImpl implements RequestService {

	private RequestDao requestDao;	    
    
	public void setRequestDao(RequestDao requestDao){
		this.requestDao = requestDao;
	}	
	
	@Override
	public HashMap<String, Object> EstimateDetail(int ReqId) {
		// 견적의뢰 상세 가져오기
		return  requestDao.getEstimateDetail(ReqId);
	}
	
	@Override
	public int EstimateReg(EstimateReqVO estimateReqVO) {
		return requestDao.EstimateReg(estimateReqVO);
	}

	@Override
	public List<HashMap<String, Object>> EstimateRegList(int currentSeq) {
		// TODO Auto-generated method stub
		return requestDao.EstimateRegList(currentSeq);
	}	
}
