package salesman.push.service;

import java.util.List;

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
	
}
