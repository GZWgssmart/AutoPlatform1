package com.gs.bean;

/**
 * 维修保养项目表
 */
public class MaintainFix {
    private String maintainId;//维修保养项目编号

    private String maintainName;//维修保养项目名称

    private Double maintainHour;//维修保养项目工时

    private Double maintainMoney;//维修保养项目基础费用

    private Double maintainManHourFee;//维修保养项目工时费

    private String maintainOrFix;//标识是保养还是维修

    private String maintainDes;//维修保养项目描述

    private String companyId;//维修保养项目所属公司 来源于t_company表

    private String maintainStatus;//维修保养项目状态

    private Company company;//关联Company表

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public String getMaintainId() {
        return maintainId;
    }

    public void setMaintainId(String maintainId) {
        this.maintainId = maintainId;
    }

    public Double getMaintainManHourFee() {
        return maintainManHourFee;
    }

    public void setMaintainManHourFee(Double maintainManHourFee) {
        this.maintainManHourFee = maintainManHourFee;
    }

    public String getMaintainName() {
        return maintainName;
    }

    public void setMaintainName(String maintainName) {
        this.maintainName = maintainName;
    }

    public Double getMaintainHour() {
        return maintainHour;
    }

    public void setMaintainHour(Double maintainHour) {
        this.maintainHour = maintainHour;
    }

    public Double getMaintainMoney() {
        return maintainMoney;
    }

    public void setMaintainMoney(Double maintainMoney) {
        this.maintainMoney = maintainMoney;
    }

    public String getMaintainOrFix() {
        return maintainOrFix;
    }

    public void setMaintainOrFix(String maintainOrFix) {
        this.maintainOrFix = maintainOrFix;
    }

    public String getMaintainDes() {
        return maintainDes;
    }

    public void setMaintainDes(String maintainDes) {
        this.maintainDes = maintainDes;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getMaintainStatus() {
        return maintainStatus;
    }

    public void setMaintainStatus(String maintainStatus) {
        this.maintainStatus = maintainStatus;
    }

    @Override
    public String toString() {
        return "MaintainFix{" +
                "maintainId='" + maintainId + '\'' +
                ", maintainName='" + maintainName + '\'' +
                ", maintainHour=" + maintainHour +
                ", maintainMoney=" + maintainMoney +
                ", maintainManhourFee=" + maintainManHourFee +
                ", maintainOrFix='" + maintainOrFix + '\'' +
                ", maintainDes='" + maintainDes + '\'' +
                ", companyId='" + companyId + '\'' +
                ", maintainStatus='" + maintainStatus + '\'' +
                '}';
    }
}