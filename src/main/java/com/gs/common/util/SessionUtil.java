package com.gs.common.util;

import javax.servlet.http.HttpSession;

/**
 * 是否登录验证
 */
public class SessionUtil {

    /**
     * 是否登录
     */
    public static boolean isLogin(HttpSession session) {
        if(session.getAttribute("user")!=null){
            return true;
        }
        return false;
    }

}
