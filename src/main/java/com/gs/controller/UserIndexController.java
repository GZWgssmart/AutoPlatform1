package com.gs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 不曾有黑夜 on 2017/5/9.
 * 用户个人中心页面
 */

@Controller
@RequestMapping("/")
public class UserIndexController {

    /*账号信息页面*/
    @RequestMapping(value = "accountinfo")
    public String accountinfo(){
        return "Frontpage/Personalcenter/AccountSettings/accountinformation";
    }

}
