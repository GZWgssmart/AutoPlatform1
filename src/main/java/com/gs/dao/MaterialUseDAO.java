package com.gs.dao;

import com.gs.bean.*;
import com.gs.bean.view.*;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author 程燕
*@since 2017-04-17 16:08:01
*@des 领料信息dao
*/
@Repository
public interface MaterialUseDAO extends BaseDAO<String, MaterialUse>{

    public List<MaterialURTemp> materialByPager(@Param("pager")Pager pager);

    public List<MaterialURTemp> materialByPager(@Param("pager")Pager pager,@Param("userId")String userId);

    public int countMaterials();
    public int countMaterials(@Param("userId")String userId);

    /**
     *
     * 不是应该放在这个Bean中的,但是会与其他人的有碰撞,所以放在这里
     *
     */
    public List<RecordBaseView> queryCurRecordsByPager(@Param("companyId")String companyId,@Param("hasEmp")String hasEmp, @Param("pager")Pager pager);
    public int countNoUseRecord(@Param("companyId")String companyId);
    public List<User> companyEmps(@Param("companyId")String companyId);
    public int insertWorkInfo(WorkInfo workInfo);

    public List<WorkView> userWorksByPager(@Param("userId")String userId,@Param("pager") Pager pager);
    public List<WorkView> userWorksByPager(@Param("userId")String userId,@Param("status")String status,@Param("pager") Pager pager);

    public int countUserWorks(@Param("userId")String userId);
    public int countUserWorks(@Param("userId")String userId, @Param("status")String status);

    public WorkInfo queryWorkInfoByRecordId(@Param("recordId")String recordId);
    public List<DetailTemp> queryDetailsByRecordId(@Param("recordId")String recordId, @Param("companyId")String companyId, @Param("pager")Pager pager);
    public int countDetailsByRecordId(@Param("recordId")String recordId,@Param("companyId")String companyId);

    public int updWorkInfoUser(@Param("recordId")String recordId, @Param("userId")String userId);

}