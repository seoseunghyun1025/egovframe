package egovframework.member.service;

import egovframework.member.dto.Register;

public interface MemberService {
	Long regist(Register req) throws Exception;
}
