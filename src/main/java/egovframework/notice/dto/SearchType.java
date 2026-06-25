package egovframework.notice.dto;

public enum SearchType {
	TITLE("NOTICE_TITLE"),
	WRITER("WRITE_ID");
	
	private final String column;
	
	SearchType(String column){
		this.column = column;
	}
	
	public String getColumn() {
		return this.column;
	}
}
