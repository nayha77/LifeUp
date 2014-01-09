package board.service;

import java.util.HashMap;
import java.util.List;

import board.dao.iBoarddao;

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

}
