package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.service.UserService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
@RequestMapping("/user")
public class UserController {
    private Logger logger = (Logger) LoggerFactory.getLogger(UserController.class);

    @Resource
    private UserService us;
}
