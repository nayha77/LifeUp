package salesman.estimate.dao;

import java.util.HashMap;
import java.util.List;

import salesman.vo.estimate.RequestVO;

public interface RequestDao {
	public int registerRequest(RequestVO estimateReqVO);
	
	public HashMap<String, Object> getRequestDetail(int ReqId);
	public int updateRequestHitCnt(int ReqId);
	
	public List<HashMap<String,Object>> getRequestList(int currentSeq);
	public List<HashMap<String,Object>> getRequestListMore(int currentSeq);
	
	public int updateRequestStatus(RequestVO estimateReqVO);
}
