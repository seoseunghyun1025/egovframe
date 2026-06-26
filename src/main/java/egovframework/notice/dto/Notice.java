package egovframework.notice.dto;

import java.time.LocalDateTime;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Notice {
	private int rowNum;
	private String noticeUuid;
	private String writeId;
	private String noticeTitle;
	private String noticeContent;
	private LocalDateTime registryDate;
	private Long noticeId;
	
	private String keyword;
	private SearchType type;
}