package com.gs.controller.userManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.IncomingOutgoing;
import com.gs.bean.WorkInfo;
import com.gs.bean.echarts.QuarterUtil;
import com.gs.bean.echarts.WorkInFoBean;
import com.gs.common.bean.*;
import com.gs.common.util.DateFormatUtil;
import com.gs.common.util.UUIDUtil;
import com.gs.service.WorkInfoService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.util.ArrayList;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**订单查询
 * Created by jyy on 2017/4/20.
 */
@Controller
@RequestMapping("/Order")
public class OrderManageController {

    private Logger logger= (Logger) LoggerFactory.getLogger(OrderManageController.class);

    @Resource
    private WorkInfoService workInfoService;
    //private MaintainRecordService maintainRecordService

    @ResponseBody
    @RequestMapping(value = "queryAll",method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAllWork(){
        if(SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员," +
                    "汽车公司总技师,汽车公司技师,汽车公司学徒,汽车公司销售人员,汽车公司财务人员,汽车公司采购人员," +
                    "汽车公司库管人员,汽车公司人力资源管理部";
            if(RoleUtil.checkRoles(roles)) {
                logger.info("查询所有订单");
                List<WorkInfo> workInfosList = workInfoService.queryAll();
                List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
                for(WorkInfo work : workInfosList){
                    ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
                    comboBox4EasyUI.setId(work.getWorkId());
                    comboBox4EasyUI.setText(work.getRecordId());
                    comboxs.add(comboBox4EasyUI);
                }
                return comboxs;
            }else{
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        }else{
            logger.info("请先登录");
            return null;
        }
    }

    /*
     * 分页查询
     * @param pageNumber
     * @param pageSize
     * @return
*/
    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<WorkInfo> queryByPager(httpSession session, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        if(SessionUtil.isLogin(session)) {
                String roles="系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员";
            if(RoleUtil.checkRoles(roles)) {
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setTotalRecords(workInfoService.count());
                List<WorkInfo> worksList = workInfoService.queryByPager(pager);
                return new Pager4EasyUI<WorkInfo>(pager.getTotalRecords(), worksList);
            }else{
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        }else{
            logger.info("请先登录");
            return null;
        }
    }

    /**
     * 维修保养进度查看
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryBySche",method = RequestMethod.GET)
    public Pager4EasyUI<WorkInfo> queryBySche(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        if(SessionUtil.isLogin(session)) {
            String roles="系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,车主";
            if(RoleUtil.checkRoles(roles)) {
                logger.info("维修保养记录分页查询");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setTotalRecords(workInfoService.count());
                List<WorkInfo> worksList = workInfoService.queryByPagerschelude(pager);
                return new Pager4EasyUI<WorkInfo>(pager.getTotalRecords(), worksList);
            }else{
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        }else{
            logger.info("请先登录");
            return null;
        }
    }

/*    @ResponseBody
    @RequestMapping(value="queryByUserId/{id}",method="RequestMethod.GET")
    public List<ComboBox4EasyUI> queryUserId(@PathVariable ("id") String id){
        List<WorkInfo> workinfos = workInfoService.queryByUserId(id);
        List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
        for(WorkInfo w : workinfos){
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(work.getUserId());
            comboBox4EasyUI.setText(work.getUserNickname());
            comboxs.add(comboBox4EasyUI);
        }
    }*/
    /**
     * 查询所有未完成工单
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<WorkInfo> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        if(SessionUtil.isLogin(session)) {
            String roles="汽车公司总技师,公司超级管理员";
            if(RoleUtil.checkRoles(roles)) {
                logger.info("分页查询所有被禁用登记记录");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setTotalRecords(workInfoService.countByDisable());
                List<WorkInfo> worklLis = workInfoService.queryByPagerDisable(pager);
                return new Pager4EasyUI<WorkInfo>(pager.getTotalRecords(), worklLis);
            }else{
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        }else{
            logger.info("请先登录");
            return null;
        }
    }

/*    *//**
     *添加订单
     * @param workInfo
     * @return
     *//*
    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.GET)
    public ControllerResult addWork(WorkInfo workInfo) {
        logger.info("添加订单");
        workInfo.setUserId(UUIDUtil.uuid());
        workInfo.setWorkStatus("Y");
        workInfoService.insert(workInfo);
        return ControllerResult.getSuccessResult("添加成功");
    }*/

    /**
     * 修改订单
     * @param workInfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult updateWork(WorkInfo workInfo) {
        if(SessionUtil.isLogin(session)) {
            String roles="汽车公司总技师,公司超级管理员";
            if(RoleUtil.checkRoles(roles)) {
                if(workInfo!=null && !workInfo.equals("")){
                    logger.info("修改工单");
                    System.out.println("fdjsldkfls");
                    workInfoService.update(workInfo);
                    return ControllerResult.getSuccessResult("修改成功");
                }else{
                    return ControllerResult.getFailResult("修改失败，请输入正确的信息");
                }
            }else{
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        }else{
            logger.info("请先登录");
            return null;
        }

    }


    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate",method = RequestMethod.POST)
    public ControllerResult inactive(String id,String status){
        if(SessionUtil.isLogin(session)) {
            String roles="汽车公司总技师,公司超级管理员";
            if(RoleUtil.checkRoles(roles)) {
                if (id != null && !id.equals("") && status != null && !status.equals("")) {
                    if (status.equals("N")) {
                        workInfoService.active(id);
                        logger.info("激活成功");
                        return ControllerResult.getSuccessResult("激活成功");
                    } else {
                        workInfoService.inactive(id);
                        logger.info("禁用成功");
                        return ControllerResult.getSuccessResult("禁用成功");
                    }
                } else {
                    return ControllerResult.getFailResult("操作失败");
                }
            }else{
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        }else{
                logger.info("请先登录");
                return null;
                }
    }

    /**
     *日期格式
     * @param binder
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @ResponseBody
    @RequestMapping(value = "queryByCondition")
    public List<WorkInFoBean> queryByCondition(String start, String end, String type){
        logger.info("根据年月日周季去查询所有的工单");
        List<WorkInFoBean> list = null;
        List<WorkInfo> timeList = null;
        List<WorkInfo> maintainList = null;
        List<WorkInfo> preserveList = null;
        list = new ArrayList<WorkInFoBean>();
        if (type != null && !type.equals("")) {
            if (type.equals("year")) {
                timeList = workInfoService.queryByCondition(start, end,"1","0","year");
                maintainList=workInfoService.queryByCondition(start, end,"1","1","year");
                preserveList=workInfoService.queryByCondition(start, end,"1","2","year");
                for (int p = 0; p < timeList.size(); p++) {
                    WorkInFoBean io = new WorkInFoBean();
                    String ag = DateFormatUtil.YearFormater(timeList.get(p).getWorkCreatedTime());
                    io.setDate(ag);
                    for (int j = 0; j < maintainList.size(); j++) {
                        String outTime = DateFormatUtil.YearFormater(maintainList.get(j).getWorkCreatedTime());
                        if (ag.equals(outTime)) {
                            io.setMaintainCount(maintainList.get(j).getCount());
                            break;
                        } else {
                            io.setMaintainCount(0);
                        }
                    }
                    for (int k = 0; k < preserveList.size(); k++) {
                        String inTime = DateFormatUtil.YearFormater(preserveList.get(k).getWorkCreatedTime());
                        if (ag.equals(inTime)) {
                            io.setPreserveCount(preserveList.get(k).getCount());
                            break;
                        } else {
                            io.setPreserveCount(0);
                        }
                    }
                    list.add(io);
                }

            } else if (type.equals("quarter")) {
                timeList = workInfoService.queryByCondition(start, end,"1","0","quarter");
                maintainList=workInfoService.queryByCondition(start, end,"1","1","quarter");
                preserveList=workInfoService.queryByCondition(start, end,"1","2","quarter");
                for (int p = 0; p < timeList.size(); p++) {
                    WorkInFoBean io = new WorkInFoBean();
                    String ag = DateFormatUtil.MonthFormater(timeList.get(p).getWorkCreatedTime());
                    QuarterUtil.quarter(ag);
                    io.setDate(ag);
                    for (int j = 0; j < maintainList.size(); j++) {
                        String outTime = DateFormatUtil.MonthFormater(maintainList.get(j).getWorkCreatedTime());
                        QuarterUtil.quarter(outTime);
                        if (ag.equals(outTime)) {
                            io.setMaintainCount(maintainList.get(j).getCount());
                            break;
                        } else {
                            io.setMaintainCount(0);
                        }
                    }
                    for (int k = 0; k < preserveList.size(); k++) {
                        String inTime = DateFormatUtil.MonthFormater(preserveList.get(k).getWorkCreatedTime());
                        QuarterUtil.quarter(inTime);
                        if (ag.equals(inTime)) {
                            io.setPreserveCount(preserveList.get(k).getCount());
                            break;
                        } else {
                            io.setPreserveCount(0);
                        }
                    }
                    list.add(io);
                }
            } else if (type.equals("month")) {
                timeList = workInfoService.queryByCondition(start, end,"1","0","month");
                maintainList=workInfoService.queryByCondition(start, end,"1","1","month");
                preserveList=workInfoService.queryByCondition(start, end,"1","2","month");
                for (int p = 0; p < timeList.size(); p++) {
                    WorkInFoBean io = new WorkInFoBean();
                    String ag = DateFormatUtil.MonthFormater(timeList.get(p).getWorkCreatedTime());
                    io.setDate(ag);
                    for (int j = 0; j < maintainList.size(); j++) {
                        String outTime = DateFormatUtil.MonthFormater(maintainList.get(j).getWorkCreatedTime());
                        if (ag.equals(outTime)) {
                            io.setMaintainCount(maintainList.get(j).getCount());
                            break;
                        } else {
                            io.setMaintainCount(0);
                        }
                    }
                    for (int k = 0; k < preserveList.size(); k++) {
                        String inTime = DateFormatUtil.MonthFormater(preserveList.get(k).getWorkCreatedTime());
                        if (ag.equals(inTime)) {
                            io.setPreserveCount(preserveList.get(k).getCount());
                            break;
                        } else {
                            io.setPreserveCount(0);
                        }
                    }
                    list.add(io);
                }
            } else if (type.equals("week")) {
                timeList = workInfoService.queryByCondition(start, end,"1","0","day");
                maintainList=workInfoService.queryByCondition(start, end,"1","1","day");
                preserveList=workInfoService.queryByCondition(start, end,"1","2","day");
                for (int p = 0; p < timeList.size(); p++) {
                    WorkInFoBean io = new WorkInFoBean();
                    String ag = DateFormatUtil.WEEK(timeList.get(p).getWorkCreatedTime());
                    String year = DateFormatUtil.YearFormater(timeList.get(p).getWorkCreatedTime());
                    String time = String.valueOf(Echarts.getWeek(ag));
                    String yearTime = time + year;
                    io.setDate(year + "第" + time + "周");
                    for (int j = 0; j < maintainList.size(); j++) {
                        String outTime = DateFormatUtil.WEEK(maintainList.get(j).getWorkCreatedTime());
                        String outYear = DateFormatUtil.YearFormater(maintainList.get(j).getWorkCreatedTime());
                        String out = String.valueOf(Echarts.getWeek(outTime));
                        String yearOut = out + outYear;
                        if (yearTime.equals(yearOut)) {
                            io.setMaintainCount(maintainList.get(j).getCount());
                            break;
                        } else {
                            io.setMaintainCount(0);
                        }
                    }
                    for (int k = 0; k < preserveList.size(); k++) {
                        String inTime = DateFormatUtil.WEEK(preserveList.get(k).getWorkCreatedTime());
                        String inYear = DateFormatUtil.YearFormater(preserveList.get(k).getWorkCreatedTime());
                        String in = String.valueOf(Echarts.getWeek(inTime));
                        String yearIn = in + inYear;
                        if (yearTime.equals(yearIn)) {
                            io.setPreserveCount(preserveList.get(k).getCount());
                            break;
                        } else {
                            io.setPreserveCount(0);
                        }
                    }
                    list.add(io);
                }
            } else if (type.equals("day")) {
                timeList = workInfoService.queryByCondition(start, end,"1","0","day");
                maintainList=workInfoService.queryByCondition(start, end,"1","1","day");
                preserveList=workInfoService.queryByCondition(start, end,"1","2","day");
                for (int p = 0; p < timeList.size(); p++) {
                    WorkInFoBean io = new WorkInFoBean();
                    String ag = DateFormatUtil.DayFormater(timeList.get(p).getWorkCreatedTime());
                    io.setDate(ag);
                    for (int j = 0; j < maintainList.size(); j++) {
                        String outTime = DateFormatUtil.DayFormater(maintainList.get(j).getWorkCreatedTime());
                        if (ag.equals(outTime)) {
                            io.setMaintainCount(maintainList.get(j).getCount());
                            break;
                        } else {
                            io.setMaintainCount(0);
                        }
                    }
                    for (int k = 0; k < preserveList.size(); k++) {
                        String inTime = DateFormatUtil.DayFormater(preserveList.get(k).getWorkCreatedTime());
                        if (ag.equals(inTime)) {
                            io.setPreserveCount(preserveList.get(k).getCount());
                            break;
                        } else {
                            io.setPreserveCount(0);
                        }
                    }
                    list.add(io);
                }
            }
        }
        return list;
    }
}
