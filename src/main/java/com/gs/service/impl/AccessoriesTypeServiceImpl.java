package com.gs.service.impl;

import com.gs.bean.AccessoriesType;
import com.gs.dao.AccessoriesTypeDAO;
import com.gs.service.AccessoriesTypeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:49:20
*@des 配件分类Service实现
*/
@Service
public class AccessoriesTypeServiceImpl implements AccessoriesTypeService {

    @Resource
    private AccessoriesTypeDAO accessoriesTypeDAO;

    public int insert(AccessoriesType accessoriesType) {
        return accessoriesTypeDAO.insert(accessoriesType);
    }

    public int batchInsert(List<AccessoriesType> list) {
        return accessoriesTypeDAO.batchInsert(list);
    }

    public int delete(AccessoriesType accessoriesType) {
        return accessoriesTypeDAO.delete(accessoriesType);
    }

    public int deleteById(String id) {
        return accessoriesTypeDAO.deleteById(id);
    }

    public int batchDelete(List<AccessoriesType> list) {
        return accessoriesTypeDAO.batchDelete(list);
    }

    public int update(AccessoriesType accessoriesType) {
        return accessoriesTypeDAO.update(accessoriesType);
    }

    public int batchUpdate(List<AccessoriesType> list) {
        return accessoriesTypeDAO.batchUpdate(list);
    }

    public List<AccessoriesType> queryAll() {
        return accessoriesTypeDAO.queryAll();
    }

    @Override
    public List<AccessoriesType> queryAll(String status) {
        return accessoriesTypeDAO.queryAll();
    }

    public List<AccessoriesType> queryByStatus(String status) {
        return accessoriesTypeDAO.queryAll(status);
    }

    public AccessoriesType query(AccessoriesType accessoriesType) {
        return accessoriesTypeDAO.query(accessoriesType);
    }

    public AccessoriesType queryById(String id) {
        return accessoriesTypeDAO.queryById(id);
    }

    public List<AccessoriesType> queryByPager(Pager pager) {
        return accessoriesTypeDAO.queryByPager(pager);
    }

    public int count() {
        return accessoriesTypeDAO.count();
    }

    public int inactive(String id) {
        return accessoriesTypeDAO.inactive(id);
    }

    public int active(String id) {
        return accessoriesTypeDAO.active(id);
    }

}