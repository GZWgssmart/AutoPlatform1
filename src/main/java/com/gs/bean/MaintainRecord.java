package com.gs.bean;

import java.util.Date;

/**
 * 维修保养记录bean, 张文星
 */
public class MaintainRecord {
    private String recordId; // 维修保养记录编号

    private String checkinId; // 登记记录编号

    private Date startTime; // 维修保养开始时间

    private Date endTime; //维修保养预估结束时间

    private Date actualEndTime; //维修保养实际结束时间

    private Date recordCreatedTime; //维修保养记录创建时间

    private Date pickupTime; //维修保养结束车主提车时间

    private String recordDes; //维修保养记录描述

    private String recordStatus; //维修保养记录状态

    private Checkin checkin; // 登记记录

    public Checkin getCheckin() {
        return checkin;
    }

    public void setCheckin(Checkin checkin) {
        this.checkin = checkin;
    }

    public String getRecordId() {
        return recordId;
    }

    public void setRecordId(String recordId) {
        this.recordId = recordId;
    }

    public String getCheckinId() {
        return checkinId;
    }

    public void setCheckinId(String checkinId) {
        this.checkinId = checkinId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getActualEndTime() {
        return actualEndTime;
    }

    public void setActualEndTime(Date actualEndTime) {
        this.actualEndTime = actualEndTime;
    }

    public Date getRecordCreatedTime() {
        return recordCreatedTime;
    }

    public void setRecordCreatedTime(Date recordCreatedTime) {
        this.recordCreatedTime = recordCreatedTime;
    }

    public Date getPickupTime() {
        return pickupTime;
    }

    public void setPickupTime(Date pickupTime) {
        this.pickupTime = pickupTime;
    }

    public String getRecordDes() {
        return recordDes;
    }

    public void setRecordDes(String recordDes) {
        this.recordDes = recordDes;
    }

    public String getRecordStatus() {
        return recordStatus;
    }

    public void setRecordStatus(String recordStatus) {
        this.recordStatus = recordStatus;
    }
}