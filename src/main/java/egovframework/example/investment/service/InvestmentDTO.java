package egovframework.example.investment.service;

import java.io.Serializable;

public class InvestmentDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private String assetName;
    private String txType;
    private double buyPrice;
    private double quantity;
    private double commission;
    private String currency;
    private String exchange;
    private String buyDate;
    private String memo;

    // Getter와 Setter를 생성하세요 (Alt + Shift + S -> Generate Getters and Setters)
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }
    
    public String getTxType() { return txType; }
    public void setTxType(String txType) { this.txType = txType; }
    
    public double getBuyPrice() { return buyPrice; }
    public void setBuyPrice(double buyPrice) { this.buyPrice = buyPrice; }
    
    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }
    
    public double getCommission() { return commission; }
    public void setCommission(double commission) { this.commission = commission; }
    
    public String getCurrency() { return currency; }
    public void setCurrency(String currency) { this.currency = currency; }
    
    public String getExchange() { return exchange; }
    public void setExchange(String exchange) { this.exchange = exchange; }
    
    public String getBuyDate() { return buyDate; }
    public void setBuyDate(String buyDate) { this.buyDate = buyDate; }
    
    public String getMemo() { return memo; }
    public void setMemo(String memo) { this.memo = memo; }
}