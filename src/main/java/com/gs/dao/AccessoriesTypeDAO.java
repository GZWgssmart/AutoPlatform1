package com.gs.dao;

import com.gs.bean.AccessoriesType;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:49:13
*@des 配件分类dao
*/
@Repository
public interface AccessoriesTypeDAO extends BaseDAO<String, AccessoriesType>{
    /**
     * 分页查询被禁用的记录
     */
    public List<AccessoriesType> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();

    /**
     * 模糊查询
     */
    public List<AccessoriesType> blurredQuery(@Param("pager")Pager pager, @Param("accType")AccessoriesType accessoriesType);

    /**
     * 模糊查询的记录数
     */
    public int countByBlurred(@Param("accType")AccessoriesType accessoriesType);
}