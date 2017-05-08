package com.gs.controller.userManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.IncomingOutgoing;
import com.gs.bean.WorkInfo;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
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

/**工单管理
 * Created by jyy on 2017/4/20.
 */
@Controller
@RequestMapping("/Order")
public class OrderManageController {

    private Logger logger= (Logger) LoggerFactory.getLogger(OrderManageController.class);

    @Resource
    private WorkInfoService workInfoService;

    @ResponseBody
    @RequestMapping(value = "queryAll",method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAllWork(){
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
    }




    /*
     * 分页查询
     * @param pageNumber
     * @param pageSize
     * @return
*/

    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<WorkInfo> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("收入类型分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(workInfoService.count());
        List<WorkInfo> worksList = workInfoService.queryByPager(pager);
        return new Pager4EasyUI<WorkInfo>(pager.getTotalRecords(), worksList);
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
        logger.info("分页查询所有被禁用登记记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(workInfoService.countByDisable());
        List<WorkInfo> worklLis = workInfoService.queryByPagerDisable(pager);
        return new Pager4EasyUI<WorkInfo>(pager.getTotalRecords(), worklLis);
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
        if(workInfo!=null && !workInfo.equals("")){
            logger.info("修改订单");
            System.out.println("fdjsldkfls");
            workInfoService.update(workInfo);
            return ControllerResult.getSuccessResult("修改成功");
        }else{
            return ControllerResult.getFailResult("修改失败，请输入正确的信息");
        }

    }


    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate",method = RequestMethod.POST)
    public ControllerResult inactive(String id,String status){
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

    /**
     * 根据年月日周季去查询所有的工单
     */
    @ResponseBody
    @RequestMapping(value = "queryByCondition")
    public List<WorkInfo> queryByCondition(String start, String end, String type){
        List<WorkInfo> list = null;
        if (type != null && !type.equals("")) {
            if (type.equals("year")) {
                list=workInfoService.queryByCondition(start, end,"1","year");
                for (WorkInfo workInfo : list) {
                    System.out.println(workInfo);
                }
            } else if (type.equals("quarter")) {
                list=workInfoService.queryByCondition(start, end,"1","quarter");
            } else if (type.equals("month")) {
                list=workInfoService.queryByCondition(start, end,"1","month");
            } else if (type.equals("week")) {
                list=workInfoService.queryByCondition(start, end,"1","week");
            } else if (type.equals("day")) {
                list=workInfoService.queryByCondition(start,end,"1","day");
            }
        }
        return list;
    }
}
