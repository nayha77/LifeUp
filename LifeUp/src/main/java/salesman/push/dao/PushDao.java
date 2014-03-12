package salesman.push.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import salesman.vo.estimate.RequestVO;
import salesman.vo.push.Device;

public interface PushDao {
	

	public List<Device> getAllDevices();	
	
	public int getTotalCount(Map<String, String> params);
	
	public int updatePushInfo(Map<String, String> params);
	
	public int insertPushInfo(Map<String, String> params);

}
