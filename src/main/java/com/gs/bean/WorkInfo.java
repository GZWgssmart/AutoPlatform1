package com.gs.bean;

import java.util.Date;

public class WorkInfo {
    private String workId;

    private String recordId;

    private String userId;

    private Date workAssignTime;

    private Date workCreatedTime;

    private String workStatus;

    private MaintainRecord maintainRecord;//维修保养记录表
    private User user;

    public MaintainRecord getMaintainRecord() {
        return maintainRecord;
    }

    public void setMaintainRecord(MaintainRecord maintainRecord) {
        this.maintainRecord = maintainRecord;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getWorkId() {
        return workId;
    }

    public void setWorkId(String workId) {
        this.workId = workId;
    }

    public String getRecordId() {
        return recordId;
    }

    public void setRecordId(String recordId) {
        this.recordId = recordId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getWorkAssignTime() {
        return workAssignTime;
    }

    public void setWorkAssignTime(Date workAssignTime) {
        this.workAssignTime = workAssignTime;
    }

    public Date getWorkCreatedTime() {
        return workCreatedTime;
    }

    public void setWorkCreatedTime(Date workCreatedTime) {
        this.workCreatedTime = workCreatedTime;
    }

    public String getWorkStatus() {
        return workStatus;
    }

    public void setWorkStatus(String workStatus) {
        this.workStatus = workStatus;
    }
}