package com.gs.bean;

import java.util.Date;

public class MaintainDetail {
    private String maintainDetailId;

    private String maintainRecordId;

    private String maintainItemId;

    private Double maintainDiscount;

    private Date mdcreatedTime;

    public String getMaintainDetailId() {
        return maintainDetailId;
    }

    public void setMaintainDetailId(String maintainDetailId) {
        this.maintainDetailId = maintainDetailId;
    }

    public String getMaintainRecordId() {
        return maintainRecordId;
    }

    public void setMaintainRecordId(String maintainRecordId) {
        this.maintainRecordId = maintainRecordId;
    }

    public String getMaintainItemId() {
        return maintainItemId;
    }

    public void setMaintainItemId(String maintainItemId) {
        this.maintainItemId = maintainItemId;
    }

    public Double getMaintainDiscount() {
        return maintainDiscount;
    }

    public void setMaintainDiscount(Double maintainDiscount) {
        this.maintainDiscount = maintainDiscount;
    }

    public Date getMdcreatedTime() {
        return mdcreatedTime;
    }

    public void setMdcreatedTime(Date mdcreatedTime) {
        this.mdcreatedTime = mdcreatedTime;
    }
}