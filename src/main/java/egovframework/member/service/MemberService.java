package egovframework.member.service;

import egovframework.member.dto.Register;
import egovframework.member.dto.Login;

public interface MemberService {
	String regist(Register req) throws Exception;
	
	boolean login(Login dto) throws Exception;
}