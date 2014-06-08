public class Case2IssueController {

	private static String USER_NAME = '*****Your GitHub username here*****';
	private static String PASSWORD  = '*****Your GitHub password here*****';
	private static String REPO_NAME = '*****Your GitHub repository name here*****';

	@future (callout=true)
	public static void createIssue(Map<String, String> request) {

		HttpRequest req = new HttpRequest();

		req.setMethod('POST');

		// Set Callout timeout
		// default: 10 secs(that often causes "System.CalloutException: Read timed out")
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

		try {
			// Execute Http Callout
			HTTPResponse res = http.send(req);

			System.debug(LoggingLevel.INFO, res.toString());
			System.debug(LoggingLevel.INFO, 'STATUS:' + res.getStatus());
			System.debug(LoggingLevel.INFO, 'STATUS_CODE:' + res.getStatusCode());
			System.debug(LoggingLevel.INFO, 'BODY:' + res.getBody());

		} catch(System.CalloutException e) {
			// Exception handling goes here....
			System.debug(LoggingLevel.INFO, e);
		}
	}
}
