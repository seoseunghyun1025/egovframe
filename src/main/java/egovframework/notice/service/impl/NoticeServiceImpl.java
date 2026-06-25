package egovframework.notice.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.config.FileUtils;
import egovframework.notice.dto.Notice;
import egovframework.notice.dto.SearchType;
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
	public void noticeList(Model model, Notice notice, int page) {
		// TODO Auto-generated method stub
		
		int offset = 0;
		int limitRow = 5;
		int pageNum = 0;
		
		pageNum = page;
		offset = (pageNum - 1) * limitRow;
		
		int totalRow = noticeMapper.selectNoticeCount(notice);
		
		model.addAttribute("totalRow", totalRow);
		model.addAttribute("noticeList", noticeMapper.selectNoticeList(offset, limitRow));
		model.addAttribute("pageNum", pageNum);
	}
	
	@Override
	public void selectSeach(Model model, SearchType type, String keyword, int page) throws Exception{
		// TODO Auto-generated method stub
		
		Notice notice = new Notice();
		int totalRow = noticeMapper.selectSeachCount(notice, type, keyword);
		int pageNum = 0;
		int offset = 0;
		int limitRow = 5;
		
		pageNum = page;
		offset = (pageNum - 1) * limitRow;
		
		model.addAttribute("noticeList", noticeMapper.selectSearch(type, keyword, offset, limitRow));
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("totalRow", totalRow);
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

	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.selectFileInfo(map);
	}

	
	 @Override 
	 public void deleteNoticeFile(String uuid) throws Exception { 
		 // TODOAuto-generated method stub 
		 noticeMapper.deleteNoticeFile(uuid); 	 
	 }
}
