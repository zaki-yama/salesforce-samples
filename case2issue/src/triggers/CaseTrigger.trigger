trigger CaseTrigger on Case (before insert) {

	if (Trigger.isBefore && Trigger.isInsert) {
		CaseTriggerHandler.handleBeforeInsert(Trigger.new);
	}
}
