package com.gs.bean.view;

import com.gs.bean.MaterialUse;
import com.gs.bean.WorkInfo;

/**
 * 继承自Use,但是多添加一个字段
 *
 * @author Administrator
 * @create 2017-04-25 20:14
 */
public class MaterialURTemp extends MaterialUse {
    private String flag;
    private WorkInfo workInfo;

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public WorkInfo getWorkInfo() {
        return workInfo;
    }

    public void setWorkInfo(WorkInfo workInfo) {
        this.workInfo = workInfo;
    }
}
