package egovframework.investment.web;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import egovframework.investment.service.InvestmentDTO;
import egovframework.investment.service.InvestmentService;
import jakarta.annotation.Resource;

@RestController
@RequestMapping("/investments")
public class InvestmentController {

    @Resource(name = "investmentService")
    private InvestmentService investmentService;
    
    @GetMapping
    public ResponseEntity<List<InvestmentDTO>> selectInvestmentList() throws Exception{
    	List<InvestmentDTO> list = investmentService.selectInvestmentList();
    	
    	return list.isEmpty() ?
    			ResponseEntity.noContent().build() :
    				ResponseEntity.ok(list);
    }
    
    @PostMapping
    public ResponseEntity<String> createInvestment(@RequestBody InvestmentDTO dto) throws Exception{
    	investmentService.insertInvestment(dto);
    	
    	return ResponseEntity.status(201).body("Investment record created success");
    }
}