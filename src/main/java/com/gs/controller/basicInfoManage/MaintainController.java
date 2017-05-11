package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.MaintainFix;
import com.gs.bean.MaintainFixAcc;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.MaintainFixAccService;
import com.gs.service.MaintainFixService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 保养项目管理
 * Created by yaoyong on 2017/4/18.
 */

@Controller
@RequestMapping("/maintain")
public class MaintainController {

    private Logger logger = (Logger) LoggerFactory.getLogger(MaintainController.class);

    @Resource
    private MaintainFixService maintainFixService;

    @Resource
    private MaintainFixAccService maintainFixAccService;

    /**
     * 分页查询维修项目信息
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerService", method = RequestMethod.GET)
    public Pager4EasyUI queryByPagerService(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(maintainFixService.count());
        logger.info("分页查询维修项目信息");
        List<MaintainFix> maintainFixes = maintainFixService.queryByPager(pager);
        return new Pager4EasyUI<MaintainFix>(pager.getTotalRecords(), maintainFixes);
    }

    /**
     * 分页查询保养项目信息
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerMaintain", method = RequestMethod.GET)
    public Pager4EasyUI queryByPagerMaintain(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(maintainFixService.count());
        logger.info("分页查询保养项目信息");
        List<MaintainFix> maintainFixes = maintainFixService.queryByPagerMaintain(pager);
        return new Pager4EasyUI<MaintainFix>(pager.getTotalRecords(), maintainFixes);
    }

    /**
     * 分页查询所有维修保养项目信息
     */
    @ResponseBody
    @RequestMapping(value = "queryByPagerAll",method = RequestMethod.GET)
    public Pager4EasyUI queryByPagerAll(@Param("pageNumber") String pageNumber,@Param("pageSize") String pageSize) {
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(maintainFixService.count());
        logger.info("分页查询所有维修保养项目信息");
        List<MaintainFix> maintainFixes = maintainFixService.queryByPagerAll(pager);
        return new Pager4EasyUI<MaintainFix>(pager.getTotalRecords(),maintainFixes);
    }

    @ResponseBody
    @RequestMapping(value = "queryByDetailsByPager", method = RequestMethod.GET)
    public Pager4EasyUI queryByDetailsByPager(@Param("maintainId") String maintainId, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize){
        logger.info("分页查询此记录下所有明细");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(maintainFixAccService.countByDetails(maintainId));
        List<MaintainFixAcc> maintainFixAccs = maintainFixAccService.queryByDetailsByPager(pager,maintainId);
        System.out.print(maintainFixAccs);
        return new Pager4EasyUI<MaintainFixAcc>(pager.getTotalRecords(), maintainFixAccs);
    }

    /**
     * 查询所有保养项目
     */
    @ResponseBody
    @RequestMapping(value = "queryAllItem", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAll(){
        logger.info("查询所有保养项目");
        List<MaintainFix> MaintainFixs = maintainFixService.queryAll();
        List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
        for(MaintainFix m : MaintainFixs){
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(m.getMaintainId());
            comboBox4EasyUI.setText(m.getMaintainName());
            comboxs.add(comboBox4EasyUI);
        }
        return comboxs;
    }

    @ResponseBody
    @RequestMapping(value = "addService",method = RequestMethod.POST)
    public ControllerResult addService(MaintainFix maintainFix){
        if(maintainFix != null && !maintainFix.equals("")){
            logger.info("添加维修项目");
            maintainFix.setMaintainOrFix("维修");
            maintainFixService.insert(maintainFix);
            return ControllerResult.getSuccessResult("添加维修项目成功");
        }else {
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }

    @ResponseBody
    @RequestMapping(value = "accadd",method =  RequestMethod.POST)
    public ControllerResult accadd(MaintainFixAcc maintainFixAcc){
        if(maintainFixAcc != null && !maintainFixAcc.equals("")){
            logger.info("添加配件成功");
            maintainFixAccService.insert(maintainFixAcc);
            return ControllerResult.getSuccessResult("添加配件成功");
        }else {
            return ControllerResult.getFailResult("添加配件失败，请输入必要的信息");
        }
    }

    @ResponseBody
    @RequestMapping(value = "accedit",method =  RequestMethod.POST)
    public ControllerResult accedit(MaintainFixAcc maintainFixAcc){
        if(maintainFixAcc != null && !maintainFixAcc.equals("")){
            logger.info("修改配件成功");
            maintainFixAccService.update(maintainFixAcc);
            return ControllerResult.getSuccessResult("修改配件成功");
        }else {
            return ControllerResult.getFailResult("添加配件失败，请输入必要的信息");
        }
    }

    @ResponseBody
    @RequestMapping(value = "addMaintain",method = RequestMethod.POST)
    public ControllerResult InsertMaintain(MaintainFix maintainFix){
        if(maintainFix != null && !maintainFix.equals("")){
            logger.info("添加保养项目");
            maintainFix.setMaintainOrFix("保养");
            maintainFixService.insert(maintainFix);
            return ControllerResult.getSuccessResult("添加保养项目成功");
        }else {
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }

    /**
     * 修改保养项目信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult updateAccBuy(MaintainFix maintainFix) {
        if (maintainFix != null && !maintainFix.equals("")) {
            maintainFixService.update(maintainFix);
            logger.info("修改成功");
            return ControllerResult.getSuccessResult("修改成功");
        } else {
            return ControllerResult.getFailResult("修改失败");
        }
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    /**
     * 分页查询所有被禁用的保养项目
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<MaintainFix> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有被禁用的保养项目");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(maintainFixService.countByDisable());
        List<MaintainFix> maintainFixes = maintainFixService.queryByPagerDisable(pager);
        return new Pager4EasyUI<MaintainFix>(pager.getTotalRecords(), maintainFixes);
    }

    /**
     * 分页查询所有被禁用的维修项目
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerDisableService", method = RequestMethod.GET)
    public Pager4EasyUI<MaintainFix> queryByPagerDisableService(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有被禁用的维修项目");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(maintainFixService.countByDisableService());
        List<MaintainFix> maintainFixes = maintainFixService.queryByPagerDisableService(pager);
        return new Pager4EasyUI<MaintainFix>(pager.getTotalRecords(), maintainFixes);
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(String id, String status) {
        if (id != null && !id.equals("") && status != null && !status.equals("")) {
            if (status.equals("N")) {
                maintainFixService.active(id);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                maintainFixService.inactive(id);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
            return ControllerResult.getFailResult("操作失败");
        }
    }

}
