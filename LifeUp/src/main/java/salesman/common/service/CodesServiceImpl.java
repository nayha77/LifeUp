package salesman.common.service;

import java.util.HashMap;
import java.util.List;

import salesman.common.dao.CodesDao;

public class CodesServiceImpl implements CodesService  {

	private CodesDao codesDao;

	public void setCodesDao (CodesDao codesDao){
		this.codesDao = codesDao;
	}

	@Override
	public List<HashMap<String, Object>> getVendorCodes() {
		return codesDao.getVendorCodes();
	}
}
