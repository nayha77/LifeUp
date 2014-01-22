package salesman.board.service;

import java.util.HashMap;
import java.util.List;

import salesman.board.dao.iBoarddao;
import salesman.model.Post;

public class BoardServiceImpl implements iBoardService {
	private iBoarddao boarddao1;
	
	public void setBoarddao1(iBoarddao boarddao1){
		this.boarddao1 = boarddao1;
	}

	@Override
	public List<HashMap<String, Object>> selectTestTable() {
		// TODO Auto-generated method stub
		return boarddao1.selectTestTable();
	}

	@Override
	public int writeProc(Post post) {
		// TODO Auto-generated method stub
		return boarddao1.writeProc(post);
	}

/*	@Override
	public String getView(String postNo) {
		// TODO Auto-generated method stub
		return  boarddao1.getView(postNo);
	}*/

	@Override
	public Post getView(int num) {
		// TODO Auto-generated method stub
		return  boarddao1.getBoard(num);
	}

	@Override
	public Post editing(Post post) {
		// TODO Auto-generated method stub
		return boarddao1.editing(post);
	}

	@Override
	public int erase(Integer postNo) {
		return boarddao1.erase(postNo);
		
	}

}
