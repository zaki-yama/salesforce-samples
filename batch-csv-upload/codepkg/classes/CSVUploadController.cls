public class CSVUploadController {

	public Blob file {get; set;}

	// SCOPE_SIZE = バッチの execute に一度に渡される CSV ファイルの行数
	private static final Integer SCOPE_SIZE = 5;

	public PageReference readFile() {
		CSVUploadBatch batch = new CSVUploadBatch(file);

		Database.executeBatch(batch, SCOPE_SIZE);

		return null;
	}
}
