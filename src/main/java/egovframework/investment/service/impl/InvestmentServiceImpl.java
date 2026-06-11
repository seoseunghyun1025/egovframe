package egovframework.investment.service.impl;

import java.util.List;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import egovframework.investment.service.InvestmentDTO;
import egovframework.investment.service.InvestmentService;
import egovframework.investment.service.InvestmentSummaryDTO;
import egovframework.role.enums.Auth.Role;

@Service("investmentService")
public class InvestmentServiceImpl extends EgovAbstractServiceImpl implements InvestmentService{
	@Resource(name="investmentMapper")
    private InvestmentMapper investmentMapper;

	@Override
	public List<InvestmentDTO> selectInvestmentList(Role role, Long memberId) throws Exception {
		// TODO Auto-generated method stub
		
		if(role.equals(Role.ADMIN)) {
			return investmentMapper.selectAllInvestmentList();
		}
		
		return investmentMapper.selectInvestmentList(memberId);
	}

	@Override
	public void insertInvestment(InvestmentDTO dto) throws Exception {
		// TODO Auto-generated method stub
		investmentMapper.insertInvestment(dto);
	}

	@Override
	public List<InvestmentSummaryDTO> selectInvestmentSummary() throws Exception {
		// TODO Auto-generated method stub
		return investmentMapper.selectInvestmentSummary();
	}

	@Override
	public InvestmentDTO selectInvestmentDetail(int id) throws Exception {
		// TODO Auto-generated method stub
		return investmentMapper.selectInvestmentDetail(id);
	}

	@Override
	public void updateInvestment(InvestmentDTO dto) throws Exception {
		// TODO Auto-generated method stub
		investmentMapper.updateInvestment(dto);
	}

	@Override
	public void deleteInvestment(int id) throws Exception {
		// TODO Auto-generated method stub
		investmentMapper.deleteInvestment(id);
	}

	@Override
	public List<InvestmentDTO> selectInvestmentHistoryList(InvestmentDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return investmentMapper.selectInvestmentHistoryList(dto);
	}

	@Override
	public int selectInvestmentHistoryListTotCnt(InvestmentDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return investmentMapper.selectInvestmentHistoryListTotCnt(dto);
	}
}
