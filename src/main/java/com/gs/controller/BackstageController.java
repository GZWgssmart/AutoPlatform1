package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.ChargeBill;
import com.gs.bean.MaintainDetail;
import com.gs.bean.MaintainFixAcc;
import com.gs.bean.MaintainRecord;
import com.gs.service.*;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * 基础信息管理
 * 方法后面有index的都是跳转页面的方法
 */
@Controller
@RequestMapping("/backstage")
public class BackstageController {

    private Logger logger = (Logger) LoggerFactory.getLogger(BackstageController.class);

    @Resource
    private CompanyService companyService;
    @Resource
    private MaintainDetailService maintainDetailService;
    @Resource
    private MaintainRecordService maintainRecordService;
    @Resource
    private ChargeBillService chargeBillService;
    // 项目配件service
    @Resource
    private MaintainFixAccService maintainFixAccService;
    /**
     * 后台主页
     */
    @RequestMapping(value = "home", method = RequestMethod.GET)
    public String backstageHome() {
        logger.info("跳转到后台主页");
        return "backstage/home";
    }

    /**
     * 维修保养记录打印页面
     */
    @RequestMapping(value = "recordPrint/{maintainRecordId}/{ids}", method = RequestMethod.GET)
    public ModelAndView recordPrint(@PathVariable("maintainRecordId")String maintainRecordId,@PathVariable("ids")String ids) {
        logger.info("跳转到维修保养明细打印页面");
        ModelAndView mav = new ModelAndView("backstage/recordPrint");
        // 拿到选中的维修保养记录
        MaintainRecord maintainRecord = maintainRecordService.queryById(maintainRecordId);
        maintainRecord.setTodayTime(new Date());
        // 拿到此维修保养记录下所有明细
        List<MaintainDetail> maintainDetails = maintainDetailService.queryByRecordId(maintainRecordId);
        Double disCountMoney = 0.d;
        Double money = 0.d;
        for(MaintainDetail md : maintainDetails){
            if(md.getMaintainDiscount() >=1){
                    md.setDisCount("无折扣");
            }else{
                String str = md.getMaintainDiscount().toString();
                String str1 = str.substring(str.indexOf(".") + 1);
                md.setDisCount(str1+"折");
            }
            money += md.getMaintainFix().getMaintainMoney();
            disCountMoney +=md.getMaintainDiscount() * md.getMaintainFix().getMaintainMoney();
        }
        maintainRecord.setDiscountMoney(disCountMoney);
        maintainRecord.setTotal(money);
        List<MaintainFixAcc> maintainFixAccs = maintainFixAccService.queryByRecord(ids);// 拿到所有项目配件
        mav.addObject("maintainFixAccs", maintainFixAccs);// 项目配件
        mav.addObject("maintainRecord", maintainRecord);// 维修保养记录
        mav.addObject("maintainDetails", maintainDetails);// 维修保养明细
        return mav;
    }

    /**
     * 收费单据打印页面
     */
    @RequestMapping(value = "chargeBillprint/{chargeBillId}", method = RequestMethod.GET)
    public ModelAndView chargeBillprint(@PathVariable("chargeBillId")String chargeBillId) {
        logger.info("跳转到收费单据打印页面");
        ChargeBill chargeBill = chargeBillService.queryById(chargeBillId);
        ModelAndView mav = new ModelAndView("backstage/chargeBillPrint");
        mav.addObject("chargeBill", chargeBill);
        return mav;
    }
}
