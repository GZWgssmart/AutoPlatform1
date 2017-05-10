package com.gs.service;

import com.gs.bean.Accessories;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:36:37
*@des 配件表
*/
public interface AccessoriesService extends BaseService<String, Accessories>{
    /**
     * 分页查询被禁用的记录
     */
    public List<Accessories> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();

    public List<Accessories> queryByIdPager(@Param("id") String id, @Param("pager") Pager pager);

    public int updateCount(@Param("accCount") int accCount,@Param("accId") String accId);
}