package com.gs.common;

import javax.servlet.http.HttpServletRequest;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by ArrayBin on 2017/3/20.
 */
public class Methods {

    public static final String DEFAULT_CODING = "utf-8";

    public static final String PATH_UPLOAD = "/WEB-INF/upload";

    /**
     * 根据当前日期自动创建存放文件的文件夹
     * @return
     */
    public static String createNewFolder() {
        return new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    }


    /**
     * 给文件取新名字
     * @return
     */
    public static String createName(String fileName) {
        return String.valueOf(System.currentTimeMillis());
    }

    public static String getRootPath(HttpServletRequest request) {
        return request.getServletContext().getRealPath("/");
    }

    public static double division(double a ,double b){
        double num =a/b;

        DecimalFormat df = new DecimalFormat("#.0");

        return Double.valueOf(df.format(num));

    }

    public static int division(double a) {
        DecimalFormat df = new DecimalFormat("#");
        return Integer.valueOf(df.format(a));
    }

}
