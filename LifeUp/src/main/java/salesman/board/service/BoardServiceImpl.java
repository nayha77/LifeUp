package salesman.board.service;

import java.util.HashMap;
import java.util.List;

import salesman.board.dao.Boarddao;
import salesman.model.EstimateReqVO;
import salesman.model.Post;

public class BoardServiceImpl implements BoardService {
	private Boarddao boarddao1;
	
	public void setBoarddao1(Boarddao boarddao1){
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

	@Override
	public int EstimateReg(EstimateReqVO estimateReqVO) {
		return boarddao1.EstimateReg(estimateReqVO);
	}

	@Override
	public List<HashMap<String, Object>> EstimateRegList(int currentSeq) {
		// TODO Auto-generated method stub
		return boarddao1.EstimateRegList(currentSeq);
	}

}
