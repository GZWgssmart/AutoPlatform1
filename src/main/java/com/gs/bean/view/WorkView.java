package com.gs.bean.view;

import java.util.Date;

/**
 * 员工工单分页列
 *
 * @author Administrator
 * @create 2017-04-24 19:24
 */
public class WorkView {
    private String workId;
    private String recordId;
    private String colorRGB;
    private String colorName;
    private String carplate;
    private String carmodel;
    private String carbrand;
    private String userRequests;
    private Date workAssignTime;

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

    public String getColorRGB() {
        return colorRGB;
    }

    public void setColorRGB(String colorRGB) {
        this.colorRGB = colorRGB;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getCarplate() {
        return carplate;
    }

    public void setCarplate(String carplate) {
        this.carplate = carplate;
    }

    public String getCarmodel() {
        return carmodel;
    }

    public void setCarmodel(String carmodel) {
        this.carmodel = carmodel;
    }

    public String getCarbrand() {
        return carbrand;
    }

    public void setCarbrand(String carbrand) {
        this.carbrand = carbrand;
    }

    public String getUserRequests() {
        return userRequests;
    }

    public void setUserRequests(String userRequests) {
        this.userRequests = userRequests;
    }

    public Date getWorkAssignTime() {
        return workAssignTime;
    }

    public void setWorkAssignTime(Date workAssignTime) {
        this.workAssignTime = workAssignTime;
    }
}
