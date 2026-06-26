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
	public void noticeList(Model model, int page) {
		// TODO Auto-generated method stub
		// 한 페이지에 5개씩
		int pageLetter = 5;
		int totalRow = noticeMapper.selectNoticeCount();
		//페이지 수
		int repeat = totalRow / pageLetter;
		if(totalRow % pageLetter != 0) {
			repeat += 1;
		}
		
		int end = page * pageLetter;
		int start = end + 1 -pageLetter;
		
		model.addAttribute("repeat", repeat);
		model.addAttribute("noticeList", noticeMapper.selectNoticeList(start, end));
	}
	
	@Override
	public void selectSeach(Model model, SearchType type, String keyword, int page) throws Exception{
		// TODO Auto-generated method stub
		String column = type.getColumn();
		
		int pageLetter = 5;
		int totalRow = noticeMapper.selectSeachCount(column, keyword);
		//페이지 수
		int repeat = totalRow / pageLetter;
		if(totalRow % pageLetter != 0) {
			repeat += 1;
		}
		
		int end = page * pageLetter;
		int start = end + 1 -pageLetter;
		
		model.addAttribute("repeat", repeat);
		model.addAttribute("noticeList", noticeMapper.selectSearch(column, keyword, start, end));
		model.addAttribute("type", type);  
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("end", end);
	    model.addAttribute("start",start);
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
