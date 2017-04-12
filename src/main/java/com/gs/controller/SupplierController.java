package com.gs.controller;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by AngeJob on 2017/4/12.
 */

@Controller
@RequestMapping("/supplier")
public class SupplierController {
    private Logger logger = (Logger) LoggerFactory.getLogger(SystemManageController.class);


    @RequestMapping(value = "supplierInformation", method = RequestMethod.GET)
    public String supplierInformation() {
        logger.info("供货商管理");
        return "supplier/supplierInFormation";
    }
}
