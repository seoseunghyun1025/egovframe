package egovframework.investment.service;

import java.io.Serializable;
public class InvestmentSummaryDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    
    private int id;
    private String assetName;    // 종목명
    private double totalQuantity; // 총 보유 수량
    private double avgPrice;      // 평균 단가 (평단가)

    public InvestmentSummaryDTO() {}

    public InvestmentSummaryDTO(String assetName, double totalQuantity, double avgPrice) {
        this.assetName = assetName;
        this.totalQuantity = totalQuantity;
        this.avgPrice = avgPrice;
    }
    
    public int getId() {return id;}
    public void setId(int id) {this.id = id;}
    
    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }

    public double getTotalQuantity() { return totalQuantity; }
    public void setTotalQuantity(double totalQuantity) { this.totalQuantity = totalQuantity; }

    public double getAvgPrice() { return avgPrice; }
    public void setAvgPrice(double avgPrice) { this.avgPrice = avgPrice; }
}