package salesman.vo.push;

public class GCMData {

	private String text;
	private String param1;
	
	public GCMData() {}

	public GCMData(String text) {
		this.text = text;
	}
	
	public GCMData(String text, String param1) {
		this.text = text;
		this.param1 = param1;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getParam1() {
		return param1;
	}

	public void setParam1(String param1) {
		this.param1 = param1;
	}
	
	
}
