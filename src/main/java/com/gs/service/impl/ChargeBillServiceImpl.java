package com.gs.service.impl;

import com.gs.bean.ChargeBill;
import com.gs.bean.Checkin;
import com.gs.common.bean.Pager;
import com.gs.dao.ChargeBillDAO;
import com.gs.service.ChargeBillService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 由CSWangBin技术支持
 *
 * @author CSWangBin
 * @des 收费单据Service实现
 * @since 2017-04-17 15:56:02
 */
@Service
public class ChargeBillServiceImpl implements ChargeBillService {

    @Resource
    private ChargeBillDAO chargeBillDAO;

    public int insert(ChargeBill chargeBill) {
        return chargeBillDAO.insert(chargeBill);
    }

    public int batchInsert(List<ChargeBill> list) {
        return chargeBillDAO.batchInsert(list);
    }

    public int delete(ChargeBill chargeBill) {
        return chargeBillDAO.delete(chargeBill);
    }

    public int deleteById(String id) {
        return chargeBillDAO.deleteById(id);
    }

    public int batchDelete(List<ChargeBill> list) {
        return chargeBillDAO.batchDelete(list);
    }

    public int update(ChargeBill chargeBill) {
        return chargeBillDAO.update(chargeBill);
    }

    public int batchUpdate(List<ChargeBill> list) {
        return chargeBillDAO.batchUpdate(list);
    }

    public List<ChargeBill> queryAll() {
        return chargeBillDAO.queryAll();
    }

    public List<ChargeBill> queryAll(String status) {
        return chargeBillDAO.queryAll(status);
    }

    public List<ChargeBill> queryByStatus(String status) {
        return chargeBillDAO.queryAll(status);
    }

    public ChargeBill query(ChargeBill chargeBill) {
        return chargeBillDAO.query(chargeBill);
    }

    public ChargeBill queryById(String id) {
        return chargeBillDAO.queryById(id);
    }

    public List<ChargeBill> queryByPager(Pager pager) {
        return chargeBillDAO.queryByPager(pager);
    }

    public int count() {
        return chargeBillDAO.count();
    }

    public int inactive(String id) {
        return chargeBillDAO.inactive(id);
    }

    public int active(String id) {
        return chargeBillDAO.active(id);
    }

    public List<ChargeBill> queryByPagerDisable(Pager pager) {
        return chargeBillDAO.queryByPagerDisable(pager);
    }

    public int countByDisable() {
        return chargeBillDAO.countByDisable();
    }

    public List<Checkin> blurredQuery(Pager pager, ChargeBill chargeBill) {
        return null;
    }

    public int countByBlurred(ChargeBill chargeBill) {
        return 0;
    }
}