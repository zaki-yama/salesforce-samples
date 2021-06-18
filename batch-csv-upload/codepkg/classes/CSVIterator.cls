global with sharing class CSVIterator implements Iterator<String>, Iterable<String> {

	private String csvData;
	private String rowDelimiter;

	public CSVIterator(String fileData, String rowDelimiter) {
		this.csvData = fileData;
		this.rowDelimiter = rowDelimiter;
	}

	global Boolean hasNext() {
		return csvData.length() > 1 ? true : false;
	}

	global String next() {
		String row = this.csvData.subString(0, this.csvData.indexOf(this.rowDelimiter));
		// Delimiter の直後から CSV ファイルの末尾まで = 先頭1行だけ切り取り
		this.csvData = this.csvData.subString(
				this.csvData.indexOf(this.rowDelimiter) + this.rowDelimiter.length(),
				this.csvData.length()
				);
		return row;
	}

	public Iterator<String> Iterator() {
		return this;
	}
}
