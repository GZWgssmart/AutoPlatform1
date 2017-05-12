package com.gs.service;

import com.gs.bean.*;
import com.gs.bean.view.*;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
*由CSWangBin技术支持
*
*@author 程燕
*@since 2017-04-17 16:08:02
*@des 领料信息Service
*/
public interface MaterialUseService extends BaseService<String, MaterialUse>{

    public List<MaterialURTemp> histByPager(Pager pager);

    public List<MaterialURTemp> userHistByPager(Pager pager,String userId);

    public int countHist();
    public int countUserHist(String userId);

    public List<MaterialURTemp> queryUseFlowingbyPager(String flowName, String companyId, String roleId , Pager pager);

    public int countUseFlowing(String flowName,String companyId, String roleId);

    public List<MaterialURTemp> queryReturnFlowingbyPager(String flowName, String companyId, String roleId , Pager pager);

    public int countReturnFlowing(String flowName,String companyId, String roleId);

    public List queryHistoryFlowingbyPager(String companyId,String  flowName,String taskKey, Pager pager);

    public int countHistoryFlowing(String companyId, String flowName);

    public List queryUserFlowingByPager(String flowName, String userId, String reviewTaskName, Pager pager);

    public int countUserFlowing(String flowName, String userId);

    /**
     *
     * 不是应该放在这个Bean中的,但是会与其他人的有碰撞,所以放在这里
     *
     */
    public List<RecordBaseView> queryNoUseRecord( String companyId, Pager pager);
    public List<RecordBaseView> queryHasUseRecord(String companyId, Pager pager);
    public int countNoUseRecord(String companyId);
    public List<User> companyEmps(String companyId);
    public int insertWorkInfo(WorkInfo workInfo);

    public List<WorkView> userWorksByPager(String userId, Pager pager);
    public List<WorkView> userWorksStatusByPager(String userId,String status,Pager pager);
    public int countUserWorks(String userId);
    public int countUserWorksStatus(String userId, String status);
    public boolean recordIsDisp(String recordId);
    public List<DetailTemp> queryDetailsByRecordId(String recordId, String companyId, Pager pager);
    public int countDetailsByRecordId(String recordId,String companyId);
    public int updWorkInfoUser(String recordId, String userId);

    public Accessories accQueryById(String accId);
}