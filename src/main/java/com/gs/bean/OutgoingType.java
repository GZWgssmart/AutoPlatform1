package com.gs.bean;

public class OutgoingType {
    private String outTypeId;

    private String outTypeName;

    private String outTypeStatus;



    private String companyId;


    /**
     * 关联公司
     */
    private Company company;

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public String getOutTypeId() {
        return outTypeId;
    }

    public void setOutTypeId(String outTypeId) {
        this.outTypeId = outTypeId;
    }

    public String getOutTypeName() {
        return outTypeName;
    }

    public void setOutTypeName(String outTypeName) {
        this.outTypeName = outTypeName;
    }

    public String getOutTypeStatus() {
        return outTypeStatus;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public void setOutTypeStatus(String outTypeStatus) {
        this.outTypeStatus = outTypeStatus;
    }
}