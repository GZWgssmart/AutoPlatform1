package com.gs.controller.maintenanceReceptionManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.*;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.*;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
    // 工单service
    @Resource
    private WorkInfoService workInfoService;
    // 维修保养记录service
    @Resource
    private MaintainRecordService maintainRecordService;

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
    public ControllerResult add(MaintainDetail maintainDetail) {
        logger.info("添加维修保养明细");
        maintainDetailService.insert(maintainDetail);
        return ControllerResult.getSuccessResult("添加成功");
    }

    /**
     * 修改维修保养明细
     */
    @ResponseBody
    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public ControllerResult edit(MaintainDetail maintainDetail) {
        logger.info("修改维修保养明细");
        maintainDetailService.update(maintainDetail);
        return ControllerResult.getSuccessResult("修改成功");
    }

    /**
     * 用户确认, 此时生成所有物料清单, 两个参数一个为维修保养记录id, 一个为所有项目ids
     */
    @ResponseBody
    @RequestMapping(value = "userConfirm/{recordId}/{ids}", method = RequestMethod.POST)
    public ControllerResult userConfirm(@PathVariable("recordId") String recordId,@PathVariable("ids") String ids) {
        logger.info("用户确认明细清单, 这时生成所有物料清单和工单");
        if(recordId != null && recordId != "" && ids!= null && ids != "") {
            List<MaintainFixAcc> maintainFixAccs = maintainFixAccService.queryByRecord(ids);
            System.out.print(maintainFixAccs);
            if(maintainFixAccs != null) {
                    List<MaterialList> materialLists = new ArrayList<MaterialList>();
                    for (MaintainFixAcc m : maintainFixAccs) {
                        MaterialList materialList = new MaterialList();
                        materialList.setMaintainRecordId(recordId);
                        materialList.setAccId(m.getAccId());
                        materialList.setMaterialCount(m.getAccCount());
                        materialLists.add(materialList);
                    }
                    materialListService.insertList(materialLists); // 生成物料清单
                    // 用户确认之后, 生成工单, 指派员工进行施工
                    WorkInfo w = new WorkInfo();
                    w.setRecordId(recordId);
                    workInfoService.insert(w);
                    // 修改维修保养记录中的开始时间
                    MaintainRecord maintainRecord = maintainRecordService.queryById(recordId);
                    maintainRecord.setStartTime(new Date());
                    maintainRecordService.update(maintainRecord);
                    return ControllerResult.getSuccessResult("确定成功");
            }else{
                return ControllerResult.getFailResult("确定失败, 此维修保养记录中的所有明细中的维修项目并没有配件");
            }
        }else{
            return ControllerResult.getFailResult("确定失败");
        }
    }

    /**
     * 维修保养记录模糊查询
     * @return
     */
    @ResponseBody
    @RequestMapping(value="blurredQuery", method = RequestMethod.GET)
    public Pager4EasyUI<MaintainRecord> blurredQuery(HttpServletRequest request, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("维修保养记录模糊查询");
        String text = request.getParameter("text");
        String value = request.getParameter("value");
        if(text != null && text!="") {
            Pager pager = new Pager();
            pager.setPageNo(Integer.valueOf(pageNumber));
            pager.setPageSize(Integer.valueOf(pageSize));
            List<MaintainRecord> maintainRecords = null;
            MaintainRecord maintainRecord = new MaintainRecord();
            Checkin checkin = new Checkin();
            if(text.equals("车主/电话/汽车公司/车牌号")){ // 当多种模糊搜索条件时
                checkin.setUserPhone(value);
                checkin.setCarPlate(value);
                checkin.setUserName(value);
                checkin.setCompanyId(value);
                maintainRecord.setCheckin(checkin);
            }else if(text.equals("车主")){
                checkin.setUserName(value);
                maintainRecord.setCheckin(checkin);
            }else if(text.equals("汽车公司")){
                checkin.setCompanyId(value);
                maintainRecord.setCheckin(checkin);
            }else if(text.equals("车牌号")){
                checkin.setCarPlate(value);
                maintainRecord.setCheckin(checkin);
            }else if(text.equals("电话")){
                checkin.setUserPhone(value);
                maintainRecord.setCheckin(checkin);
            }
            maintainRecords = maintainRecordService.blurredQuery(pager, maintainRecord);
            pager.setTotalRecords(maintainRecordService.countByBlurred(maintainRecord));
            return new Pager4EasyUI<MaintainRecord>(pager.getTotalRecords(), maintainRecords);
        }else{
            return null;
        }
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
