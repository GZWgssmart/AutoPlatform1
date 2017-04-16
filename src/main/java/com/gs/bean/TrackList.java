package com.gs.bean;

import java.util.Date;

/**
 * Created by XiaoQiao on 2017/4/14.
 */

/**
 * 跟踪回访
 */
public class TrackList {

    private String trackId; //跟踪回访编号
    private String userId; //用户编号
    private String trackContent; //回访的问题
    private int serviceEvaluate; //本次服务评价
    private String trackUser; //跟踪回访用户
    private Date trackCreatedTime; //跟踪回访创建时间

    public String getTrackId() {
        return trackId;
    }

    public void setTrackId(String trackId) {
        this.trackId = trackId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTrackContent() {
        return trackContent;
    }

    public void setTrackContent(String trackContent) {
        this.trackContent = trackContent;
    }

    public int getServiceEvaluate() {
        return serviceEvaluate;
    }

    public void setServiceEvaluate(int serviceEvaluate) {
        this.serviceEvaluate = serviceEvaluate;
    }

    public String getTrackUser() {
        return trackUser;
    }

    public void setTrackUser(String trackUser) {
        this.trackUser = trackUser;
    }

    public Date getTrackCreatedTime() {
        return trackCreatedTime;
    }

    public void setTrackCreatedTime(Date trackCreatedTime) {
        this.trackCreatedTime = trackCreatedTime;
    }
}
