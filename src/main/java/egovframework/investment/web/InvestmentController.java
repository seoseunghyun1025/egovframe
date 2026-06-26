/*
 * package egovframework.investment.web;
 * 
 * import java.util.List;
 * 
 * import org.springframework.http.ResponseEntity; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.bind.annotation.RequestBody; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RestController;
 * 
 * import egovframework.investment.service.InvestmentDTO; import
 * egovframework.investment.service.InvestmentService; import
 * egovframework.investment.service.InvestmentSummaryDTO; import
 * jakarta.annotation.Resource;
 * 
 * @RestController
 * 
 * @RequestMapping("/investments") public class InvestmentController {
 * 
 * @Resource(name = "investmentService") private InvestmentService
 * investmentService;
 * 
 * @GetMapping public ResponseEntity<List<InvestmentDTO>> selectInvestmentList()
 * throws Exception{ List<InvestmentDTO> list =
 * investmentService.selectInvestmentList();
 * 
 * return list.isEmpty() ? ResponseEntity.noContent().build() :
 * ResponseEntity.ok(list); }
 * 
 * @PostMapping public ResponseEntity<String> createInvestment(@RequestBody
 * InvestmentDTO dto) throws Exception{ investmentService.insertInvestment(dto);
 * 
 * return ResponseEntity.status(201).body("Investment record created success");
 * }
 * 
 * @GetMapping("/portfolio") public ResponseEntity<List<InvestmentSummaryDTO>>
 * getPortfolio() throws Exception { List<InvestmentSummaryDTO> summaryList =
 * investmentService.selectInvestmentSummary(); return
 * ResponseEntity.ok(summaryList); } }
 */

package egovframework.investment.web;

import java.util.ArrayList;
import java.util.List;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import egovframework.investment.service.InvestmentDTO;
import egovframework.investment.service.InvestmentService;
import egovframework.member.dto.Member;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/investment")
public class InvestmentController {

    @Resource(name = "investmentService")
    private InvestmentService investmentService;
    
    @RequestMapping(value="/list.do", method=RequestMethod.GET)
    public ModelAndView selectInvestmentListView(HttpServletRequest request) throws Exception {
    	HttpSession session = request.getSession(false);
    	Member member = new Member();
    	List<InvestmentDTO> list = null;
    	
    	if(session != null) {
    		member = (Member)session.getAttribute("loginMember");
    	}
    	
        ModelAndView mav = new ModelAndView();
        
        list = investmentService.selectInvestmentList(member.getRole(), member.getMemberId());
        
        mav.addObject("list", list);
        
        mav.setViewName("investment/investmentList");
        
        return mav; 
    }
    
    @RequestMapping(value="/registForm.do", method=RequestMethod.GET)
    public String registView(@RequestParam(value="id", required=false) Integer id, Model model) throws Exception {
    	InvestmentDTO dto = null;
    	
    	if(id != null && id > 0) {
    		dto = investmentService.selectInvestmentDetail(id);
    	}else {
    		dto = new InvestmentDTO();
    	}
    	model.addAttribute("investmentDTO", dto);
        return "investment/investmentRegist"; 
    }
    
    @RequestMapping(value="/regist.do", method=RequestMethod.POST)
    public String registAction(InvestmentDTO dto) throws Exception {
    	if (dto.getId() > 0) {
            investmentService.updateInvestment(dto);
        } else {
            investmentService.insertInvestment(dto);
        }
        return "redirect:/investment/list.do";
    }
    
    @RequestMapping(value="/update.do", method=RequestMethod.POST)
    public String update(HttpServletRequest request, Model model) throws Exception{
    	String id = request.getParameter("id");
    	InvestmentDTO dto = investmentService.selectInvestmentDetail(Integer.parseInt(id));
    	model.addAttribute("investmentDTO",dto);
    	return "investment/investmentRegist";
    }
    
    @RequestMapping(value="/delete.do", method=RequestMethod.POST)
    public String deleteAction(@RequestParam("id") int id) throws Exception{
    	investmentService.deleteInvestment(id);
    	return "redirect:/investment/list.do";
    }
    
    @RequestMapping(value="/history.do", method=RequestMethod.GET)
    public String selectInvestmentHistoryList(@ModelAttribute("investmentDTO") InvestmentDTO dto, Model model) throws Exception{    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(dto.getPageIndex());
    	paginationInfo.setRecordCountPerPage(10);
    	paginationInfo.setPageSize(5);
    	
    	dto.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	dto.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    	
    	int totCnt = investmentService.selectInvestmentHistoryListTotCnt(dto);
    	paginationInfo.setTotalRecordCount(totCnt);
    	
    	List<InvestmentDTO> list = investmentService.selectInvestmentHistoryList(dto);
    	model.addAttribute("paginationInfo", paginationInfo);
    	model.addAttribute("resultList", list);
    	
    	return "investment/historyList";
    }
}