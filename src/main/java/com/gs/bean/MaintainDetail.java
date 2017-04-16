package com.gs.bean;

import java.util.Date;

/**
 * Created by XiaoQiao on 2017/4/14.
 */

/**
 * 维修保养明细
 */
public class MaintainDetail {

    private String maintainDetailId; //维修保养明细编号
    private String maintainRecordId; //维修保养记录编号
    private String maintainItemId; //维修保养项目编号
    private double maintainDiscount; //维修保养项目折扣
    private Date mdCreatedTime; //维修保养明细创建时间

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

    public double getMaintainDiscount() {
        return maintainDiscount;
    }

    public void setMaintainDiscount(double maintainDiscount) {
        this.maintainDiscount = maintainDiscount;
    }

    public Date getMdCreatedTime() {
        return mdCreatedTime;
    }

    public void setMdCreatedTime(Date mdCreatedTime) {
        this.mdCreatedTime = mdCreatedTime;
    }
}
