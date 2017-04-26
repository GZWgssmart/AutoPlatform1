package com.gs.service;

import com.gs.bean.MaterialList;
import com.gs.bean.view.MaterialView;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:06:48
*@des 物料清单Service
*/
public interface MaterialListService extends BaseService<String, MaterialList>{
    public List<MaterialView> queryByPager(String userId, Pager pager);

    public int count(String userId);

    public List<MaterialList> recordAccsByPager(String recordId, Pager pager);
    public int countRecordAccs(String recordId);
}