package com.gs.bean;

public class OutgoingType {
    private String outTypeId;

    private String outTypeName;

    private String outTypeStatus;

    private String companyId;

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