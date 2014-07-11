@isTest
public class CalloutBatchTest {

	public static testMethod void testExecute() {

		Case c = new Case(
			Subject = 'Sample Case',
			Description = 'This is a sample case to insert',
			Priority = 'Low'
		);
		insert c;

		Map<String, String> request = new Map<String, String> {
			'title' => '[' + c.priority + ']' + c.subject,
			'body'  => c.description
		};
		Test.startTest();
		// Test.setMockのかわりにこれを使う
		CalloutClass.mock = new CalloutMockImpl();
		Database.executeBatch(new CalloutBatch(), 1);
		Test.stopTest();

		// assertion
		List<Case> results = [SELECT IsClosed, Status FROM Case];
		System.assertEquals(1, results.size());
		System.assertEquals(true, results[0].isClosed);
	}
}
