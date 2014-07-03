public class MultiRecordProcessController {

	List<MyObj__c> myObjList {get; set;}

	ApexPages.StandardSetController controller {get; set;}

	public MultiRecordProcessController(ApexPages.StandardSetController controller) {
		System.debug(LoggingLevel.INFO, controller);
		this.controller = controller;
	}

	public PageReference execute() {
		this.myObjList = (List<MyObj__c>) this.controller.getSelected();
		System.debug(LoggingLevel.INFO, this.controller.getSelected());

		// オブジェクトMyObj__cのフィールドText__cを変更する
		for (MyObj__c myObj : this.myObjList) {
			System.debug(LoggingLevel.INFO, myObj);
			myObj.text__c = 'CHANGED';
		}
		update this.myObjList;

		String prevURL = '/' + System.currentPageReference().getParameters().get('retUrl');
		PageReference prevPage = new PageReference(prevURL);
		return prevPage;
		return null;
	}
}
