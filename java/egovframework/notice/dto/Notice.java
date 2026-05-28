package egovframework.notice.dto;

import java.time.LocalDateTime;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import lombok.Data;

@Data
public class Notice {
	private static final Logger logger = LoggerFactory.getLogger(Notice.class);
	private int rowNum;
	private String postUuid;
	private String writeId;
	private String postTitle;
	private String postContent;
	private LocalDateTime registryDate;
	public Notice() {}
}