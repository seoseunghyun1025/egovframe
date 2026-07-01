package egovframework.config;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import egovframework.member.dto.Member;
import egovframework.role.enums.Auth;
import egovframework.role.enums.Auth.Role;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SessionInterceptor implements HandlerInterceptor{
	
	private static final String AJAX_HEADER_NAME = "X-Requested-With";
	private static final String AJAX_HEADER_VALUE = "XMLHttpRequest";
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginMember") == null) {
        	 if (isAjaxRequest(request)) {
        		 response.sendError(400);
        		 return false;
        	 }
             response.sendRedirect(request.getContextPath() + "/member/loginForm.do");
             return false;
        }
        
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        HandlerMethod handlerMethod = (HandlerMethod) handler;
        Auth authAnnotation = handlerMethod.getMethodAnnotation(Auth.class);
        
        if (authAnnotation == null) {
            return true;
        }
        
        if (loginMember.getRole() == null || loginMember.getRole() != Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/member/loginForm.do");
            return false;
        }
        
        return true; 
    }
	
	private boolean isAjaxRequest(HttpServletRequest request) {
		String header = request.getHeader("AJAX");
		if("true".equals(header)) {
			return true;
		}
		return false;
    }
}
