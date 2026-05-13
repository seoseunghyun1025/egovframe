package egovframework.example.investment.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.example.investment.service.InvestmentDTO;

@EgovMapper("investmentMapper")
public interface InvestmentMapper {

    // 1. 투자 기록 전체 조회
    List<InvestmentDTO> selectInvestmentList() throws Exception;

    // 2. 새로운 투자 기록 등록
    void insertInvestment(InvestmentDTO dto) throws Exception;
    
    // 3. 평단가 계산을 위한 종목별 통계 조회 (나중에 쓸 핵심 로직!)
    List<InvestmentDTO> selectInvestmentSummary() throws Exception;
}