package egovframework.notice.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Resource(name="noticeService")
	private NoticeService noticeService;
	
	@RequestMapping(value="/noticeInfo.do", method=RequestMethod.GET)
	public String noticeInfo(HttpServletRequest request) throws Exception {
		if(request.getParameter("uuid") != null && request.getParameter("uuid").isBlank() == false) {
			
		}
	}
}
