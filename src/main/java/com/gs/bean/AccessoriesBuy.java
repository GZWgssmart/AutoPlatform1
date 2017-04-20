package com.gs.bean;

import org.joda.time.DateTime;

import java.util.Date;

public class AccessoriesBuy {
    private String accBuyId;

    private String accId;

    private String accUnit;

    private Integer accBuyCount;

    private Double accBuyPrice;

    private Double accBuyTotal;

    private Double accBuyDiscount;

    private Double accBuyMoney;

    private Date accBuyTime;

    private Date accBuyCreatedTime;

    private String companyId;

    private String accBuyStatus;

    public String getAccBuyId() {
        return accBuyId;
    }

    public void setAccBuyId(String accBuyId) {
        this.accBuyId = accBuyId;
    }

    public String getAccId() {
        return accId;
    }

    public void setAccId(String accId) {
        this.accId = accId;
    }

    public String getAccUnit() {
        return accUnit;
    }

    public void setAccUnit(String accUnit) {
        this.accUnit = accUnit;
    }

    public Integer getAccBuyCount() {
        return accBuyCount;
    }

    public void setAccBuyCount(Integer accBuyCount) {
        this.accBuyCount = accBuyCount;
    }

    public Double getAccBuyPrice() {
        return accBuyPrice;
    }

    public void setAccBuyPrice(Double accBuyPrice) {
        this.accBuyPrice = accBuyPrice;
    }

    public Double getAccBuyTotal() {
        return accBuyTotal;
    }

    public void setAccBuyTotal(Double accBuyTotal) {
        this.accBuyTotal = accBuyTotal;
    }

    public Double getAccBuyDiscount() {
        return accBuyDiscount;
    }

    public void setAccBuyDiscount(Double accBuyDiscount) {
        this.accBuyDiscount = accBuyDiscount;
    }

    public Double getAccBuyMoney() {
        return accBuyMoney;
    }

    public void setAccBuyMoney(Double accBuyMoney) {
        this.accBuyMoney = accBuyMoney;
    }

    public Date getAccBuyTime() {
        return accBuyTime;
    }

    public void setAccBuyTime(Date accBuyTime) {
        this.accBuyTime = accBuyTime;
    }

    public Date getAccBuyCreatedTime() {
        return accBuyCreatedTime;
    }

    public void setAccBuyCreatedTime(Date accBuyCreatedTime) {
        this.accBuyCreatedTime = accBuyCreatedTime;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getAccBuyStatus() {
        return accBuyStatus;
    }

    public void setAccBuyStatus(String accBuyStatus) {
        this.accBuyStatus = accBuyStatus;
    }

    @Override
    public String toString() {
        return "AccessoriesBuy{" +
                "accBuyId='" + accBuyId + '\'' +
                ", accId='" + accId + '\'' +
                ", accUnit='" + accUnit + '\'' +
                ", accBuyCount=" + accBuyCount +
                ", accBuyPrice=" + accBuyPrice +
                ", accBuyTotal=" + accBuyTotal +
                ", accBuyDiscount=" + accBuyDiscount +
                ", accBuyMoney=" + accBuyMoney +
                ", accBuyTime=" + accBuyTime +
                ", accBuyCreatedTime=" + accBuyCreatedTime +
                ", companyId='" + companyId + '\'' +
                ", accBuyStatus='" + accBuyStatus + '\'' +
                '}';
    }
}