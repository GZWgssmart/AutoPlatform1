package com.gs.bean;

import java.util.Date;

public class MaterialList {
    private String materialId;

    private String maintainRecordId;

    private String accId;

    private Integer materialCount;

    private Date materialCreatedTime;

    private String materialStatus;

    public String getMaterialId() {
        return materialId;
    }

    public void setMaterialId(String materialId) {
        this.materialId = materialId;
    }

    public String getMaintainRecordId() {
        return maintainRecordId;
    }

    public void setMaintainRecordId(String maintainRecordId) {
        this.maintainRecordId = maintainRecordId;
    }

    public String getAccId() {
        return accId;
    }

    public void setAccId(String accId) {
        this.accId = accId;
    }

    public Integer getMaterialCount() {
        return materialCount;
    }

    public void setMaterialCount(Integer materialCount) {
        this.materialCount = materialCount;
    }

    public Date getMaterialCreatedTime() {
        return materialCreatedTime;
    }

    public void setMaterialCreatedTime(Date materialCreatedTime) {
        this.materialCreatedTime = materialCreatedTime;
    }

    public String getMaterialStatus() {
        return materialStatus;
    }

    public void setMaterialStatus(String materialStatus) {
        this.materialStatus = materialStatus;
    }
}