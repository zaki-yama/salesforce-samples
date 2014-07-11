public class CalloutClass {

	private static String USER_NAME = '*****Your GitHub username here*****';
	private static String PASSWORD  = '*****Your GitHub password here*****';
	private static String REPO_NAME = '*****Your GitHub repository name here*****';

	// モッククラス
	public static HttpCalloutMock mock = null;

	public static HttpResponse executeCallout(Map<String, String> request) {

		HttpRequest req = new HttpRequest();

		req.setMethod('POST');
		// Set Callout timeout
		req.setTimeout(60000);

		// Set HTTPRequest header properties
		req.setHeader('Connection','keep-alive');
		req.setEndpoint('https://api.github.com/repos/' + USER_NAME + '/' + REPO_NAME + '/issues');
		// Basic Authentification
		Blob headerValue = Blob.valueOf(USER_NAME + ':' + PASSWORD);
		String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
		req.setHeader('Authorization', authorizationHeader);

		// Set HTTPRequest body
		req.setBody(JSON.serialize(request));

		Http http = new Http();
		HttpResponse res;
		if (Test.isRunningTest() && (mock != null)) {
			// テスト時はこちらが実行される
			res = mock.respond(req);
		} else {
			res = http.send(req);
		}
		return res;
	}
}
