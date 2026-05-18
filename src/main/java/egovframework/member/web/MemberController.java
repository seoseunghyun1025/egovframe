package egovframework.member.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.member.dto.Register;
import egovframework.member.service.MemberService;
import jakarta.annotation.Resource;

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
}
