package salesman.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import salesman.model.EstimateReqVO;
import salesman.model.Post;

public interface Boarddao {
	
	public List<HashMap<String,Object>> selectTestTable();
	
	public int writeProc(Post post);
	
	//public String getView(String postNo);
	 public Post getBoard(int num); //읽기

	public Post editing(Post post);

	public int erase(Integer postNo);
	
	public int EstimateReg(EstimateReqVO estimateReqVO);
	
	public List<HashMap<String,Object>> EstimateRegList(int currentSeq);
	

}
