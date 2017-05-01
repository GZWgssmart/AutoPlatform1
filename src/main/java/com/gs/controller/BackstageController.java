package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.MaintainDetail;
import com.gs.bean.MaintainRecord;
import com.gs.service.CompanyService;
import com.gs.service.MaintainDetailService;
import com.gs.service.MaintainRecordService;
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

    /**
     * 后台主页
     */
    @RequestMapping(value = "home", method = RequestMethod.GET)
    public String backstageHome() {
        logger.info("跳转到后台主页");
        return "backstage/home";
    }

    /**
     * 打印页面
     */
    @RequestMapping(value = "print/{maintainRecordId}", method = RequestMethod.GET)
    public ModelAndView print(@PathVariable("maintainRecordId")String maintainRecordId) {
        logger.info("跳转到打印页面");
        ModelAndView mav = new ModelAndView("backstage/print");
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
        mav.addObject("maintainRecord", maintainRecord);
        mav.addObject("maintainDetails", maintainDetails);
        return mav;
    }
}
