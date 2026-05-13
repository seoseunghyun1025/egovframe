package egovframework.investment.service;

import java.util.List;

public interface InvestmentService {
	//투자리스트 조회
	List<InvestmentDTO> selectInvestmentList() throws Exception;
    
    //투자 내역 등록
    void insertInvestment(InvestmentDTO dto) throws Exception;
    
    //종목별 투자 요약(평단가 등) 조회
    List<InvestmentDTO> selectInvestmentSummary() throws Exception;
}
