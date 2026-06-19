package egovframework.notice.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.config.FileUtils;
import egovframework.notice.dto.Notice;
import egovframework.notice.service.NoticeService;
import jakarta.annotation.Resource;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeServiceImpl.class);

	@Resource(name="noticeMapper")
    private NoticeMapper noticeMapper;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Override
	public Notice noticeInfo(String notice) {
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
	public int insertNotice(Notice notice, MultipartHttpServletRequest request, String noticeUuid) throws Exception {
		// TODO Auto-generated method stub
		int result = noticeMapper.insertNotice(notice);
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(noticeUuid, request);
		int size = list.size();
		System.out.println("2. " + noticeUuid);
		for(int i = 0; i<size; i++) {
			noticeMapper.insertFile(list.get(i));
		}
		return result;
	}

	@Override
	public void updatePost(Notice notice) throws Exception {
		// TODO Auto-generated method stub
		noticeMapper.updateNotice(notice);
	}

	@Override
	public int deleteNotice(Notice notice) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.deleteNotice(notice);
	}

	@Override
	public List<Map<String, Object>> selectFileList(String noticeUuid) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.selectFileList(noticeUuid);
	}

}
