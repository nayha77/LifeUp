package salesman.common.service;

import java.util.HashMap;
import java.util.List;


import salesman.common.dao.iRegiondao;

public class RegionSelectServiceImpl implements iRegionSelectService {
	
	private iRegiondao iRegiondao;

	public void setRegionServiceBean (iRegiondao iRegiondaoBean){
		this.iRegiondao = iRegiondaoBean;
	}

	@Override
	public List< HashMap<String, Object> > selectRegionSidoTable() {
		return iRegiondao.selectSidoTable();
	}

	@Override
	public List<HashMap<String, Object>> selectRegionGuTable() {
		// TODO Auto-generated method stub
		return null;
	}

}
