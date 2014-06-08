public class CaseTriggerHandler {

	public static void handleBeforeInsert(List<Case> caseList) {
		for (Case c : caseList) {
			System.debug(LoggingLevel.INFO, 'target case:' + c);

			Map<String, String> request = new Map<String, String> {
				'title' => '[' + c.priority + ']' + c.subject,
				'body'  => c.description
			};
			Case2IssueController.createIssue(request);
		}
	}
}
