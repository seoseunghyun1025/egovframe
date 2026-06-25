package egovframework.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.notice.dto.Notice;
import egovframework.notice.dto.SearchType;

public interface NoticeService {
	Notice noticeInfo(String notice);
	
	int noticeCount(Notice notice);
	
	void noticeList(Model model, Notice notice, int page);
	
	void selectSeach(Model model, SearchType type, String keyword, int page) throws Exception;
	
	int insertNotice(Notice notice, MultipartHttpServletRequest request, String noticeUuid) throws Exception;
	
	void updatePost(Notice notice) throws Exception;
	
	int deleteNotice(Notice notice) throws Exception;

	List<Map<String, Object>> selectFileList(String noticeUuid) throws Exception;	
	
	Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
	
	void deleteNoticeFile(String uuid) throws Exception; 
}
