package salesman.push.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import salesman.push.service.PushService;
import salesman.vo.push.Device;
import salesman.vo.push.GCMData;
import salesman.vo.push.GCMMessage;

import com.google.gson.Gson;


@Controller
@RequestMapping("/push/*")
public class PushController {
	
	@Autowired
	private PushService pushService;
    
    @RequestMapping("/list")
    public String list(ModelMap model)
    {
        model.put("devices",pushService.getAllDevices());
    	return "push/pushList";
    } 
    
    @RequestMapping(value="/register" , method=RequestMethod.POST)
    public String Register(@RequestParam Map<String, String> params){
   		String message = "OK";
    	System.out.println("POST: " + params.size()); // prints POST: 0

          int totalCount = 0;
          totalCount = pushService.getTotalCount(params);
          if(totalCount <= 0){
  	    	if(pushService.insertPushInfo(params) <= 0)
	    		message = "등록 중 오류가 발생했습니다";
          }else{
   	    	if(pushService.updatePushInfo(params) <= 0)
 	    		message = "수정 중 오류가 발생했습니다";
          }
    	
    	return message;
    }
    
    @RequestMapping("/send")
    public String Send(@RequestParam String message,ModelMap model){

    	final String API_KEY = "AIzaSyBdrOLfBi04LKBEjjroVWZga4Ip0G4_JqI";
		
		// JSON 포맷으로 메시지 변환 준비
		GCMMessage gcmMessage = new GCMMessage();
		gcmMessage.setData(new GCMData(message));
		
		// 데이터베이스에서 registration_id를 전부 읽어 온다.
		
		List<Device> devices = pushService.getAllDevices();

		for(Device device : devices) {
			gcmMessage.addRegistrationId(device.getReg_Id());
		}
		
		// JSON으로 변환
		Gson gson = new Gson();
		String json = gson.toJson(gcmMessage);

		// 디버그 용
		System.out.println(json);
		
		// 메시지 전송 
		StringBuilder builder = new StringBuilder();
		try {
			CloseableHttpClient httpClient = HttpClients.createDefault();
			HttpPost httpPost = new HttpPost("https://android.googleapis.com/gcm/send");
			httpPost.addHeader("Content-Type", "application/json");
			httpPost.addHeader("Authorization", "key=" + API_KEY);
			StringEntity stringEntity = new StringEntity(json, "utf-8");
			httpPost.setEntity(stringEntity);
			
			CloseableHttpResponse response = httpClient.execute(httpPost);
			
			HttpEntity entity = response.getEntity();
			InputStream is = entity.getContent();
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			String line = null;
			while((line = br.readLine()) != null) {
				builder.append(line);
			}
			EntityUtils.consume(entity);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.put("result",builder.toString());		
    	return "push/result";    	
    }
 
}
