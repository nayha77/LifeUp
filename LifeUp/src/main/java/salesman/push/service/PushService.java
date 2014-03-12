package salesman.push.service;

import java.util.List;
import java.util.Map;

import salesman.vo.push.Device;

public interface PushService {


	public List<Device> getAllDevices();	
	
	public int getTotalCount(Map<String, String> params);
	
	public int insertPushInfo(Map<String,String> params);
	
	public int updatePushInfo(Map<String,String> params);

}
