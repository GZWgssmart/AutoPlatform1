package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Company;
import com.gs.bean.User;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.*;
import com.gs.service.CompanyService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * 公司信息管理
 * Created by yaoyong on 2017/4/18.
 */

@Controller
@RequestMapping("/company")
public class CompanyController {

    private Logger logger = (Logger) LoggerFactory.getLogger(CompanyController.class);

    @Resource
    private CompanyService companyService;

    @ResponseBody
    @RequestMapping(value = "queryAllCompany",method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAll(HttpSession session){
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("查询所有公司信息");
                List<Company> companys = companyService.queryAll((User) session.getAttribute("user"));
                List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
                for (Company c : companys) {
                    ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
                    comboBox4EasyUI.setId(c.getCompanyId());
                    comboBox4EasyUI.setText(c.getCompanyName());
                    comboxs.add(comboBox4EasyUI);
                }
                return comboxs;
            }else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
    }

    /**
     * 查询所有被禁用的登记记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<Company> queryByPagerDisable(HttpSession session,@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("分页查询所有被禁用公司信息");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setTotalRecords(companyService.countByDisable((User) session.getAttribute("user")));
                List<Company> companys = companyService.queryByPagerDisable(pager);
                return new Pager4EasyUI<Company>(pager.getTotalRecords(), companys);
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
    }


    @ResponseBody
    @RequestMapping(value="queryByPagerCompany", method = RequestMethod.GET)
    public Pager4EasyUI<Company> queryAll(HttpSession session,@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("分页查询所有公司信息");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(companyService.count((User) session.getAttribute("user")));
                List<Company> companys = companyService.queryByPager(pager);
                return new Pager4EasyUI<Company>(pager.getTotalRecords(), companys);
            }else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
        }

    @ResponseBody
    @RequestMapping(value = "addCompany",method = RequestMethod.POST)
    public ControllerResult add(HttpSession session,Company company){
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                if (company != null && !company.equals("")) {
                    logger.info("添加公司信息");
                    companyService.insert(company);
                    return ControllerResult.getSuccessResult("添加成功");
                } else {
                    return ControllerResult.getFailResult("添加失败，请输入必要的信息");
                }
            }else {
                    logger.info("此用户无拥有此方法角色");
                    return null;
                }
            } else {
                logger.info("请先登录");
                return ControllerResult.getNotLoginResult("添加信息无效，请重新登录");
            }
    }

    @ResponseBody
    @RequestMapping(value = "updateCompany",method = RequestMethod.POST)
    public ControllerResult update(HttpSession session,Company company){
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                if (company != null && !company.equals("")) {
                    logger.info("修改汽车品牌");
                    companyService.update(company);
                    return ControllerResult.getSuccessResult("修改成功");
                } else {
                    return ControllerResult.getFailResult("修改失败，请输入必要的信息");
                }
            }else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return ControllerResult.getNotLoginResult("修改信息无效，请重新登录");
        }
    }

    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(HttpSession session,String id, String status) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                if (id != null && !id.equals("") && status != null && !status.equals("")) {
                    if (status.equals("N")) {
                        companyService.active(id);
                        logger.info("激活成功");
                        return ControllerResult.getSuccessResult("激活成功");
                    } else {
                        companyService.inactive(id);
                        logger.info("禁用成功");
                        return ControllerResult.getSuccessResult("禁用成功");
                    }
                } else {
                    return ControllerResult.getFailResult("操作失败");
                }
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return ControllerResult.getNotLoginResult("修改状态无效，请重新登录");
        }
    }

    private boolean saveFile(MultipartFile file, HttpSession session, Company company) {
        // 判断文件是否为空
        if (!file.isEmpty()) {
            try {
                String ofilename = file.getOriginalFilename();
                System.out.print("文件后缀名为："+ofilename.substring(ofilename.lastIndexOf(".")+1));
                // 文件保存路径
                String filePath = FileUtil.uploadPath(session, "companyLog") + "/company_"
                        + DateFormatUtil.format(new Date(),"yyyyMMddHHmmssS") + new Random().nextInt(100)
                        + "." + ofilename.substring(ofilename.lastIndexOf(".")+1);
                // 转存文件
                file.transferTo(new File(filePath));
                company.setCompanyLogo("/static/companyLog"+filePath.substring(filePath.lastIndexOf("/")));
                companyService.insert(company);
                return true;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    @ResponseBody
    @RequestMapping("/editFile")
    public String filesUpload(@RequestParam("files") MultipartFile[] files, HttpSession session, Company company) {
        //判断file数组不能为空并且长度大于0
        if(files!=null&&files.length>0){
            //循环获取file数组中得文件
            for(int i = 0;i<files.length;i++){
                MultipartFile file = files[i];
                //保存文件
                saveFile(file,session,company);
            }
        }
        return "1";
    }

    /**
     * 时间格式化
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
