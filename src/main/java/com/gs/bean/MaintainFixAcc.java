package com.gs.bean;

/**
 * 维修保养项目
 */
public class MaintainFixAcc {
    private String mainAccId;//保养项目配件编号

    private String maintainId;//保养项目编号 来源于t_maintain_fix表

    private String accId;//配件编号 来源于t_accessories表

    private Integer accCount;//配件个数

    public String getMainAccId() {
        return mainAccId;
    }

    public void setMainAccId(String mainAccId) {
        this.mainAccId = mainAccId;
    }

    public String getMaintainId() {
        return maintainId;
    }

    public void setMaintainId(String maintainId) {
        this.maintainId = maintainId;
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
}