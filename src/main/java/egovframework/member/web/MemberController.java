package egovframework.member.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import egovframework.member.dto.Login;
import egovframework.member.dto.Register;
import egovframework.member.service.MemberService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Resource(name = "memberService")
    private MemberService memberService;
	
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
	public String loginCheckPage(Login dto) throws Exception {
		boolean pnp = memberService.login(dto);
		
		if(pnp != true) {
			return "redirect:/member/login.do";
		}
		
		return "redirect:/investments/list.do";
	}
}
