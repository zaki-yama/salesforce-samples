global with sharing class CSVUploadBatch implements Database.Batchable<String>, Database.Stateful {

	private String csvFile;
	private CSVParser parser = new CSVParser();
	private static final String CRLF = '\n';

	public CSVUploadBatch(Blob file) {
		this.csvFile = file.toString();
	}

	global Iterable<String> start(Database.batchableContext batchableContext) { 
		return new CSVIterator(csvFile, CRLF);
	}

	global void execute(Database.BatchableContext batchableContext, List<String> scope) {
		System.debug(LoggingLevel.INFO, 'execute');
		System.debug(LoggingLevel.INFO, scope.size());

		for (String csvRow : scope) {
			List<String> values = this.parser.parse(csvRow);

			// 処理
			for (String value : values) {
				System.debug(LoggingLevel.INFO, value);
			}
		}
	}

	global void finish(Database.BatchableContext batchableContext) {
	}
}
