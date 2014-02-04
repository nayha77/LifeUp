package salesman.common.service;

import java.util.HashMap;
import java.util.List;



import salesman.common.dao.iRegiondao;
import salesman.common.define.RegionVo;

public class RegionSelectServiceImpl implements iRegionSelectService {
	
	private iRegiondao iRegiondao;

	public void setRegionServiceBean (iRegiondao iRegiondaoBean){
		this.iRegiondao = iRegiondaoBean;
	}

	@Override
	public List<RegionVo> selectRegionSidoTable() {
		return iRegiondao.selectSidoTable();
	}

	@Override
	public List<HashMap<String, Object>> selectRegionGuTable() {
		// TODO Auto-generated method stub
		return null;
	}

}
