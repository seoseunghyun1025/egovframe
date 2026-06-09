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
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }
        
        HandlerMethod handlerMethod = (HandlerMethod) handler;
         
        Auth authAnnotation = handlerMethod.getMethodAnnotation(Auth.class);
        
        if (authAnnotation == null) {
            return true;
        }
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginMember") == null) {
            response.sendRedirect(request.getContextPath() + "/member/login.do");
            return false;
        }
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember.getRole() == null || loginMember.getRole() != Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/member/login.do");
            return false;
        }
        
        return true; 
    }
}
