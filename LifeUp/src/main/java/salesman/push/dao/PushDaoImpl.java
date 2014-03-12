package salesman.push.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.push.Device;



public class PushDaoImpl extends SqlSessionDaoSupport implements PushDao{

	@Override
	public List<Device> getAllDevices() {
		return getSqlSession().selectList("push.getPushList");
	}
	

}
