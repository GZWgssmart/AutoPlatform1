package com.gs.bean;

import java.util.Date;

/**
 * Created by XiaoQiao on 2017/4/14.
 */

/**
 * 投诉
 */
public class Complaint {

    private String complaintId; //投诉编号
    private String userId; //用户编号
    private String complaintContent; //投诉内容
    private Date complaintCreatedTime; //投诉时间
    private String complaintReply; //投诉回复内容
    private Date complaintReplyTime; //投诉回复时间
    private String complaintReplyUser; //投诉回复人,来源于t_user表

    public String getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(String complaintId) {
        this.complaintId = complaintId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getComplaintContent() {
        return complaintContent;
    }

    public void setComplaintContent(String complaintContent) {
        this.complaintContent = complaintContent;
    }

    public Date getComplaintCreatedTime() {
        return complaintCreatedTime;
    }

    public void setComplaintCreatedTime(Date complaintCreatedTime) {
        this.complaintCreatedTime = complaintCreatedTime;
    }

    public String getComplaintReply() {
        return complaintReply;
    }

    public void setComplaintReply(String complaintReply) {
        this.complaintReply = complaintReply;
    }

    public Date getComplaintReplyTime() {
        return complaintReplyTime;
    }

    public void setComplaintReplyTime(Date complaintReplyTime) {
        this.complaintReplyTime = complaintReplyTime;
    }

    public String getComplaintReplyUser() {
        return complaintReplyUser;
    }

    public void setComplaintReplyUser(String complaintReplyUser) {
        this.complaintReplyUser = complaintReplyUser;
    }
}
