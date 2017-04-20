package com.gs.bean;

import java.util.Date;

public class IncomingOutgoing {
    private String inOutId;

    private String inTypeId;

    private String outTypeId;

    private Double inOutMoney;

    private String inOutCreatedUser;

    private Date inOutCreatedTime;

    private String inOutStatus;

    private OutgoingType outgoingType;
    private IncomingType incomingType;
    private User user;
    private String outTypeName;
    private String inTypeName;
    private String userName;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getOutTypeName() {
        return outTypeName;
    }

    public void setOutTypeName(String outTypeName) {
        this.outTypeName = outTypeName;
    }

    public String getInTypeName() {
        return inTypeName;
    }

    public void setInTypeName(String inTypeName) {
        this.inTypeName = inTypeName;
    }

    public OutgoingType getOutgoingType() {
        return outgoingType;
    }

    public void setOutgoingType(OutgoingType outgoingType) {
        this.outgoingType = outgoingType;
    }

    public IncomingType getIncomingType() {
        return incomingType;
    }

    public void setIncomingType(IncomingType incomingType) {
        this.incomingType = incomingType;
    }

    public String getInOutId() {
        return inOutId;
    }

    public void setInOutId(String inOutId) {
        this.inOutId = inOutId;
    }

    public String getInTypeId() {
        return inTypeId;
    }

    public void setInTypeId(String inTypeId) {
        this.inTypeId = inTypeId;
    }

    public String getOutTypeId() {
        return outTypeId;
    }

    public void setOutTypeId(String outTypeId) {
        this.outTypeId = outTypeId;
    }

    public Double getInOutMoney() {
        return inOutMoney;
    }

    public void setInOutMoney(Double inOutMoney) {
        this.inOutMoney = inOutMoney;
    }

    public String getInOutCreatedUser() {
        return inOutCreatedUser;
    }

    public void setInOutCreatedUser(String inOutCreatedUser) {
        this.inOutCreatedUser = inOutCreatedUser;
    }

    public Date getInOutCreatedTime() {
        return inOutCreatedTime;
    }

    public void setInOutCreatedTime(Date inOutCreatedTime) {
        this.inOutCreatedTime = inOutCreatedTime;
    }

    public String getInOutStatus() {
        return inOutStatus;
    }

    public void setInOutStatus(String inOutStatus) {
        this.inOutStatus = inOutStatus;
    }
}