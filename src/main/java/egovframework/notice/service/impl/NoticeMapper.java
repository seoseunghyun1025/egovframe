package egovframework.notice.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;
import org.springframework.dao.DataAccessException;

import egovframework.notice.dto.Notice;

@EgovMapper("noticeMapper")
public interface NoticeMapper {
	Notice selectNoticeInfo(String notice) throws DataAccessException;

    int selectNoticeCount(Notice notice) throws DataAccessException;

    List<Notice> selectNoticeList(@Param("notice") Notice notice,@Param("offset") int offset,@Param("limitRow") int limitRow) throws DataAccessException;

    int insertNotice(Notice notice) throws Exception;

    void updateNotice(Notice notice) throws Exception;

    int deleteNotice(Notice notice) throws Exception;

}