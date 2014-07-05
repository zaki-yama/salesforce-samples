@isTest
public class SendEmailTest {

	/**
	 * 失敗するケース
	 */
	public static testMethod void testSend_fail() {
		// メールの送信先になる
		Lead leadToSend = new Lead(
			Firstname = 'Akin',
			Lastname = 'Kristen',
			Company = 'Aethna Home Products',
			Email = 'a.kristen@example.jp'
		);
		insert leadToSend;

		Test.startTest();
		SendEmail mail = new SendEmail();
		mail.send(leadToSend.id);
		Test.stopTest();

		// assertion
		Lead result = [
			SELECT
				Id,
				( SELECT WhoId FROM ActivityHistories )
			FROM
				Lead
			WHERE
				Id = :leadToSend.id
		];

		// リードの活動履歴に追加されていることを確認
		System.assertEquals(1, result.activityHistories.size());
		System.assertEquals(leadToSend.id, result.activityHistories[0].whoId);
	}

	/**
	 * テスト成功例その1
	 * SeeAllData=trueアノテーションをつける
	 */
	@isTest(SeeAllData=true)
	public static void testSend_success1() {
		// メールの送信先になる
		Lead leadToSend = new Lead(
			Firstname = 'Akin',
			Lastname = 'Kristen',
			Company = 'Aethna Home Products',
			Email = 'a.kristen@example.jp'
		);
		insert leadToSend;

		Test.startTest();
		SendEmail mail = new SendEmail();
		mail.send(leadToSend.id);
		Test.stopTest();

		// assertion
		Lead result = [
			SELECT
				Id,
				( SELECT WhoId FROM ActivityHistories )
			FROM
				Lead
			WHERE
				Id = :leadToSend.id
		];

		// リードの活動履歴に追加されていることを確認
		System.assertEquals(1, result.activityHistories.size());
		System.assertEquals(leadToSend.id, result.activityHistories[0].whoId);
	}

	/**
	 * テスト成功例その1
	 * Taskによるアサーション
	 */
	@isTest
	public static void testSend_success2() {
		// メールの送信先になる
		Lead leadToSend = new Lead(
			Firstname = 'Akin',
			Lastname = 'Kristen',
			Company = 'Aethna Home Products',
			Email = 'a.kristen@example.jp'
		);
		insert leadToSend;

		Test.startTest();
		SendEmail mail = new SendEmail();
		mail.send(leadToSend.id);
		Test.stopTest();

		// assertion
		List<Task> results = [
			SELECT
				WhoId
			FROM
				Task
		];

		// リードの活動履歴に追加されていることを確認
		System.assertEquals(1, results.size());
		System.assertEquals(leadToSend.id, results[0].whoId);
	}

	/**
	 * テスト失敗例その2
	 * Dynamic SOQL (Database.query)を利用する
	 */
	public static testMethod void testSend_fail2() {
		// メールの送信先になる
		Lead leadToSend = new Lead(
			Firstname = 'Akin',
			Lastname = 'Kristen',
			Company = 'Aethna Home Products',
			Email = 'a.kristen@example.jp'
		);
		insert leadToSend;

		Test.startTest();
		SendEmail mail = new SendEmail();
		mail.send(leadToSend.id);
		Test.stopTest();

		// assertion
		ID whereId = leadToSend.id;
		Lead result = (Lead) Database.query(String.join(new List<String> {
			'SELECT',
				'Id,',
				'( SELECT WhoId FROM ActivityHistories )',
			'FROM',
				'Lead',
			'WHERE',
				'Id = :whereId'
		}, ' '));
		System.assertEquals(1, result.activityHistories.size());
		System.assertEquals(leadToSend.id, result.activityHistories[0].whoId);
	}

	/**
	 * テスト失敗例その3
	 * ViewAllData権限を持つユーザを取得し、System.runAsで実行
	 */
	public static testMethod void testSend_fail3() {
		// ViewAllData権限を持つユーザを取得
		Profile p = [SELECT Id FROM Profile WHERE PermissionsViewAllData = true LIMIT 1];

		User u = new User(
			Alias = 'sample',
			Email = 'sample.user@example.jp',
			EmailEncodingKey = 'UTF-8',
			LastName = 'Testing',
			LanguageLocaleKey = 'ja',
			LocaleSidKey = 'ja_JP',
			ProfileId = p.Id,
			TimeZoneSidKey = 'Asia/Tokyo',
			UserName = 'standarduser@dackdive.com'
		);
		insert u;

		ID whereId;
		Lead result;
		System.runAs(u) {
			// メールの送信先になる
			Test.startTest();
			Lead leadToSend = new Lead(
				Firstname = 'Akin',
				Lastname = 'Kristen',
				Company = 'Aethna Home Products',
				Email = 'a.kristen@example.jp'
			);
			insert leadToSend;
			whereId = leadToSend.id;

			SendEmail mail = new SendEmail();
			mail.send(leadToSend.id);
			Test.stopTest();

			// assertion
			result = [
				SELECT
					Id,
					( SELECT WhoId FROM ActivityHistories )
				FROM
					Lead
				WHERE
					Id = :whereId
			];
		}
		System.assertEquals(1, result.activityHistories.size());
		System.assertEquals(whereId, result.activityHistories[0].whoId);
	}
}
