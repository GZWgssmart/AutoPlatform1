package com.gs.controller.clearingOut;

import ch.qos.logback.classic.Logger;
import com.gs.bean.ChargeBill;
import com.gs.bean.Checkin;
import com.gs.bean.MaintainRecord;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.ExcelExport;
import com.gs.service.ChargeBillService;
import com.gs.service.CheckinService;
import com.gs.service.MaintainRecordService;
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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 收费单据管理controller， 张文星
 */
@Controller
@RequestMapping("/charge")
public class ChargeDocumentsController {

    private Logger logger = (Logger) LoggerFactory.getLogger(ChargeDocumentsController.class);

    // 登记service
    @Resource
    private CheckinService checkinService;
    // 维修保养记录service
    @Resource
    private MaintainRecordService maintainRecordService;
    // 收费单据service
    @Resource
    private ChargeBillService chargeBillService;

    /**
     * 分页查询所有收费单据
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPager", method = RequestMethod.GET)
    public Pager4EasyUI<ChargeBill> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有收费单据");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(chargeBillService.count());
        List<ChargeBill> chargeBills = chargeBillService.queryByPager(pager);
        return new Pager4EasyUI<ChargeBill>(pager.getTotalRecords(), chargeBills);
    }

    /**
     * 查询所有被禁用的登记记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<ChargeBill> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有被禁用收费单据");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(chargeBillService.countByDisable());
        List<ChargeBill> chargeBills = chargeBillService.queryByPagerDisable(pager);
        return new Pager4EasyUI<ChargeBill>(pager.getTotalRecords(), chargeBills);
    }

    @ResponseBody
    @RequestMapping(value = "add", method = RequestMethod.POST)
    public ControllerResult addCheckin(ChargeBill chargeBill) {
        logger.info("添加收费单据");
        chargeBillService.insert(chargeBill);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public ControllerResult editCheckin(ChargeBill chargeBill) {
        logger.info("修改收费单据");
        chargeBillService.update(chargeBill);
        return ControllerResult.getSuccessResult("修改成功");
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(String id, String status) {
        if (id != null && !id.equals("") && status != null && !status.equals("")) {
            if (status.equals("N")) {
                chargeBillService.active(id);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                chargeBillService.inactive(id);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
            return ControllerResult.getFailResult("操作失败");
        }
    }

    /**
     * 收费单据模糊查询
     * @return
     */
    @ResponseBody
    @RequestMapping(value="blurredQuery", method = RequestMethod.GET)
    public Pager4EasyUI<ChargeBill> blurredQuery(HttpServletRequest request, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("登记记录模糊查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        String text = request.getParameter("text");
        String value = request.getParameter("value");
        if(text != null && text!="") {
            List<ChargeBill> chargeBills = null;
            ChargeBill chargeBill = new ChargeBill();
            MaintainRecord maintainRecord = new MaintainRecord();
            Checkin checkin = new Checkin();
            if(text.equals("车主/电话/汽车公司/车牌号")){ // 当多种模糊搜索条件时
                checkin.setUserName(value);
                checkin.setCompanyId(value);
                checkin.setCarPlate(value);
                checkin.setUserPhone(value);
            }else if(text.equals("车主")){
                checkin.setUserName(value);
            }else if(text.equals("汽车公司")){
                checkin.setCompanyId(value);
            }else if(text.equals("车牌号")){
                checkin.setCarPlate(value);
            }else if(text.equals("电话")){
                checkin.setUserPhone(value);
            }
            maintainRecord.setCheckin(checkin);
            chargeBill.setMaintainRecord(maintainRecord);
            chargeBills = chargeBillService.blurredQuery(pager, chargeBill);
            pager.setTotalRecords(chargeBillService.countByBlurred(chargeBill));
            return new Pager4EasyUI<ChargeBill>(pager.getTotalRecords(), chargeBills);
        }else{
            pager.setTotalRecords(chargeBillService.count());
            List<ChargeBill> chargeBills = chargeBillService.queryByPager(pager);
            return new Pager4EasyUI<ChargeBill>(pager.getTotalRecords(), chargeBills);
        }
    }

    @RequestMapping(value="exportExcel", method = RequestMethod.GET)
    public void exportExcel(HttpServletRequest request, HttpServletResponse response) {
        logger.info("收费单据导出");
        try {
            ChargeBill chargeBill = new ChargeBill();
            // 查询所有收费单据
            List<ChargeBill> chargeBills = chargeBillService.queryAll();
            String title = "收费单据";
            String[] rowsName = new String[]{"收费单据编号", "车主姓名", "车主手机", "汽车品牌",
                    "汽车车型", "汽车颜色", "汽车车牌", "车牌号码", "维修保养记录提车时间",
                    "维修保养记录描述", "付款方式", "总金额", "实际付款", "收费时间", "收费单据创建时间",
                    "收费单据描述", "收费单据状态"};
            List<Object[]> dataList = new ArrayList<Object[]>();
            Object[] objs = null;
            for (ChargeBill c : chargeBills) {
                objs = new Object[rowsName.length];
                objs[0] = c.getChargeBillId();
                objs[1] = c.getMaintainRecord().getCheckin().getUserName();
                objs[2] = c.getMaintainRecord().getCheckin().getUserPhone();
                objs[3] = c.getMaintainRecord().getCheckin().getBrand().getBrandName();
                objs[4] = c.getMaintainRecord().getCheckin().getModel().getModelName();
                objs[5] = c.getMaintainRecord().getCheckin().getColor().getColorName();
                objs[6] = c.getMaintainRecord().getCheckin().getPlate().getPlateName();
                objs[7] = c.getMaintainRecord().getCheckin().getCarPlate();
                objs[8] = c.getMaintainRecord().getPickupTime();
                objs[9] = c.getMaintainRecord().getRecordDes();
                objs[10] = c.getPaymentMethod();
                objs[11] = c.getChargeBillMoney();
                objs[12] = c.getActualPayment();
                objs[13] = c.getChargeTime();
                objs[14] = java.sql.Timestamp.valueOf(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getChargeCreatedTime()));
                objs[15] = c.getChargeBillDes();
                objs[16] = "可用";
                dataList.add(objs);
            }
            ExcelExport ex = new ExcelExport(title, rowsName, dataList, response);
            ex.exportData();
        } catch (Exception e) {
            e.printStackTrace();
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
