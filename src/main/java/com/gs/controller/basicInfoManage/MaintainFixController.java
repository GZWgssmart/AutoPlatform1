package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.MaintainFix;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.MaintainFixService;
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
import java.util.Date;
import java.util.List;

/**
 * 维修保养项目管理
 * Created by yaoyong on 2017/4/18.
 */

@Controller
@RequestMapping("/maintainfix")
public class MaintainFixController {

    private Logger logger = (Logger) LoggerFactory.getLogger(MaintainFixController.class);

    @Resource
    private MaintainFixService maintainFixService;

    /**
     * 分页查询维修保养项目信息
     */
    @ResponseBody
    @RequestMapping(value="queryByPage", method = RequestMethod.GET)
    public Pager4EasyUI queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(maintainFixService.count());
        logger.info("分页查询维修保养项目信息成功");
        List<MaintainFix> maintainFixes = maintainFixService.queryByPager(pager);
        return new Pager4EasyUI<MaintainFix>(pager.getTotalRecords(), maintainFixes);
    }

    /**
     * 添加维修保养项目信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addMaintainFix", method = RequestMethod.POST)
    public ControllerResult addAccBuy(MaintainFix maintainFix) {
        if (maintainFix != null && !maintainFix.equals("")) {
            System.out.println(maintainFix.toString());
            maintainFixService.insert(maintainFix);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("添加成功");
        } else {
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }

    /**
     * 删除维修保养项目信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "removeMaintainFix", method = RequestMethod.POST)
    public ControllerResult removeAccBuy(String id) {
        if (id != null && !id.equals("")) {
            maintainFixService.deleteById(id);
            logger.info("删除成功");
            return ControllerResult.getSuccessResult("删除成功");
        } else {
            return ControllerResult.getFailResult("删除失败");
        }
    }


    /**
     * 修改维修保养项目信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateMaintainFix", method = RequestMethod.POST)
    public ControllerResult updateAccBuy(MaintainFix maintainFix) {
        if (maintainFix != null && !maintainFix.equals("")) {
            maintainFixService.update(maintainFix);
            logger.info("修改成功");
            return ControllerResult.getSuccessResult("修改成功");
        } else {
            return ControllerResult.getFailResult("修改失败");
        }
    }

    /**
     * 查询所有被禁用的维修保养项目信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<MaintainFix> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有被禁用维修保养项目信息");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(maintainFixService.countByDisable());
        List<MaintainFix> maintainFixes = maintainFixService.queryByPagerDisable(pager);
        return new Pager4EasyUI<MaintainFix>(pager.getTotalRecords(), maintainFixes);
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(String maintainId, String maintainStatus) {
        System.out.println("前台传过来来的值为"+maintainId+",状态为"+maintainStatus);
        if (maintainId != null && !maintainId.equals("") && maintainStatus != null && !maintainStatus.equals("")) {
            if (maintainStatus.equals("N")) {
                maintainFixService.active(maintainId);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                maintainFixService.inactive(maintainId);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
            return ControllerResult.getFailResult("操作失败");
        }
    }


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

}
