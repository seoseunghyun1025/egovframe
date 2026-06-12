package egovframework.notice.web;

import java.io.PrintWriter;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.investment.service.InvestmentDTO;
import egovframework.notice.dto.Notice;
import egovframework.notice.service.NoticeService;
import egovframework.role.enums.Auth;
import egovframework.role.enums.Auth.Role;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Resource(name="noticeService")
	private NoticeService noticeService;
	
	@RequestMapping(value="/noticeInfo.do", method=RequestMethod.POST)
	public String noticeInfo(Notice dto, Model model) throws Exception {
		String noticeId = dto.getNoticeUuid();
		Notice notice = noticeService.noticeInfo(noticeId);
		
	    model.addAttribute("notice",notice);
	    
		return "notice/noticeInfo";
	}
	
	@RequestMapping(value="/noticeList.do", method=RequestMethod.GET)
	public String noticeList(HttpServletRequest request, Model model) throws Exception{
		Notice notice = new Notice();
		int totalRow = noticeService.noticeCount(notice);
		int pageNum = 0;
		int offset = 0;
		int limitRow = 10;
		
		if(request.getParameter("page") != null && Integer.parseInt(request.getParameter("page")) > 0) {
			pageNum = Integer.parseInt(request.getParameter("page"));
			offset = (pageNum - 1) * limitRow;
		}else {
			pageNum = 1;
			offset = 0;
		}
		model.addAttribute("noticeList", noticeService.noticeList(notice, offset, limitRow));
		model.addAttribute("totalRow", totalRow);
		model.addAttribute("pageNum", pageNum);
		
		return "notice/noticeList";
	}
	
	@Auth(role = Role.ADMIN)
	@RequestMapping(value="/insertNoticeForm.do", method=RequestMethod.GET)
	public String noticeInsertView() {
		
		return "notice/insertNotice";
	}
	
	@Auth(role = Role.ADMIN)
	@RequestMapping(value = "/insertNotice.do", method = RequestMethod.POST)
	public String noticeInsert(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		Notice notice = new Notice();
		
		UUID uuid = UUID.randomUUID();
		String noticeUuid = uuid.toString();
		notice.setNoticeUuid(noticeUuid);
		
		if(request.getParameter("writeId") != null && request.getParameter("writeId").isBlank() == false) {
			notice.setWriteId(request.getParameter("writeId"));
		}
		
		if(request.getParameter("noticeTitle") != null && request.getParameter("noticeTitle").isBlank() == false) {
			notice.setNoticeTitle(request.getParameter("noticeTitle"));
		}
		
		if(request.getParameter("noticeContent") != null && request.getParameter("noticeContent").isBlank() == false) {
			notice.setNoticeContent(request.getParameter("noticeContent"));
		}
		
		int resultNumber = noticeService.insertNotice(notice);
		
		if(resultNumber > 0) {
			return "redirect:/notice/noticeList.do";
		}else {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script type='text/javascript'>alert('해당 글을 등록하는데 실패하였습니다.');</script>");
			out.flush();
			
			return "redirect:/notice/insertNoticeForm.do";
		}
		
	}
	
	@Auth(role = Role.ADMIN)
	@RequestMapping(value = "/noticeModify.do", method = RequestMethod.POST)
	public String postModify(Notice dto, Model model) throws Exception {

	    String noticeId = dto.getNoticeUuid() ;
	    Notice noticeInfo = noticeService.noticeInfo(noticeId);
	            
	    model.addAttribute("noticeUuid", noticeInfo.getNoticeUuid());
	    model.addAttribute("writeId", noticeInfo.getWriteId());
	    model.addAttribute("noticeTitle", noticeInfo.getNoticeTitle());
	    model.addAttribute("noticeContent", noticeInfo.getNoticeContent());
	    model.addAttribute("registryDate", noticeInfo.getRegistryDate());
	    
	    return "/notice/noticeModify";
	}
	 
	@Auth(role = Role.ADMIN)
	@RequestMapping(value = "/noticeUpdate.do", method=RequestMethod.POST)
	public String updatePost(HttpServletRequest request) throws Exception {

		Notice notice= new Notice();

		if(request.getParameter("noticeUuid") != null && request.getParameter("noticeUuid").isBlank() == false) {
			notice.setNoticeUuid(request.getParameter("noticeUuid"));
		}

		if(request.getParameter("writeId") != null && request.getParameter("writeId").isBlank() == false) {
	        notice.setWriteId(request.getParameter("writeId"));
	    }

	    if(request.getParameter("noticeTitle") != null && request.getParameter("noticeTitle").isBlank() == false) {
	        notice.setNoticeTitle(request.getParameter("noticeTitle"));
	    }

	    if(request.getParameter("noticeContent") != null && request.getParameter("noticeContent").isBlank() == false) {
	        notice.setNoticeContent(request.getParameter("noticeContent"));
	    }

	    noticeService.updatePost(notice);
	    
	    return "redirect:/notice/noticeList.do";
	}
	
	@Auth(role = Role.ADMIN)
	@RequestMapping(value = "/deleteNotice.do",method = RequestMethod.POST)
    public String deletePost(HttpServletRequest request, Model model) throws Exception {
		Notice notice = new Notice();
		notice.setNoticeUuid(request.getParameter("noticeUuid"));
		
	    int result = noticeService.deleteNotice(notice);
	    	    
	    if(result > 0) {
		    return "redirect:/notice/noticeList.do";
	    }
	    System.out.println("공지사항 삭제 실패");
	    return "redirect:/notice/noticeList.do";
    }
}
