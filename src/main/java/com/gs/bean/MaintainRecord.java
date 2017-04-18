package com.gs.bean;

import java.util.Date;

public class MaintainRecord {
    private String recordId;

    private String checkinId;

    private Date startTime;

    private Date endTime;

    private Date actualEndTime;

    private Date recordCreatedTime;

    private Date pickupTime;

    private String recordDes;

    private String recordStatus;

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