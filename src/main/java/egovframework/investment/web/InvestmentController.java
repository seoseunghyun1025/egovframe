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

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import egovframework.investment.service.InvestmentDTO;
import egovframework.investment.service.InvestmentService;
import egovframework.investment.service.InvestmentSummaryDTO;
import jakarta.annotation.Resource;

@Controller
@RequestMapping("/investments")
public class InvestmentController {

    @Resource(name = "investmentService")
    private InvestmentService investmentService;
    
    @RequestMapping(value="/list.do", method=RequestMethod.GET)
    public ModelAndView selectInvestmentListView() throws Exception {
        ModelAndView mav = new ModelAndView();
        
        List<InvestmentDTO> list = investmentService.selectInvestmentList();
        List<InvestmentSummaryDTO> summaryList = investmentService.selectInvestmentSummary();
        
        mav.addObject("list", list);
        mav.addObject("summaryList", summaryList);
        
        mav.setViewName("investment/investmentList");
        
        System.out.println(">>> 조회된 내역 개수: " + (list != null ? list.size() : 0));
        
        return mav; 
    }
    
    @RequestMapping(value="/regist.do", method=RequestMethod.GET)
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
        return "redirect:/investments/list.do";
    }
    
    @RequestMapping(value="/delete.do", method=RequestMethod.POST)
    public String deleteAction(@RequestParam("id") int id) throws Exception{
    	investmentService.deleteInvestment(id);
    	return "redirect:/investments/list.do";
    }
}