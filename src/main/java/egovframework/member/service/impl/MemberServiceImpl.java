package egovframework.member.service.impl;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.member.dto.Register;
import egovframework.member.dto.Login;
import egovframework.member.dto.Member;
import egovframework.member.exception.DuplicateMemberException;
import egovframework.member.service.MemberService;
import jakarta.annotation.Resource;

@Service("memberService")
public class MemberServiceImpl extends EgovAbstractServiceImpl implements MemberService {
	
	@Resource(name = "bcryptPasswordEncoder")
    private BCryptPasswordEncoder encoder;
	
	@Resource(name="memberMapper")
    private MemberMapper memberMapper;
	
	@Override
	public void regist(Register req) throws Exception {
		// TODO Auto-generated method stub
		String member = memberMapper.select(req.getEmail());
		
		if(member != null) {
			throw new DuplicateMemberException("dup email" + req.getEmail());
		}
		
		req.setPassword(encoder.encode(req.getPassword()));
		
		memberMapper.regist(req);
	}

	@Override
	public Member login(Login dto) throws Exception {
		// TODO Auto-generated method stub
		Member member = memberMapper.password(dto.getEmail());
		
		if(member == null) {
			throw new Exception("존재하지 않는 회원입니다.");
		}
		
		if(!encoder.matches(dto.getPassword(), member.getPassword())) {
			throw new Exception("비밀번호가 일치하지 않습니다.");
		}
		
		return member;
	}
}
