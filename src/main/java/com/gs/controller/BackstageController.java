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


}
