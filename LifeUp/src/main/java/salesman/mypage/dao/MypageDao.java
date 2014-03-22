package salesman.mypage.dao;

import java.util.List;
import java.util.Map;

import salesman.vo.mypage.MypageVO;

public interface MypageDao {
	

		
	public Map<String, String> getOneDevice(String user_id);
	
	public int getTotalCount(Map<String, String> params);
	
	public int updatePushInfo(Map<String, String> params);
	
	public int insertPushInfo(Map<String, String> params);

	public List<MypageVO> getMypagelist(String user_id);
	
	public List<MypageVO> getMypageSellerList(String user_id);
	
	public int passchk_customer(Map<String, Object> passMap);

	public int passchk(Map<String, Object> passMap);


}
