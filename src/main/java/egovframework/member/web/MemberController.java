package egovframework.member.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.email.dto.EmailRequest;
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

@Controller
@RequestMapping("/member")
public class MemberController {
	@Resource(name = "memberService")
    private MemberService memberService;
	@Resource(name = "emailService")
	private EmailService emailService;
	
	@RequestMapping(value="/regist.do", method=RequestMethod.GET)
    public String registView() throws Exception {
    	return "member/memberRegist"; 
    }
	
	@RequestMapping(value="/regist.do", method=RequestMethod.POST)
    public String regist(Register dto) throws Exception {
		memberService.regist(dto);
		
        return "redirect:/investments/list.do";
    }
	
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String loginPage(){  
		return "member/login";
	}
	
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String loginCheckPage(Login dto, HttpServletRequest request) throws Exception {
		Member member = memberService.login(dto);
		
		if(member == null) {
			return "redirect:/member/login.do";
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("loginMember", member);
		session.setMaxInactiveInterval(60 * 30);
		
		return "redirect:/investments/list.do";
	}
	
	@RequestMapping(value="/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/member/login.do";
	}
	
	@RequestMapping(value = "/reset-password.do", method = RequestMethod.POST)
	public String resetPassword(EmailRequest dto) throws Exception {
		String email = dto.getEmail();

		boolean exists = memberService.existsByEmail(email);
		if(exists == true) {
			String tempPassword = emailService.createTemoraryPassword(email);
			emailService.sendTemporaryPasswordEmail(email, tempPassword);
			return "redirect:/member/verify.do?email=" + email;
		}else {
			System.out.println();
			System.out.println("아이디가 존재하지 않습니다.");
			System.out.println();
            return "redirect:/member/reset-password.do?error=notfound ";
        }
	}
	
	@RequestMapping(value = "/verify.do", method = RequestMethod.POST)
	public String verifyTemporaryPassword(PasswordVerificationRequest request) throws Exception{
		boolean isVerified = emailService.verifyTemporaryPassword(request.getEmail(), request.getTempPassword());
        return isVerified ? 
        		"redirect:/member/change-password.do?email=" + request.getEmail() : 
        		"redirect:/member/verify.do?email=" + request.getEmail();
	}
	
	@RequestMapping(value = "/reset-password.do", method = RequestMethod.GET)
	public String resetPasswordView() throws Exception{
		return "member/resetPassword";
	}

	@RequestMapping(value = "/verify.do", method = RequestMethod.GET)
    public String verifyTemporaryPasswordView(@RequestParam(value="email", required=false) String email, Model model) throws Exception {
        model.addAttribute("email",email);
		
		return "member/verifyPassword";
    }
	
	@RequestMapping(value = "/change-password.do", method = RequestMethod.GET)
	public String changePasswordView(@RequestParam(value="email", required=false) String email, Model model) throws Exception {
	    model.addAttribute("email", email);
		return "member/changePassword";
	}
	
	@RequestMapping(value = "/change-password.do", method = RequestMethod.POST)
    public String changePassword(PasswordChangeRequest dto) throws Exception {
        boolean isUpdated = memberService.updatePassword(dto);
        
        if (isUpdated) {
            System.out.println("success\n");
            return "redirect:/member/login.do";
        } else {
            System.out.println("\nfailed\n");
            return "redirect:/member/change-password.do?email=" + dto.getEmail() + "&error=fail";
        }
    }
}
