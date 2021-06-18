public class CSVParser {

	public List<String> parse(String csvRow) {
		// FIXME: ダブルクォート(") で囲まれた値にも対応する
		return csvRow.split(',');
	}
}
