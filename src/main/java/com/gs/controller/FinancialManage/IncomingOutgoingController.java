package com.gs.controller.FinancialManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.IncomingOutgoing;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.entity.EchartData;
import com.gs.common.entity.Series;
import com.gs.service.IncomingOutgoingService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by GZWangBin on 2017/4/20.
 */
@Controller
@RequestMapping("/incomingOutgoing")
public class IncomingOutgoingController {

    private Logger logger = (Logger) LoggerFactory.getLogger(IncomingOutgoingController.class);

    /**
     * 收入Service
     */
    @Resource
    public IncomingOutgoingService incomingOutgoingService;

    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<IncomingOutgoing> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("收支记录分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(incomingOutgoingService.count());
        List<IncomingOutgoing> incomingOutgoings = incomingOutgoingService.queryByPager(pager);
        return new Pager4EasyUI<IncomingOutgoing>(pager.getTotalRecords(), incomingOutgoings);
    }

    @ResponseBody
    @RequestMapping(value = "queryByPagerDisable",method = RequestMethod.GET)
    public Pager4EasyUI<IncomingOutgoing> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("收支记录分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(incomingOutgoingService.countByDisable());
        List<IncomingOutgoing> incomingOutgoings = incomingOutgoingService.queryByPagerDisable(pager);
        return new Pager4EasyUI<IncomingOutgoing>(pager.getTotalRecords(), incomingOutgoings);
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(String id, String status) {
        if (id != null && !id.equals("") && status != null && !status.equals("")) {
            if (status.equals("N")) {
                incomingOutgoingService.active(id);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                incomingOutgoingService.inactive(id);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
            return ControllerResult.getFailResult("操作失败");
        }
    }
    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(IncomingOutgoing incomingOutgoing) {
        logger.info("添加收支记录");
        incomingOutgoingService.insert(incomingOutgoing);
        return ControllerResult.getSuccessResult("添加成功");
    }



    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(IncomingOutgoing incomingOutgoing) {
        logger.info("修改收支记录");
        incomingOutgoingService.update(incomingOutgoing);
        return ControllerResult.getSuccessResult("修改成功");
    }



    @ResponseBody
    @RequestMapping(value = "queryByYear")
    public List<IncomingOutgoing> queryByYear(String start, String end){
        logger.info("根据年份去查找图表");
        System.out.println("开始时间" + start + "结束时间" + end);
        List<IncomingOutgoing> list=incomingOutgoingService.queryByYear(start, end);
        for (IncomingOutgoing incomingOutgoing : list) {
            if (incomingOutgoing.getInTypeId() == null) {

            }
            System.out.println(incomingOutgoing + "list");
        }
        return list;
    }

    @ResponseBody
    @RequestMapping(value = "queryByMonth")
    public List<IncomingOutgoing> queryByMonth(String start, String end){
        logger.info("根据月份去查找图表");
        System.out.println("开始时间" + start + "结束时间" + end);
        List<IncomingOutgoing> list=incomingOutgoingService.queryByMonth(start, end);
        return list;
    }


    @ResponseBody
    @RequestMapping(value = "queryByDay")
    public List<IncomingOutgoing> queryByDay(String start, String end){
        logger.info("根据日去查找图表");
        System.out.println("开始时间" + start + "结束时间" + end);
        List<IncomingOutgoing> list=incomingOutgoingService.queryByDay(start, end);
        return list;
    }

    @ResponseBody
    @RequestMapping(value = "queryByQuarter")
    public List<IncomingOutgoing> queryByQuarter(String start, String end){
        logger.info("根据季度查找图表");
        System.out.println("开始时间" + start + "结束时间" + end);
        List<IncomingOutgoing> list=incomingOutgoingService.queryByQuarter(start, end);
        return list;
    }

    @ResponseBody
    @RequestMapping(value = "queryByWeek")
    public List<IncomingOutgoing> queryByWeek(String start, String end){
        logger.info("根据周期查找图表");
        System.out.println("开始时间" + start + "结束时间" + end);
        List<IncomingOutgoing> list=incomingOutgoingService.queryByWeek(start, end);
        return list;
    }

}
