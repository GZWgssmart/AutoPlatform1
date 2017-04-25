package com.gs.controller.maintenanceReceptionManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.MaintainDetail;
import com.gs.bean.MaterialList;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.MaintainDetailService;
import com.gs.service.MaintainFixAccService;
import com.gs.service.MaterialListService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 维修保养明细管理controller， 张文星
 */
@Controller
@RequestMapping("/maintainDetail")
public class MaintainDetailController {

    private Logger logger = (Logger) LoggerFactory.getLogger(MaintainDetailController.class);

    // 明细service
    @Resource
    private MaintainDetailService maintainDetailService;
    // 物料清单service
    @Resource
    private MaterialListService materialListService;
    // 项目配件service
    @Resource
    private MaintainFixAccService maintainFixAccService;

    /**
     * 查询所有明细
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPager", method = RequestMethod.GET)
    public Pager4EasyUI<MaintainDetail> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有明细");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(maintainDetailService.count());
        List<MaintainDetail> maintainDetails = maintainDetailService.queryByPager(pager);
        return new Pager4EasyUI<MaintainDetail>(pager.getTotalRecords(), maintainDetails);
    }

    /**
     * 根据维修保养记录查询此记录下所有明细
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByDetailPager/{recordId}", method = RequestMethod.GET)
    public Pager4EasyUI<MaintainDetail> queryByRecordIdPager(@PathVariable("recordId") String recordId, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询此记录下所有明细");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(maintainDetailService.countByDetail(recordId));
        List<MaintainDetail> maintainDetails = maintainDetailService.queryByDetailByPager(pager, recordId);
        System.out.print(maintainDetails);
        return new Pager4EasyUI<MaintainDetail>(pager.getTotalRecords(), maintainDetails);
    }

    /**
     * 添加维修保养明细
     */
    @ResponseBody
    @RequestMapping(value = "add", method = RequestMethod.POST)
    public ControllerResult addCheckin(MaintainDetail maintainDetail) {
        logger.info("添加维修保养明细");
        maintainDetailService.insert(maintainDetail);
        return ControllerResult.getSuccessResult("添加成功");
    }

    /**
     * 修改维修保养明细
     */
    @ResponseBody
    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public ControllerResult editCheckin(MaintainDetail maintainDetail) {
        logger.info("修改维修保养明细");
        maintainDetailService.update(maintainDetail);
        return ControllerResult.getSuccessResult("修改成功");
    }

    /**
     * 用户确认, 此时生成所有物料清单
     */
    @ResponseBody
    @RequestMapping(value = "userConfirm/{recordId}/{ids}", method = RequestMethod.POST)
    public ControllerResult userConfirm(@PathVariable("recordId") String recordId,@PathVariable("ids") String ids) {
        logger.info("用户确认明细清单, 这时生成所有物料清单");
        MaterialList materialList = new MaterialList();
        materialList.setMaintainRecordId(recordId);
       // materialListService.insert(materialList);
        return ControllerResult.getSuccessResult("确定成功");
    }

    /**
     * 时间格式化
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
