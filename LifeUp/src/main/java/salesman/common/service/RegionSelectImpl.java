package salesman.common.service;

import java.util.List;

import salesman.common.dao.Regiondao;
import salesman.common.define.RegionVo;

public class RegionSelectImpl implements RegionSelect {
	
	private Regiondao iRegiondao;

	public void setRegionServiceBean (Regiondao iRegiondaoBean){
		this.iRegiondao = iRegiondaoBean;
	}

	@Override
	public List<RegionVo> selectRegionSidoTable() {
		return iRegiondao.selectSidoTable();
	}

	@Override
	public List<RegionVo> selectRegionGuTable(String sido) {
		return iRegiondao.selectGuTable(sido);
	}

}
