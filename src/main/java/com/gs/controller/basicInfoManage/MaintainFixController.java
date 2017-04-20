package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.service.MaintainFixService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 维修保养项目管理
 * Created by yaoyong on 2017/4/18.
 */

@Controller
@RequestMapping("/maintainfix")
public class MaintainFixController {

    private Logger logger = (Logger) LoggerFactory.getLogger(MaintainFixController.class);

}
