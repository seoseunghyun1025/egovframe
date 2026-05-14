package egovframework.investment.service.impl;

import java.util.List;
import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.investment.service.InvestmentDTO;
import egovframework.investment.service.InvestmentSummaryDTO;

@EgovMapper("investmentMapper")
public interface InvestmentMapper {

    // 1. 투자 기록 전체 조회
    List<InvestmentDTO> selectInvestmentList() throws Exception;

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
}