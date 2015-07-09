global class ScheduledApex implements Schedulable {

	global void execute(SchedulableContext sc) {
		// 本来は SOQL などで取得する
		ID oppId = '0061000000Y9L3H';

		EmailTemplate template = [
			SELECT
				Name, Developername, Body
			FROM EmailTemplate
			WHERE DeveloperName = 'CustomVfTemplate' LIMIT 1
		];

		System.debug(LoggingLevel.INFO, UserInfo.getUserId());
		System.debug(LoggingLevel.INFO, template.Name);
		System.debug(LoggingLevel.INFO, template.DeveloperName);
		System.debug(LoggingLevel.INFO, template.Body);

		Messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
		// mail.setToAddresses(new List<String> { 'shingoyamazaki00@gmail.com' });
		mail.setTargetObjectId(UserInfo.getUserId());
		mail.setTemplateId(template.id);
		mail.setWhatId(oppId);
		mail.setSaveAsActivity(false);

		System.debug(LoggingLevel.INFO, mail.plainTextBody);

		Messaging.sendEmail(new List<Messaging.Email> { mail });
	}
}
