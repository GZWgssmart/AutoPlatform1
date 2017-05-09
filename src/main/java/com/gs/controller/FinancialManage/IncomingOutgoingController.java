package com.gs.controller.FinancialManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.IncomingOutInFo;
import com.gs.bean.IncomingOutgoing;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.entity.EchartData;
import com.gs.common.entity.Series;
import com.gs.common.util.DateFormatUtil;
import com.gs.service.IncomingOutgoingService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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
        incomingOutgoing.setCompanyId("1");
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
    @RequestMapping(value = "queryByCondition")
    public List<IncomingOutInFo> queryByCondition(String start, String end, String type){

        List<IncomingOutInFo> list = null;
        IncomingOutgoing incomingOutgoing = null;
        List<IncomingOutgoing> timeList = null;
        List<IncomingOutgoing> outList = null;
        List<IncomingOutgoing> inList = null;
        list = new ArrayList<IncomingOutInFo>();
        timeList=incomingOutgoingService.queryByCondition(start, end, "0","year");
        outList=incomingOutgoingService.queryByCondition(start, end, "1","year");
        inList=incomingOutgoingService.queryByCondition(start, end, "2","year");
        if (type != null && !type.equals("")) {
            if (type.equals("year")) {
                for (int p=0; p<timeList.size();p++) {
                    IncomingOutInFo io = new IncomingOutInFo();
                    String ag = DateFormatUtil.YearFormater(timeList.get(p).getInOutCreatedTime());
                    io.setDate(ag);
                    for (int j = 0; j < outList.size(); j++) {
                        String outTime = DateFormatUtil.YearFormater(outList.get(j).getInOutCreatedTime());
                        if(ag.equals(outTime)){
                            io.setOutMoney(outList.get(j).getInOutMoney());
                        }
                    }
                    for (int k = 0; k < inList.size(); k++) {
                        String inTime = DateFormatUtil.YearFormater(inList.get(k).getInOutCreatedTime());
                        if(ag.equals(inTime)){
                            io.setInMoney(inList.get(k).getInOutMoney());
                        }
                    }
                    list.add(io);
                }
            } else if (type.equals("quarter")) {
                timeList=incomingOutgoingService.queryByCondition(start, end, "0","quarter");
                outList=incomingOutgoingService.queryByCondition(start, end, "1","quarter");
                inList=incomingOutgoingService.queryByCondition(start, end, "2","quarter");
                for (int p = 0; p < timeList.size(); p++) {
                    IncomingOutInFo io = new IncomingOutInFo();
                    Date ag = timeList.get(p).getInOutCreatedTime();
                    io.setDateTime(ag);
                    for (int j = 0; j < outList.size(); j++) {
                        if (ag.equals(outList.get(j).getInOutCreatedTime())) {
                            if (outList.get(j) != null) {
                                io.setOutMoney(outList.get(j).getInOutMoney());
                            } else if (outList.get(j) == null) {
                                io.setOutMoney(0.d);
                            }
                        }
                    }
                    for (int k = 0; k < inList.size(); k++) {
                        if (ag.equals(inList.get(k).getInOutCreatedTime())) {
                            if (inList.get(k) != null) {
                                io.setInMoney(inList.get(k).getInOutMoney());
                            } else if (inList.get(k) == null) {
                                io.setOutMoney(0.d);
                            }
                        }
                    }
                    list.add(io);
                }
            } else if (type.equals("month")) {
                timeList=incomingOutgoingService.queryByCondition(start, end, "0","month");
                outList=incomingOutgoingService.queryByCondition(start, end, "1","month");
                inList=incomingOutgoingService.queryByCondition(start, end, "2","month");
                for (int p=0; p<timeList.size();p++) {
                    IncomingOutInFo io = new IncomingOutInFo();
                    String ag = DateFormatUtil.MonthFormater(timeList.get(p).getInOutCreatedTime());
                    io.setDate(ag);
                    for (int j = 0; j < outList.size(); j++) {
                        String outTime = DateFormatUtil.MonthFormater(outList.get(j).getInOutCreatedTime());
                        if(ag.equals(outTime)){
                            if (outList.get(j) != null) {
                                io.setOutMoney(outList.get(j).getInOutMoney());
                            } else if (outList.get(j) == null){
                                io.setOutMoney(0.d);
                            }
                        }
                    }
                    for (int k = 0; k < inList.size(); k++) {
                        String inTime = DateFormatUtil.MonthFormater(inList.get(k).getInOutCreatedTime());
                        if(ag.equals(inTime)){
                            if (inList.get(k)!= null) {
                                io.setInMoney(inList.get(k).getInOutMoney());
                            } else if (inList.get(k) == null){
                                io.setOutMoney(0.d);
                            }
                        }
                    }
                    list.add(io);
                }
            } else if (type.equals("week")) {
                timeList=incomingOutgoingService.queryByCondition(start, end, "0","week");
                outList=incomingOutgoingService.queryByCondition(start, end, "1","week");
                inList=incomingOutgoingService.queryByCondition(start, end, "2","week");
                for (int p = 0; p < timeList.size(); p++) {
                    IncomingOutInFo io = new IncomingOutInFo();
                    Date ag = timeList.get(p).getInOutCreatedTime();
                    io.setDateTime(ag);
                    for (int j = 0; j < outList.size(); j++) {
                        if (ag.equals(outList.get(j).getInOutCreatedTime())) {
                            if (outList.get(j) != null) {
                                io.setOutMoney(outList.get(j).getInOutMoney());
                            } else if (outList.get(j) == null) {
                                io.setOutMoney(0.d);
                            }
                        }
                    }
                    for (int k = 0; k < inList.size(); k++) {
                        if (ag.equals( inList.get(k).getInOutCreatedTime())) {
                            if (inList.get(k) != null) {
                                io.setInMoney(inList.get(k).getInOutMoney());
                            } else if (inList.get(k) == null) {
                                io.setOutMoney(0.d);
                            }
                        }
                    }
                    list.add(io);
                }
            } else if (type.equals("day")) {
                timeList=incomingOutgoingService.queryByCondition(start, end, "0","day");
                outList=incomingOutgoingService.queryByCondition(start, end, "1","day");
                inList=incomingOutgoingService.queryByCondition(start, end, "2","day");
                for (int p = 0; p < timeList.size(); p++) {
                    IncomingOutInFo io = new IncomingOutInFo();
                    String ag = DateFormatUtil.DayFormater(timeList.get(p).getInOutCreatedTime());
                    io.setDate(ag);
                    for (int j = 0; j < outList.size(); j++) {
                        String outTime = DateFormatUtil.DayFormater(outList.get(j).getInOutCreatedTime());
                        if (ag.equals(outTime)) {
                            if (outList.get(j) != null) {
                                io.setOutMoney(outList.get(j).getInOutMoney());
                            } else if (outList.get(j) == null) {
                                io.setOutMoney(0.d);
                            }
                        }
                    }
                    for (int k = 0; k < inList.size(); k++) {
                        String inTime = DateFormatUtil.DayFormater(inList.get(k).getInOutCreatedTime());
                        if (ag.equals(inTime)) {
                            if (inList.get(k) != null) {
                                io.setInMoney(inList.get(k).getInOutMoney());
                            } else if (inList.get(k) == null) {
                                io.setOutMoney(0.d);
                            }
                        }
                    }
                    list.add(io);
                }
            }
        }
        return list;
    }

}
