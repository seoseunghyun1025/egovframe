package egovframework.notice.dto;

import java.time.LocalDateTime;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
}