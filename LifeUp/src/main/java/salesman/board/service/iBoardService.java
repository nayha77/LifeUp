package salesman.board.service;

import java.util.HashMap;
import java.util.List;

import salesman.model.Post;

public interface iBoardService {
	
	public List<HashMap<String, Object>> selectTestTable();
	public int writeProc(Post post);
	public List<HashMap<String, Object>> getView(int num);
}
