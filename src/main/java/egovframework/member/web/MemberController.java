package egovframework.member.web;

import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.email.dto.EmailRequest;
import egovframework.email.dto.EmailVerificationRequest;
import egovframework.email.dto.PasswordChangeRequest;
import egovframework.email.dto.PasswordVerificationRequest;
import egovframework.email.serivce.EmailService;
import egovframework.member.dto.Login;
import egovframework.member.dto.Member;
import egovframework.member.dto.Register;
import egovframework.member.service.MemberService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@EnableAsync
@Controller
@RequestMapping("/member")
public class MemberController {
	@Resource(name = "memberService")
    private MemberService memberService;
	@Resource(name = "emailService")
	private EmailService emailService;
	
	@RequestMapping(value="/registForm.do", method=RequestMethod.GET)
    public String registView() throws Exception {
    	return "member/memberRegist";
    }
	
	@RequestMapping(value="/regist.do", method=RequestMethod.POST)
    public String regist(Register dto) throws Exception {
		memberService.regist(dto);
		
		emailService.createEmail(dto.getEmail());
		
        return "redirect:/member/key-alter.do?email=" + dto.getEmail();
    }
	
	@RequestMapping(value = "/loginForm.do", method = RequestMethod.GET)
	public String loginPage(){  
		return "member/login";
	}
	
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String loginCheckPage(Login dto, HttpServletRequest request) throws Exception {
		Member member = memberService.login(dto);
		
		if(member == null) {
			return "redirect:/member/loginForm.do";
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("loginMember", member);
		session.setMaxInactiveInterval(60 * 30);
		
		return "redirect:/investment/list.do";
	}
	
	@RequestMapping(value="/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/member/loginForm.do";
	}
	
	@RequestMapping(value = "/reset-password.do", method = RequestMethod.POST)
	public String resetPassword(EmailRequest dto) throws Exception {
		String email = dto.getEmail();

		boolean exists = memberService.existsByEmail(email);
		if(exists == true) {
			String tempPassword = emailService.createTemoraryPassword(email);
			emailService.sendTemporaryPasswordEmail(email, tempPassword);
			return "redirect:/member/verifyForm.do?email=" + email;
		}else {
			System.out.println();
			System.out.println("아이디가 존재하지 않습니다.");
			System.out.println();
            return "redirect:/member/reset-passwordForm.do?error=notfound ";
        }
	}
	
	@RequestMapping(value = "/verify.do", method = RequestMethod.POST)
	public String verifyTemporaryPassword(PasswordVerificationRequest request) throws Exception{
		boolean isVerified = emailService.verifyTemporaryPassword(request.getEmail(), request.getTempPassword());
        return isVerified ? 
        		"redirect:/member/change-passwordForm.do?email=" + request.getEmail() : 
        		"redirect:/member/verifyForm.do?email=" + request.getEmail();
	}
	
	@RequestMapping(value = "/reset-passwordForm.do", method = RequestMethod.GET)
	public String resetPasswordView() throws Exception{
		return "member/resetPassword";
	}

	@RequestMapping(value = "/verifyForm.do", method = RequestMethod.GET)
    public String verifyTemporaryPasswordView(@RequestParam(value="email", required=false) String email, Model model) throws Exception {
        model.addAttribute("email",email);
		
		return "member/verifyPassword";
    }
	
	@RequestMapping(value = "/change-passwordForm.do", method = RequestMethod.GET)
	public String changePasswordView(@RequestParam(value="email", required=false) String email, Model model) throws Exception {
	    model.addAttribute("email", email);
		return "member/changePassword";
	}
	
	@RequestMapping(value = "/change-password.do", method = RequestMethod.POST)
    public String changePassword(PasswordChangeRequest dto) throws Exception {
        boolean isUpdated = memberService.updatePassword(dto);
        
        if (isUpdated) {
            return "redirect:/member/loginForm.do";
        } else {
            return "redirect:/member/change-passwordForm.do?email=" + dto.getEmail() + "&error=fail";
        }
    }
	
	/**
	 * 인증번호 검증 메소드
	 */
	@RequestMapping(value = "/verify-code.do", method = RequestMethod.POST)
	public String verifyCode(EmailVerificationRequest verificationRequest) {
		boolean isVerified = emailService.verifyCode(verificationRequest.getEmail(), verificationRequest.getCode());
		return isVerified ? 
				"redirect:/member/loginForm.do": 
				"redirect:/member/key-alter.do?email=" + verificationRequest.getEmail();
	}
	
	@RequestMapping(value = "/key-alter.do", method = RequestMethod.GET)
	public String keyAlter(@RequestParam(value="email", required=false) String email, Model model) throws Exception {
		model.addAttribute("email",email);
		return "member/verify-code";
	}
}
