package egovframework.notice.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import egovframework.member.service.impl.MemberMapper;
import egovframework.notice.dto.Notice;
import egovframework.notice.service.NoticeService;
import jakarta.annotation.Resource;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeServiceImpl.class);

	@Resource(name="noticeMapper")
    private NoticeMapper noticeMapper;
	
	@Override
	public Notice noticeInfo(Notice notice) {
		// TODO Auto-generated method stub
		return noticeMapper.selectNoticeInfo(notice);
	}

	@Override
	public int noticeCount(Notice notice) {
		// TODO Auto-generated method stub
		return noticeMapper.selectNoticeCount(notice);
	}

	@Override
	public List<Notice> noticeList(Notice notice, int offset, int limitRow) {
		// TODO Auto-generated method stub
		return noticeMapper.selectNoticeList(notice, offset, limitRow);
	}

	@Override
	public int insertNotice(Notice notice) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.insertNotice(notice);
	}

	@Override
	public int updatePost(Notice notice) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.updateNotice(notice);
	}

	@Override
	public int deleteNotice(Notice notice) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.deleteNotice(notice);
	}

}
