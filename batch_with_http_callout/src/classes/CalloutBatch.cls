public class CalloutBatch implements Database.Batchable<SObject>, Database.Stateful, Database.AllowsCallouts {

	public Database.QueryLocator start(Database.BatchableContext bc) {
		// Date.today() はローカルタイムゾーン
		// CreatedDateはUTCで格納されている
		Date today = Datetime.now().dateGMT();
		return Database.getQueryLocator(String.join(new List<String> {
			'SELECT',
				'Subject,',
				'Priority,',
				'Description',
			'FROM',
				'Case',
			'WHERE',
				'CreatedDate >= :today',
			'AND',
				'Status != \'Closed\''
		}, ' '));
	}

	public void execute(Database.BatchableContext bc, List<Case> caseList) {
		for (Case c : caseList) {
			Map<String, String> request = new Map<String, String> {
				'title' => '[' + c.priority + ']' + c.subject,
				'body'  => c.description
			};
			// Httpコールアウトを行うクラスを呼び出す
			HttpResponse res = CalloutClass.executeCallout(request);

			if (res.getStatusCode() == 201) {
				c.status = 'Closed';
				update c;
				// リクエストが正常終了した時。省略
				System.debug(LoggingLevel.INFO, 'Issue was created successfully.');
				System.debug(LoggingLevel.INFO, 'STATUS:' + res.getStatus());
				System.debug(LoggingLevel.INFO, 'BODY:' + res.getBody());
			}
		}
	}

	public void finish(Database.BatchableContext bc) {
	}
}
