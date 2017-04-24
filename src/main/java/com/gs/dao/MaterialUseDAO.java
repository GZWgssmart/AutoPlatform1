package com.gs.dao;

import com.gs.bean.MaterialUse;
import com.gs.bean.User;
import com.gs.bean.WorkInfo;
import com.gs.bean.view.RecordBaseView;
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

    /**
     *
     * 不是应该放在这个Bean中的,但是会与其他人的有碰撞,所以放在这里
     *
     */
    public List<RecordBaseView> queryNoUseRecord(@Param("companyId")String companyId, @Param("pager")Pager pager);
    public int countNoUseRecord(@Param("companyId")String companyId);
    public List<User> companyEmps(@Param("companyId")String companyId);
    public int insertWorkInfo(@Param("workInfo")WorkInfo workInfo);
}