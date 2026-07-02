package egovframework.investment.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.investment.service.InvestmentDTO;
import egovframework.investment.service.InvestmentSummaryDTO;
import egovframework.page.dto.PageInfoDTO;
import egovframework.role.enums.Auth.Role;

@EgovMapper("investmentMapper")
public interface InvestmentMapper {

    // 1. 투자 기록 전체 조회
    List<InvestmentDTO> selectInvestmentList(@Param("pageInfo")PageInfoDTO pageInfo, @Param("memberId")Long memberId) throws Exception;
    
    List<InvestmentDTO> selectAllInvestmentList(@Param("pageInfo")PageInfoDTO pageInfo) throws Exception;

    // 2. 새로운 투자 기록 등록
    void insertInvestment(InvestmentDTO dto) throws Exception;
    
    // 3. 평단가 계산을 위한 종목별 통계 조회 (나중에 쓸 핵심 로직!)
    List<InvestmentSummaryDTO> selectInvestmentSummary() throws Exception;
    
    // 상세보기
    InvestmentDTO selectInvestmentDetail(int id)throws Exception;
    
    // 수정
    void updateInvestment(InvestmentDTO dto) throws Exception;
    
    // 삭제
    void deleteInvestment(int id) throws Exception;
    
    List<InvestmentDTO> selectInvestmentHistoryList(InvestmentDTO dto) throws Exception;
    
    int selectInvestmentHistoryListTotCnt(InvestmentDTO dto) throws Exception;
    
    int totalAllCount() throws Exception;
    
    int totalCount(Long memberId) throws Exception;
}