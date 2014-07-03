global class MultiRecordProcessWebService {

	webservice static boolean deleteByIds(List<ID> idList) {
		List<MyObj__c> recordList = [SELECT Id FROM MyObj__c WHERE Id IN :idList];
		delete recordList;
		return true;
	}
}
