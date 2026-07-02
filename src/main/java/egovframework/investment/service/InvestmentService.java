package egovframework.investment.service;

import java.util.List;

import egovframework.page.dto.PageInfoDTO;
import egovframework.role.enums.Auth.Role;

public interface InvestmentService {
	//투자리스트 조회
	List<InvestmentDTO> selectInvestmentList(PageInfoDTO pageInfo, Role role, Long memberId) throws Exception;
    
    //투자 내역 등록
    void insertInvestment(InvestmentDTO dto) throws Exception;
    
    //종목별 투자 요약(평단가 등) 조회
    List<InvestmentSummaryDTO> selectInvestmentSummary() throws Exception;
    
    //상세 보기
    InvestmentDTO selectInvestmentDetail(int id) throws Exception;
    
    //수정
    void updateInvestment(InvestmentDTO dto) throws Exception;

    //삭제
    void deleteInvestment(int id) throws Exception;
    
    //종목별 리스트
    List<InvestmentDTO> selectInvestmentHistoryList(InvestmentDTO dto) throws Exception;
    
    //종목별 페이징
    int selectInvestmentHistoryListTotCnt(InvestmentDTO dto) throws Exception;
    
    //투자 게시글 수
    int totalCount(Role role, Long memberId) throws Exception;
}