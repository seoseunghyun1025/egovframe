package egovframework.notice.dto;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class NoticeSearch {
	private String keyword;
	private SearchType type;
}
