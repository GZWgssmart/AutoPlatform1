package com.gs.controller;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 基础信息管理
 * 方法后面有index的都是跳转页面的方法
 */
@Controller
@RequestMapping("/backstage")
public class BackstageController {

    private Logger logger = (Logger) LoggerFactory.getLogger(BackstageController.class);

    /**
     * 后台主页
     */
    @RequestMapping(value = "home", method = RequestMethod.GET)
    public String backstageHome() {
        logger.info("跳转到home页面");
        return "backstage/home";
    }

    /**
     * 公司信息管理
     *
     * @return
     */
    @RequestMapping(value = "companyInfo", method = RequestMethod.GET)
    public String companyInfoIndex() {
        logger.info("跳转到公司信息管理页面");
        return "backstage/companyInfo";
    }

    /**
     * 汽车品牌管理
     *
     * @return
     */
    @RequestMapping(value = "carBrand", method = RequestMethod.GET)
    public String carBrandIndex() {
        logger.info("跳转到汽车品牌管理页面");
        return "backstage/carBrand";
    }

    /**
     * 车型管理
     *
     * @return
     */
    @RequestMapping(value = "carModel", method = RequestMethod.GET)
    public String carModelIndex() {
        logger.info("跳转到车型管理页面");
        return "backstage/carModel";
    }

    /**
     * 汽车颜色管理
     *
     * @return
     */
    @RequestMapping(value = "carColor", method = RequestMethod.GET)
    public String carColorIndex() {
        logger.info("跳转到汽车颜色管理页面");
        return "backstage/carColor";
    }

    /**
     * 汽车车牌管理
     *
     * @return
     */
    @RequestMapping(value = "carPlate", method = RequestMethod.GET)
    public String carPlateIndex() {
        logger.info("跳转到汽车车牌管理页面");
        return "backstage/carPlate";
    }

    /**
     * 保养项目管理
     */
    @RequestMapping(value = "upkeepItem", method = RequestMethod.GET)
    public String upkeepItemIndex() {
        logger.info("跳转到保养项目管理页面");
        return "backstage/maintainItem";
    }

    /**
     * 维修项目管理
     */
    @RequestMapping(value = "fixItem", method = RequestMethod.GET)
    public String maintainItemIndex() {
        logger.info("跳转到维修项目管理页面");
        return "backstage/fixItem";
    }

    /**
     * 常见故障管理
     */
    @RequestMapping(value = "commonFaults", method = RequestMethod.GET)
    public String commonFaultsIndex() {
        logger.info("跳转到常见故障管理页面");
        return "backstage/commonFaults";
    }


}
