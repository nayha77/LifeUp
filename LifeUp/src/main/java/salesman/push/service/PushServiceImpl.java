package salesman.push.service;

import java.util.List;
import java.util.Map;

import salesman.push.dao.PushDao;
import salesman.vo.push.Device;

public class PushServiceImpl implements PushService {
	
	private PushDao pushDao1;
    
	public void setPushDao1(PushDao pushDao) {
		this.pushDao1 = pushDao;
	}

	@Override
	public List<Device> getAllDevices() {
		return pushDao1.getAllDevices();
	}

	@Override
	public int getTotalCount(Map<String, String> params) {
		
		return pushDao1.getTotalCount(params);
	}

	@Override
	public int insertPushInfo(Map<String, String> params) {
		return pushDao1.insertPushInfo(params);
	}

	@Override
	public int updatePushInfo(Map<String, String> params) {
		return pushDao1.updatePushInfo(params);
	}	
	
}
