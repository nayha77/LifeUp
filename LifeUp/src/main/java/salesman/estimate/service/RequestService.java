package salesman.estimate.service;

import java.util.HashMap;
import java.util.List;

import salesman.vo.estimate.RequestVO;

public interface RequestService {
	public int registerRequest(RequestVO estimateReqVO);
	public List<HashMap<String, Object>> getRequestList(int currentSeq);
	public HashMap<String,Object> getRequestDetail(int reqID);
}
