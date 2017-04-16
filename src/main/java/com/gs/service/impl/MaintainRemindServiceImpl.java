package com.gs.service.impl;

import com.gs.bean.MaintainRemind;
import com.gs.common.bean.Pager;
import com.gs.dao.MaintainRemindDAO;
import com.gs.service.MaintainRemindService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by XiaoQiao on 2017/4/16.
 */
@Service
public class MaintainRemindServiceImpl implements MaintainRemindService {

    @Resource
    private MaintainRemindDAO maintainRemindDAO;

    public int insert(MaintainRemind maintainRemind) {
        return maintainRemindDAO.insert(maintainRemind);
    }

    public int batchInsert(List<MaintainRemind> list) {
        return maintainRemindDAO.batchInsert(list);
    }

    public int delete(MaintainRemind maintainRemind) {
        return maintainRemindDAO.delete(maintainRemind);
    }

    public int deleteById(String id) {
        return maintainRemindDAO.deleteById(id);
    }

    public int batchDelete(List<MaintainRemind> list) {
        return maintainRemindDAO.batchDelete(list);
    }

    public int update(MaintainRemind maintainRemind) {
        return maintainRemindDAO.update(maintainRemind);
    }

    public int batchUpdate(List<MaintainRemind> list) {
        return maintainRemindDAO.batchUpdate(list);
    }

    public List<MaintainRemind> queryAll() {
        return maintainRemindDAO.queryAll();
    }

    public List<MaintainRemind> queryAll(String status) {
        return maintainRemindDAO.queryAll(status);
    }

    public MaintainRemind query(MaintainRemind maintainRemind) {
        return maintainRemindDAO.query(maintainRemind);
    }

    public MaintainRemind queryById(String id) {
        return maintainRemindDAO.queryById(id);
    }

    public List<MaintainRemind> queryByPager(Pager pager) {
        return maintainRemindDAO.queryByPager(pager);
    }

    public int count() {
        return maintainRemindDAO.count();
    }

    public int inactive(String id) {
        return maintainRemindDAO.inactive(id);
    }

    public int active(String id) {
        return maintainRemindDAO.active(id);
    }
}
