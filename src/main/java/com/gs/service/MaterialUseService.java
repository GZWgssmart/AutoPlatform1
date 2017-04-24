package com.gs.service;

import com.gs.bean.MaterialUse;
import com.gs.bean.User;
import com.gs.bean.view.RecordBaseView;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author 程燕
*@since 2017-04-17 16:08:02
*@des 领料信息Service
*/
public interface MaterialUseService extends BaseService<String, MaterialUse>{
    /**
     *
     * 不是应该放在这个Bean中的,但是会与其他人的有碰撞,所以放在这里
     *
     */
    public List<RecordBaseView> queryNoUseRecord(String companyId, Pager pager);
    public int countNoUseRecord(String companyId);
    public List<User> companyEmps(String companyId);
}