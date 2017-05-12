package com.gs.controller.maintainScheduleManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.MaintainSchedule;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.MaintainScheduleService;
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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by jyy on 2017/5/4.
 */

@Controller
@RequestMapping("/maintainSchedule")
public class MaintainScheduleController {

    @Resource
    private MaintainScheduleService maintainScheduleService;
    private Logger logger = (Logger) LoggerFactory.getLogger(MaintainScheduleController.class);

    /**
     * 查询全部维修保养进度管理
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryAllschedule", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAllSchedule(){
        if(SessionUtil.isLogin(session)) {
            String roles="系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,车主,汽车公司接待员";
            if(RoleUtil.checkRoles(roles)) {
                logger.info("查询全部维修保养进度管理");
                List<MaintainSchedule> maintainSchedules = maintainScheduleService.queryAll();
                List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
                for(MaintainSchedule m : maintainSchedules){
                    ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
                    comboBox4EasyUI.setId(m.getMaintainScheduleId());
                    comboBox4EasyUI.setText(m.getMaintainScheduleId());
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

    /**
     * 分页查询进度管理
     * @param pageNumber
     * @param PageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPage", method = RequestMethod.GET)
    public Pager4EasyUI queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize){
        if(SessionUtil.isLogin(session)) {
            String roles="系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员,车主,汽车公司总技师";
            if(RoleUtil.checkRoles(roles)) {
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setTotalRecords(maintainScheduleService.count());
                logger.info("分页查询维修保养进度管理成功");
                List<MaintainSchedule> maintainSchedules = maintainScheduleService.queryByPager(pager);
                return new Pager4EasyUI<MaintainSchedule>(pager.getTotalRecords(), maintainSchedules);
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
     * 添加维修保养进度管理
     * @param maintainSchedule
     * @return
     */
    @ResponseBody
    @RequestMapping(value="addSchedule", method = RequestMethod.POST)
    public ControllerResult addSchedule(MaintainSchedule maintainSchedule){
        if(SessionUtil.isLogin(session)) {
            String roles="系统超级管理员,公司超级管理员,公司普通管理员,汽车公司总技师";
            if(RoleUtil.checkRoles(roles)) {
                if(maintainSchedule !=null && !maintainSchedule.equals("")){
                    maintainScheduleService.insert(maintainSchedule);
                    logger.info("添加成功");
                    return ControllerResult.getSuccessResult("添加成功");
                }else{
                    return ControllerResult.getFailResult("添加失败，请检查输入的信息是否有误");
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

    @ResponseBody
    @RequestMapping(value = "updateSchedule", method = RequestMethod.POST)
    public ControllerResult updateSchedule(MaintainSchedule maintainSchedule){
        if(SessionUtil.isLogin(session)) {
            String roles="公司超级管理员,公司普通管理员,汽车公司总技师";
            if(RoleUtil.checkRoles(roles)) {
                if(maintainSchedule !=null && !maintainSchedule.equals("")){
                    maintainScheduleService.update(maintainSchedule);
                    logger.info("修改成功");
                    return ControllerResult.getSuccessResult("修改成功");
                }else{
                    return ControllerResult.getFailResult("修改失败");
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
     * 日期格式
     * @param binder
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

}
