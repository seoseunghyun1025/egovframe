package egovframework.notice.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import egovframework.notice.dto.Notice;

public interface NoticeService {
	Notice noticeInfo(Notice notice);
	
	int noticeCount(Notice notice);
	
	List<Notice> noticeList(Notice notice, int offset, int limitRow);
	
	int insertNotice(Notice notice) throws Exception;
	
	int updatePost(Notice notice) throws Exception;
	
	int deleteNotice(Notice notice) throws Exception;
}
