package egovframework.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.notice.dto.Notice;
import egovframework.notice.dto.SearchType;

public interface NoticeService {
	Notice noticeInfo(String notice);
	
	void noticeList(Model model, int page);
	
	void selectSearch(Model model, SearchType type, String keyword, int page) throws Exception;
	
	void insertNotice(Notice notice, MultipartHttpServletRequest request, String noticeUuid) throws Exception;
	
	void updatePost(Notice notice, MultipartHttpServletRequest request) throws Exception;
	
	int deleteNotice(Notice notice) throws Exception;

	List<Map<String, Object>> selectFileList(String noticeUuid) throws Exception;	
	
	Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
	
	void deleteNoticeFile(String id) throws Exception;
	
	void deleteNoticeFiles(String uuid) throws Exception;
}
