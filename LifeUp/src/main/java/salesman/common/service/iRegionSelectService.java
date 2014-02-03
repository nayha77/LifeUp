package salesman.common.service;

import java.util.HashMap;
import java.util.List;

public interface iRegionSelectService {
	
	public List<HashMap<String, Object>> selectRegionSidoTable();
	
	public List<HashMap<String, Object>> selectRegionGuTable();
	
}
