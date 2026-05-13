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
import org.springframework.web.bind.annotation.*;
import egovframework.investment.service.InvestmentDTO;
import egovframework.investment.service.InvestmentService;
import egovframework.investment.service.InvestmentSummaryDTO;
import jakarta.annotation.Resource;

@Controller
@RequestMapping("/investments")
public class InvestmentController {

    @Resource(name = "investmentService")
    private InvestmentService investmentService;
    
    @RequestMapping(value="/investmentList.do", method=RequestMethod.GET)
    public String selectInvestmentListView() throws Exception {
        return "investment/investmentList"; 
    }
    
    @RequestMapping(value="/investmentCreate.do", method=RequestMethod.GET)
    public String insertInvestmentView() throws Exception {
        return "investment/investmentCreate";
    }
    
    @RequestMapping(value="/selectInvestmentList.do", method=RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<List<InvestmentDTO>> selectInvestmentList() throws Exception {
        List<InvestmentDTO> list = investmentService.selectInvestmentList();
        
        System.out.println(">>> 가져온 데이터 개수: " + (list != null ? list.size() : 0));
        
        return list.isEmpty() ?
                ResponseEntity.noContent().build() :
                ResponseEntity.ok(list);
    }
    
    @RequestMapping(value="/insertInvestment.do", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> insertInvestment(@RequestBody InvestmentDTO dto) throws Exception {
        investmentService.insertInvestment(dto);
        return ResponseEntity.status(201).body("success");
    }
    
    @RequestMapping(value="/selectInvestmentSummary.do", method=RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<List<InvestmentSummaryDTO>> selectInvestmentSummary() throws Exception {
        List<InvestmentSummaryDTO> summaryList = investmentService.selectInvestmentSummary();
        return ResponseEntity.ok(summaryList);
    }    
}