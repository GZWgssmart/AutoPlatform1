package com.gs.bean;

import java.util.Date;

/**
 * Created by XiaoQiao on 2017/4/14.
 */

/**
 * 短信发送记录
 */
public class MessageSend {

    private String messageId; //短信发送记录编号
    private String userId; //用户编号
    private String sendMsg; //短信发送内容
    private Date sendTime; //短信发送时间
    private Date sendCreatedTime; //短信发送记录创建时间

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
