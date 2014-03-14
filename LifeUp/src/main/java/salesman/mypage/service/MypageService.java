package salesman.mypage.service;

import java.util.List;
import java.util.Map;

import salesman.vo.mypage.MypageVO;

public interface MypageService {


	public Map<String, String> getOneDevice(String user_id);
	
	public int getTotalCount(Map<String, String> params);
	
	public int insertPushInfo(Map<String,String> params);
	
	public int updatePushInfo(Map<String,String> params);

	public List<MypageVO> getMypagelist(String user_id);

}
