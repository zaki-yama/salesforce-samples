public class SendEmail {

	private static final String SUBJECT = 'Sample Email';

	private static final String BODY = 'Hi, This is a sample email.';

	public void send(Id targetObjId) {
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		// 件名、本文、送信先をセット
		mail.setSubject(SUBJECT);
		mail.setPlainTextBody(BODY);
		mail.setTargetObjectId(targetObjId);
		// 活動履歴に残す
		mail.setSaveAsActivity(true);

		// 送信
		Messaging.sendEmail(new List<Messaging.SingleEmailMessage> { mail });
	}
}
