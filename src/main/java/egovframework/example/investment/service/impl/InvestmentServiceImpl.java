package egovframework.example.investment.service.impl;

import java.util.List;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.example.investment.service.InvestmentDTO;
import egovframework.example.investment.service.InvestmentService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

@Service("investmentService")
public class InvestmentServiceImpl extends EgovAbstractServiceImpl implements InvestmentService{
	@Resource(name="investmentMapper")
    private InvestmentMapper investmentMapper;

	@Override
	public List<InvestmentDTO> selectInvestmentList() throws Exception {
		// TODO Auto-generated method stub
		return investmentMapper.selectInvestmentList();
	}

	@Override
	public void insertInvestment(InvestmentDTO dto) throws Exception {
		// TODO Auto-generated method stub
		investmentMapper.insertInvestment(dto);
	}

	@Override
	public List<InvestmentDTO> selectInvestmentSummary() throws Exception {
		// TODO Auto-generated method stub
		return investmentMapper.selectInvestmentSummary();
	}

}
