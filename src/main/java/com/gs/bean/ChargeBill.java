package com.gs.bean;

import java.util.Date;

public class ChargeBill {
    private String chargeBillId;

    private String maintainRecordId;

    private Double chargeBillMoney;

    private String paymentMethod;

    private Double actualPayment;

    private Date chargeTime;

    private Date chargeCreatedTime;

    private String chargeBillDes;

    private String chargeBillStatus;

    public String getChargeBillId() {
        return chargeBillId;
    }

    public void setChargeBillId(String chargeBillId) {
        this.chargeBillId = chargeBillId;
    }

    public String getMaintainRecordId() {
        return maintainRecordId;
    }

    public void setMaintainRecordId(String maintainRecordId) {
        this.maintainRecordId = maintainRecordId;
    }

    public Double getChargeBillMoney() {
        return chargeBillMoney;
    }

    public void setChargeBillMoney(Double chargeBillMoney) {
        this.chargeBillMoney = chargeBillMoney;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Double getActualPayment() {
        return actualPayment;
    }

    public void setActualPayment(Double actualPayment) {
        this.actualPayment = actualPayment;
    }

    public Date getChargeTime() {
        return chargeTime;
    }

    public void setChargeTime(Date chargeTime) {
        this.chargeTime = chargeTime;
    }

    public Date getChargeCreatedTime() {
        return chargeCreatedTime;
    }

    public void setChargeCreatedTime(Date chargeCreatedTime) {
        this.chargeCreatedTime = chargeCreatedTime;
    }

    public String getChargeBillDes() {
        return chargeBillDes;
    }

    public void setChargeBillDes(String chargeBillDes) {
        this.chargeBillDes = chargeBillDes;
    }

    public String getChargeBillStatus() {
        return chargeBillStatus;
    }

    public void setChargeBillStatus(String chargeBillStatus) {
        this.chargeBillStatus = chargeBillStatus;
    }
}