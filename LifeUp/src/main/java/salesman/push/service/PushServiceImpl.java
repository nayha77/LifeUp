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
		
		List<Device> devices = pushDao1.getAllDevices();
		for(Device device :devices){
			String phone = device.getPhone();
			device.setPhone(phone.substring(0,phone.length()-2)+"**");
			String regid = device.getReg_Id();
			device.setReg_Id(regid.substring(0,Math.min(regid.length(), 10)));
		}
		return devices;
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

	@Override
	public Map<String, String> getOneDevice(String user_id) {
	
		return pushDao1.getOneDevice(user_id);
	}


	
}
