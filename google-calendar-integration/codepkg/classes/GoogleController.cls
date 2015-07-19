public class GoogleController {

	public AuthProvider provider { get; private set; }
	public String accessToken { get; private set; }

	public GoogleController() {
		this.provider = [SELECT Id, DeveloperName FROM AuthProvider WHERE DeveloperName = 'Google' LIMIT 1];
		this.accessToken = Auth.AuthToken.getAccessToken(provider.Id, 'open id connect');
		System.debug(LoggingLevel.INFO, this.accessToken);
	}
}
