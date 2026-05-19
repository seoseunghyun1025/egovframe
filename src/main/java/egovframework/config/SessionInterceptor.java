package egovframework.config;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SessionInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession(false);
		
		if(session == null || session.getAttribute("loginMember") == null) {
			response.sendRedirect(request.getContextPath() + "/member/login.do");
			
			return false;
		}
		return true;
	}
}
