@RestResource(urlMapping='/sendPDFEmail/*')
global class SendPDFEmailRestService {

	@HttpPost
	global static void sendEmail(ID oppId) {
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		mail.setToAddresses(new List<String> { 'foo@example.com' });
		mail.setSubject('Mail Subject');
		mail.setPlainTextBody('Mail body');

		PageReference pr = Page.CustomVfPage;
		pr.getParameters().put('id', oppId);
		pr.setRedirect(true);

		Blob b = pr.getContent();

		Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
		efa.setFileName('添付書類.pdf');
		efa.setBody(b);

		mail.setFileAttachments(new List<Messaging.EmailFileAttachment> { efa });

		Messaging.sendEmail(new List<Messaging.Email> { mail });
	}
}
