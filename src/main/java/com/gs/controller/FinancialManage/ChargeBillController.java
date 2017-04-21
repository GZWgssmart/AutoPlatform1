package com.gs.controller.FinancialManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.ChargeBill;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.ChargeBillService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by GZWangBin on 2017/4/21.
 */
@Controller
@RequestMapping("/chargeBill")
public class ChargeBillController {

    private Logger logger = (Logger) LoggerFactory.getLogger(ChargeBillController.class);

    /**
     * 收入Service
     */
    @Resource
    public ChargeBillService chargeBillService;

    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<ChargeBill> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("收费单据分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(chargeBillService.count());
        List<ChargeBill> chargeBills = chargeBillService.queryByPager(pager);
        return new Pager4EasyUI<ChargeBill>(pager.getTotalRecords(), chargeBills);
    }

    @ResponseBody
    @RequestMapping(value = "queryByPagerDisable",method = RequestMethod.GET)
    public Pager4EasyUI<ChargeBill> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("收费单据分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(chargeBillService.countByDisable());
        List<ChargeBill> ChargeBills = chargeBillService.queryByPagerDisable(pager);
        return new Pager4EasyUI<ChargeBill>(pager.getTotalRecords(), ChargeBills);
    }


    @ResponseBody
    @RequestMapping(value = "inactive",method = RequestMethod.POST)
    public ControllerResult inactive(String id) {
        logger.info("禁用");
        chargeBillService.inactive(id);
        return ControllerResult.getSuccessResult("禁用成功");
    }

    @ResponseBody
    @RequestMapping(value = "active",method = RequestMethod.POST)
    public ControllerResult active(String id) {
        logger.info("激活");
        chargeBillService.active(id);
        return ControllerResult.getSuccessResult("激活成功");
    }

    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(ChargeBill chargeBill) {
        logger.info("添加收费单据");
        chargeBillService.insert(chargeBill);
        return ControllerResult.getSuccessResult("添加成功");
    }


}
