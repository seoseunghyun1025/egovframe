package egovframework.investment.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.investment.service.InvestmentDTO;
import egovframework.investment.service.InvestmentService;
import jakarta.annotation.Resource;

@Controller
public class InvestmentController {

    @Resource(name = "investmentService")
    private InvestmentService investmentService;

    // 투자 목록 화면 조회
    @RequestMapping(value = "/investmentList.do")
    public String selectInvestmentList(Model model) throws Exception {
        
        List<InvestmentDTO> list = investmentService.selectInvestmentList();
        
        model.addAttribute("resultList", list);
        
        return "investment/investmentList"; 
    }
}