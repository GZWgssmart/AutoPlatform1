package com.gs.bean;



import java.util.Date;
/**
 * 维修保养进度管理
 * Created by jyy on 2017/5/4.
 */
public class MaintainSchedule {

    private String maintainScheduleId;
    private String maintainRecordId;
    private String maintainScheduleDes;
    private Date msCreatedTime;
    private String msStatus;

    public String getMaintainScheduleId() {
        return maintainScheduleId;
    }

    public void setMaintainScheduleId(String maintainScheduleId) {
        this.maintainScheduleId = maintainScheduleId;
    }

    public String getMaintainRecordId() {
        return maintainRecordId;
    }

    public void setMaintainRecordId(String maintainRecordId) {
        this.maintainRecordId = maintainRecordId;
    }

    public String getMaintainScheduleDes() {
        return maintainScheduleDes;
    }

    public void setMaintainScheduleDes(String maintainScheduleDes) {
        this.maintainScheduleDes = maintainScheduleDes;
    }

    public Date getMsCreatedTime() {
        return msCreatedTime;
    }

    public void setMsCreatedTime(Date msCreatedTime) {
        this.msCreatedTime = msCreatedTime;
    }

    public String getMsStatus() {
        return msStatus;
    }

    public void setMsStatus(String msStatus) {
        this.msStatus = msStatus;
    }



    @Override
    public String toString() {
        return "MaintainSchedule{" +
                "maintainScheduleId='" + maintainScheduleId + '\'' +
                ", maintainRecordId='" + maintainRecordId + '\'' +
                ", maintainScheduleDes='" + maintainScheduleDes + '\'' +
                ", msCreatedTime=" + msCreatedTime +
                ", msStatus='" + msStatus + '\'' +
                '}';
    }
}
