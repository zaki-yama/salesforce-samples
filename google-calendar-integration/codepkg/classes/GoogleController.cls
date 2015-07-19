public class GoogleController {

	public AuthProvider provider { get; private set; }
	public String accessToken { get; private set; }

	public GoogleController() {
		this.provider = [SELECT Id, DeveloperName FROM AuthProvider WHERE DeveloperName = 'Google' LIMIT 1];
		this.accessToken = Auth.AuthToken.getAccessToken(provider.Id, 'open id connect');
		System.debug(LoggingLevel.INFO, this.accessToken);
	}

	private Map<String, Object> getUserInfo() {
		String endpoint = 'https://www.googleapis.com/plus/v1/people/me';

		//build HTTP Request with auth token
		HttpRequest req = new HttpRequest();
		req.setEndpoint(endpoint);
		req.setMethod('GET');
		req.setHeader('Authorization', 'Bearer ' + this.accessToken);
		HttpResponse res = new Http().send(req);
		Map<String, Object> info = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
		List<Object> emails =  (List<Object>) info.get('emails');
		Map<String, Object> calendarId = (Map<String, Object>) emails[0];

		return (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
	}
}
