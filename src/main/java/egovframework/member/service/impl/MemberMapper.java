package egovframework.member.service.impl;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;
import egovframework.member.dto.Register;

@EgovMapper("memberMapper")
public interface MemberMapper {

	Long regist(Register req) throws Exception;
	
	String select(String email) throws Exception;
}