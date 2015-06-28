global class ScheduledApex implements Schedulable {

	global void execute(SchedulableContext sc) {
		// ここに直接 Http コールアウトの処理を書くとエラーになる
		HttpCallout.sendVF();
	}
}
