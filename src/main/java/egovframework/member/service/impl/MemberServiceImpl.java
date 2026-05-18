package egovframework.member.service.impl;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.member.dto.Register;
import egovframework.member.exception.DuplicateMemberException;
import egovframework.member.service.MemberService;
import jakarta.annotation.Resource;

@Service("memberService")
public class MemberServiceImpl extends EgovAbstractServiceImpl implements MemberService {

	@Resource(name="memberMapper")
    private MemberMapper memberMapper;
	
	@Override
	public Long regist(Register req) throws Exception {
		// TODO Auto-generated method stub
		String member = memberMapper.select(req.getEmail());
		
		System.out.println();
		System.out.println("success");
		System.out.println();
		
		if(member != null) {
			throw new DuplicateMemberException("dup email" + req.getEmail());
		}
		
		return memberMapper.regist(req);
	}

}
