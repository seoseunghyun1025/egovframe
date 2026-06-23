package egovframework.notice.dto;

import java.time.LocalDateTime;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NoticeFile {
	private Long fileId;
	private String noticeUuid;
	private String originalName;
	private String storedFileName;
	private Long fileSize;
	private LocalDateTime registryDate;
	private String delYn;
}
