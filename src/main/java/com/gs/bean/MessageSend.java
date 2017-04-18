package com.gs.bean;

import java.util.Date;

public class MessageSend {
    private String messageId;

    private String userId;

    private String sendMsg;

    private Date sendTime;

    private Date sendCreatedTime;

    public String getMessageId() {
        return messageId;
    }

    public void setMessageId(String messageId) {
        this.messageId = messageId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getSendMsg() {
        return sendMsg;
    }

    public void setSendMsg(String sendMsg) {
        this.sendMsg = sendMsg;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public Date getSendCreatedTime() {
        return sendCreatedTime;
    }

    public void setSendCreatedTime(Date sendCreatedTime) {
        this.sendCreatedTime = sendCreatedTime;
    }
}