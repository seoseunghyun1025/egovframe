package egovframework.member.service.impl;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.member.dto.Login;
import egovframework.member.dto.Register;

@EgovMapper("memberMapper")
public interface MemberMapper {

	String regist(Register req) throws Exception;
	
	String select(String email) throws Exception;
	
	boolean login(Login dto) throws Exception;
	
	String password(String password) throws Exception;
}