package com.gs.controller;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/backstage")
public class backstageController {

    private Logger logger = (Logger) LoggerFactory.getLogger(backstageController.class);

    /**
     * 后台主页
     */
    @RequestMapping(value = "home", method = RequestMethod.GET)
    public String backstageHome() {
        return "backstage/home";
    }

}
