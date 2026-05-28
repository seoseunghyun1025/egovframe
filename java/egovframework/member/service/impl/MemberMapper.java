package egovframework.member.service.impl;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.member.dto.Login;
import egovframework.member.dto.Member;
import egovframework.member.dto.Register;

@EgovMapper("memberMapper")
public interface MemberMapper {

	void regist(Register req) throws Exception;
	
	Member select(String email) throws Exception;
	
	boolean login(Login dto) throws Exception;
	
	Member password(String password) throws Exception;
	
	void update(Member dto) throws Exception;
}