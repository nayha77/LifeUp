package salesman.estimate.dao;

import java.util.HashMap;
import java.util.List;
import salesman.model.EstimateReqVO;

public interface RequestDao {
	public int EstimateReg(EstimateReqVO estimateReqVO);
	
	public List<HashMap<String,Object>> EstimateRegList(int currentSeq);
	
	public  HashMap<String, Object> getEstimateDetail(int ReqId);
}
