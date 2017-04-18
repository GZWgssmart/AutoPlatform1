package com.gs.bean;

import java.util.Date;

public class MaterialReturn {
    private String materialReturnId;

    private String matainRecordId;

    private String accId;

    private Integer accCount;

    private Date mrCreatedDate;

    private Date mrReturnDate;

    public String getMaterialReturnId() {
        return materialReturnId;
    }

    public void setMaterialReturnId(String materialReturnId) {
        this.materialReturnId = materialReturnId;
    }

    public String getMatainRecordId() {
        return matainRecordId;
    }

    public void setMatainRecordId(String matainRecordId) {
        this.matainRecordId = matainRecordId;
    }

    public String getAccId() {
        return accId;
    }

    public void setAccId(String accId) {
        this.accId = accId;
    }

    public Integer getAccCount() {
        return accCount;
    }

    public void setAccCount(Integer accCount) {
        this.accCount = accCount;
    }

    public Date getMrCreatedDate() {
        return mrCreatedDate;
    }

    public void setMrCreatedDate(Date mrCreatedDate) {
        this.mrCreatedDate = mrCreatedDate;
    }

    public Date getMrReturnDate() {
        return mrReturnDate;
    }

    public void setMrReturnDate(Date mrReturnDate) {
        this.mrReturnDate = mrReturnDate;
    }
}