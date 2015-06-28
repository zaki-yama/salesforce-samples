public class HttpCallout {

	@future(callout=true)
	public static void sendVF() {
		String serviceUrl = '/services/apexrest/sendPDFEmail';
		String endpoint = URL.getSalesforceBaseUrl().toExternalForm() + serviceUrl;
		System.debug(LoggingLevel.INFO, endpoint);
		HttpRequest req = new HttpRequest();
		req.setEndpoint(endpoint);
		req.setMethod('POST');
		System.debug(LoggingLevel.INFO, UserInfo.getSessionId());
		req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
		req.setHeader('Content-Type','application/json');

		// パラメータを渡したい場合こうする
		ID oppId = '0061000000Y9L3H';
		Map<String,String> postBody = new Map<String,String>();
		postBody.put('oppId', oppId);
		String reqBody = JSON.serialize(postBody);

		req.setBody(reqBody);
		Http http = new Http();
		HttpResponse response = http.send(req);
		System.debug(LoggingLevel.INFO, response);
	}
}
