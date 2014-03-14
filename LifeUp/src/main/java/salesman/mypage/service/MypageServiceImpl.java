package salesman.mypage.service;

import java.util.List;
import java.util.Map;

import salesman.mypage.dao.MypageDao;
import salesman.vo.mypage.MypageVO;

public class MypageServiceImpl implements MypageService {
	
	private MypageDao mypageDao;
 
	public void setMypageDao(MypageDao mypageDao) {
		this.mypageDao = mypageDao;
	}

	@Override
	public List<MypageVO> getMypagelist(String user_id) {
		
		List<MypageVO> Mypages = mypageDao.getMypagelist(user_id);

		return Mypages;
	}

	@Override
	public int getTotalCount(Map<String, String> params) {
		
		return mypageDao.getTotalCount(params);
	}

	@Override
	public int insertPushInfo(Map<String, String> params) {
		return mypageDao.insertPushInfo(params);
	}

	@Override
	public int updatePushInfo(Map<String, String> params) {
		return mypageDao.updatePushInfo(params);
	}

	@Override
	public Map<String, String> getOneDevice(String user_id) {
	
		return mypageDao.getOneDevice(user_id);
	}


	
}
