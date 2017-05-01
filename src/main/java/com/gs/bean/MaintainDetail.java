package com.gs.bean;

import java.util.Date;

/**
 * 维修保养明细bean, 张文星
 * */
public class MaintainDetail {
    private String maintainDetailId; //维修保养明细编号

    private String maintainRecordId; //维修保养记录编号

    private String maintainItemId; //维修保养项目编号

    private Double maintainDiscount; //维修保养项目折扣

    private Date mdcreatedTime; //维修保养明细创建时间

    private MaintainFix maintainFix;

    // 打印需要字段
    private String disCount; // 折扣

    public String getDisCount() {
        return disCount;
    }

    public void setDisCount(String disCount) {
        this.disCount = disCount;
    }

    public MaintainFix getMaintainFix() {
        return maintainFix;
    }

    public void setMaintainFix(MaintainFix maintainFix) {
        this.maintainFix = maintainFix;
    }

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

    @Override
    public String toString() {
        return "MaintainDetail{" +
                "maintainDetailId='" + maintainDetailId + '\'' +
                ", maintainRecordId='" + maintainRecordId + '\'' +
                ", maintainItemId='" + maintainItemId + '\'' +
                ", maintainDiscount=" + maintainDiscount +
                ", mdcreatedTime=" + mdcreatedTime +
                '}';
    }
}