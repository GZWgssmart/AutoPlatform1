package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Company;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.CompanyService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
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
        return "basicInfoManage/companyInfo";
    }
    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<Company> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        Pager pager = new Pager();
        logger.info("分页查询所有公司信息");
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(companyService.count());
        List<Company> companyListList = companyService.queryByPager(pager);
        return null;
    }

    /**
     * 汽车品牌管理
     *
     * @return
     */
    @RequestMapping(value = "carBrand")
    public String carBrandIndex() {
        logger.info("跳转到汽车品牌管理页面");
        return "basicInfoManage/carBrand";
    }

    /**
     * 车型管理
     *
     * @return
     */
    @RequestMapping(value = "carModel")
    public String carModelIndex() {
        logger.info("跳转到车型管理页面");
        return "basicInfoManage/carModel";
    }

    /**
     * 汽车颜色管理
     *
     * @return
     */
    @RequestMapping(value = "carColor")
    public String carColorIndex() {
        logger.info("跳转到汽车颜色管理页面");
        return "basicInfoManage/carColor";
    }

    /**
     * 汽车车牌管理
     *
     * @return
     */
    @RequestMapping(value = "carPlate")
    public String carPlateIndex() {
        logger.info("跳转到汽车车牌管理页面");
        return "basicInfoManage/carPlate";
    }

    /**
     * 保养项目管理
     */
    @RequestMapping(value = "upkeepItem")
    public String upkeepItemIndex() {
        logger.info("跳转到保养项目管理页面");
        return "basicInfoManage/maintainItem";
    }

    /**
     * 维修项目管理
     */
    @RequestMapping(value = "fixItem")
    public String maintainItemIndex() {
        logger.info("跳转到维修项目管理页面");
        return "basicInfoManage/fixItem";
    }

    /**
     * 常见故障管理
     */
    @RequestMapping(value = "commonFaults")
    public String commonFaultsIndex() {
        logger.info("跳转到常见故障管理页面");
        return "basicInfoManage/commonFaults";
    }


}
