package egovframework.notice.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;
import org.springframework.dao.DataAccessException;

import egovframework.notice.dto.Notice;
import egovframework.notice.dto.NoticeFile;
import egovframework.notice.dto.SearchType;

@EgovMapper("noticeMapper")
public interface NoticeMapper {
	Notice selectNoticeInfo(String notice) throws DataAccessException;

    int selectNoticeCount() throws DataAccessException;

    List<Notice> selectNoticeList(@Param("start") int start, @Param("end") int end) throws DataAccessException;

    int insertNotice(Notice notice) throws Exception;

    void updateNotice(Notice notice) throws Exception;

    int deleteNotice(Notice notice) throws Exception;
    
    void insertFile(List<NoticeFile> noticeFile) throws Exception;
    
    List<Map<String, Object>> selectFileList(String noticeUuid) throws Exception;
    
    Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
    
    void deleteNoticeFile(String id) throws Exception;

	int selectSeachCount(@Param("column") String column, @Param("keyword") String keyword) throws Exception;
	
	List<Notice> selectSearch(@Param("column") String column, 
							  @Param("keyword") String keyword,
							  @Param("start") int start, 
							  @Param("end") int end) throws Exception;
	
	void deleteNoticeFiles(String uuid) throws Exception;
}