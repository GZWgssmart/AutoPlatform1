package com.gs.bean;

import java.util.Date;

public class MaterialUse {
    private String materialUseId;

    private String matainRecordId;

    private String accId;

    private Integer accCount;

    private Date muCreatedTime;

    private Date muUseDate;

    /**
     *  关联其它表的其它实例
     */
    private MaintainRecord record;

    private Accessories accessories;


    public String getMaterialUseId() {
        return materialUseId;
    }

    public void setMaterialUseId(String materialUseId) {
        this.materialUseId = materialUseId;
    }

    public String getMatainRecordId() {
        return matainRecordId;
    }

    public void setMatainRecordId(String matainRecordId) {
        this.matainRecordId = matainRecordId;
    }

    public String getAccId() {
        return accId;
    }

    public void setAccId(String accId) {
        this.accId = accId;
    }

    public Integer getAccCount() {
        return accCount;
    }

    public void setAccCount(Integer accCount) {
        this.accCount = accCount;
    }

    public Date getMuCreatedTime() {
        return muCreatedTime;
    }

    public void setMuCreatedTime(Date muCreatedTime) {
        this.muCreatedTime = muCreatedTime;
    }

    public Date getMuUseDate() {
        return muUseDate;
    }

    public void setMuUseDate(Date muUseDate) {
        this.muUseDate = muUseDate;
    }

    /**
     *
     * 关联到其它表的get / set
     */

    public MaintainRecord getRecord() {
        return record;
    }

    public void setRecord(MaintainRecord record) {
        this.record = record;
    }

    public Accessories getAccessories() {
        return accessories;
    }

    public void setAccessories(Accessories accessories) {
        this.accessories = accessories;
    }
}