global class ScheduledApex implements Schedulable {

	global void execute(SchedulableContext sc) {
		// メール
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		mail.setToAddresses(new List<String> { 'shingoyamazaki00@gmail.com' });
		mail.setSubject('Mail Subject');
		mail.setPlainTextBody('Mail body');

		ID oppId = '0061000000Y9L3H';
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
