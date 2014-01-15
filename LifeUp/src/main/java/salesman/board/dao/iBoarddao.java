package salesman.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import salesman.model.Post;

public interface iBoarddao {
	
	public List<HashMap<String,Object>> selectTestTable();
	
	public int writeProc(Post post);
	
	//public String getView(String postNo);
	 public List<HashMap<String, Object>> getBoard(int num); //읽기
	

}
