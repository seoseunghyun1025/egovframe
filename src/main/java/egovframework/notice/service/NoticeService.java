package egovframework.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.notice.dto.Notice;

public interface NoticeService {
	Notice noticeInfo(String notice);
	
	int noticeCount(Notice notice);
	
	List<Notice> noticeList(Notice notice, int offset, int limitRow);
	
	int insertNotice(Notice notice, MultipartHttpServletRequest request, String noticeUuid) throws Exception;
	
	void updatePost(Notice notice) throws Exception;
	
	int deleteNotice(Notice notice) throws Exception;

	List<Map<String, Object>> selectFileList(String noticeUuid) throws Exception;	
}
