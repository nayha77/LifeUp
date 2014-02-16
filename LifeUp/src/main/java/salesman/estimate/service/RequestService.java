package salesman.estimate.service;

import java.util.HashMap;
import java.util.List;

import salesman.model.EstimateReqVO;

public interface RequestService {
	public int EstimateReg(EstimateReqVO estimateReqVO);
	public List<HashMap<String, Object>> EstimateRegList(int currentSeq);
	public HashMap<String,Object> EstimateDetail(int reqID);
}
