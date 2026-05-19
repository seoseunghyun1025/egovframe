package egovframework.member.service;

import egovframework.member.dto.Register;
import egovframework.member.dto.Login;
import egovframework.member.dto.Member;

public interface MemberService {
	void regist(Register req) throws Exception;
	
	Member login(Login dto) throws Exception;
}