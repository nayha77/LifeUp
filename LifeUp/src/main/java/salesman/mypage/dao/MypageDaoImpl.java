package salesman.mypage.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.mypage.MypageVO;



public class MypageDaoImpl extends SqlSessionDaoSupport implements MypageDao{

	@Override
	public Map<String, String> getOneDevice(String user_id) {
		return getSqlSession().selectOne("push.getOneDevice",user_id);
	}

	@Override
	public int getTotalCount(Map<String, String> params) {
		return getSqlSession().selectOne("push.getTotalCount" , params);
	}

	@Override
	public int updatePushInfo(Map<String, String> params) {
		return getSqlSession().insert("push.updatePushInfo", params);
	}

	@Override
	public int insertPushInfo(Map<String, String> params) {
		return getSqlSession().insert("push.insertPushInfo", params);
	}

	@Override
	public List<MypageVO> getMypagelist(String user_id) {
		return getSqlSession().selectList("mypage.getMyList",user_id);
	}


	

}
