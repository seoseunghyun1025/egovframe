package egovframework.config;

import java.nio.file.AccessDeniedException;
import java.util.Arrays;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import egovframework.member.dto.Member;
import egovframework.role.enums.Auth;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SessionInterceptor implements HandlerInterceptor{
	
	final String LOGIN_MEMBER_SESSION = "loginMember";
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession(false);
		
		if(session == null || session.getAttribute(LOGIN_MEMBER_SESSION) == null) {
			response.sendRedirect(request.getContextPath() + "/member/login.do");
			
			return false;
		}
		
		if (!(handler instanceof HandlerMethod)) {
            return true;
        }
		
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		
		Auth auth = handlerMethod.getMethodAnnotation(Auth.class);
		
		if(auth == null) {
			return true;
		}
		
		Member loginMember = (Member) session.getAttribute(LOGIN_MEMBER_SESSION);

		String userRole = loginMember.getRole().toString();
		
		boolean hasPermission = Arrays.stream(auth.role())
                .anyMatch(role -> role.name().equals(userRole));
		
		if (!hasPermission) {
            throw new AccessDeniedException("접근할 수 없습니다.");
        }
				
		return true;
	}
}  