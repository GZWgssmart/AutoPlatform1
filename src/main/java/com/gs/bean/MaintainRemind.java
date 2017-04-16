package com.gs.bean;

import java.util.Date;

/**
 * Created by XiaoQiao on 2017/4/14.
 */

/**
 * 保养提醒记录
 */
public class MaintainRemind {

    private String remindId; //保养提醒记录编号
    private String userId; //用户编号
    private Date lastMaintainTime; //上次保养时间
    private double lastMaintainMileage; //上次保养汽车行驶里程
    private String remindMsg; //保养提醒消息
    private Date remindTime; //保养提醒时间
    private String remindType; //保养提醒方式，如邮箱，手机短信
    private Date remindCreatedTime; //保养提醒记录创建时间

    public String getRemindId() {
        return remindId;
    }

    public void setRemindId(String remindId) {
        this.remindId = remindId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getLastMaintainTime() {
        return lastMaintainTime;
    }

    public void setLastMaintainTime(Date lastMaintainTime) {
        this.lastMaintainTime = lastMaintainTime;
    }

    public double getLastMaintainMileage() {
        return lastMaintainMileage;
    }

    public void setLastMaintainMileage(double lastMaintainMileage) {
        this.lastMaintainMileage = lastMaintainMileage;
    }

    public String getRemindMsg() {
        return remindMsg;
    }

    public void setRemindMsg(String remindMsg) {
        this.remindMsg = remindMsg;
    }

    public Date getRemindTime() {
        return remindTime;
    }

    public void setRemindTime(Date remindTime) {
        this.remindTime = remindTime;
    }

    public String getRemindType() {
        return remindType;
    }

    public void setRemindType(String remindType) {
        this.remindType = remindType;
    }

    public Date getRemindCreatedTime() {
        return remindCreatedTime;
    }

    public void setRemindCreatedTime(Date remindCreatedTime) {
        this.remindCreatedTime = remindCreatedTime;
    }
}
