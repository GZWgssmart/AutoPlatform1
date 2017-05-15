package com.gs.controller.FinancialManage;

import com.gs.bean.OutgoingType;
import com.gs.bean.Salary;
import com.gs.bean.User;
import com.gs.common.Methods;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.ExcelExport;
import com.gs.common.util.ExcelReader;
import com.gs.common.util.RoleUtil;
import com.gs.common.util.SessionUtil;
import com.gs.service.SalaryService;
import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sun.plugin2.os.windows.SECURITY_ATTRIBUTES;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by GZWangBin on 2017/4/20.
 */
@Controller
@RequestMapping("/salary")
public class SalaryController {

    private Logger logger = (Logger) LoggerFactory.getLogger(SalaryController.class);

    /**
     * 收入Service
     */
    @Resource
    public SalaryService salaryService;


    @ResponseBody
    @RequestMapping(value = "queryByPager", method = RequestMethod.GET)
    public Pager4EasyUI<Salary> queryByPager(HttpSession session, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("工资信息分页查询");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(salaryService.count((User) session.getAttribute("user")));
                List<Salary> salaries = salaryService.queryByPager(pager);
                return new Pager4EasyUI<Salary>(pager.getTotalRecords(), salaries);
            } else {
                logger.info("此用户无拥有工资信息分页查询的角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }

    }


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @ResponseBody
    @RequestMapping(value = "add", method = RequestMethod.POST)
    public ControllerResult add(HttpSession session,Salary salary) {
        if (SessionUtil.isLogin(session)) {
            String roles = "公司超级管理员,公司普通管理员,汽车公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("添加工资信息");
                User user = (User) session.getAttribute("user");
                salary.setUser(user);
                salaryService.insert(salary);
                return ControllerResult.getSuccessResult("添加成功");
            } else {
                logger.info("此用户无拥有添加工资信息的角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }

    }

    @ResponseBody
    @RequestMapping(value = "checkUserId", method = RequestMethod.GET)
    public boolean checkUserId(String userId) {
        Salary salary1 = salaryService.queryById(userId);
        if (salary1 != null) {
            return true;
        }
        return false;
    }


    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(HttpSession session, Salary salary) {
        if (SessionUtil.isLogin(session)) {
            String roles = "公司超级管理员,公司普通管理员,汽车公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("修改工资信息");
                User user = (User) session.getAttribute("user");
                salary.setUser(user);
                salaryService.update(salary);
                return ControllerResult.getSuccessResult("修改成功");
            } else {
                logger.info("此用户无拥有修改工资信息的角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }

}

    @RequestMapping(value = "exportExcel")
    public ModelAndView exportExcel(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                try {
                    Salary salary = new Salary();
                    // 查询工资信息
                    List<Salary> userlist = salaryService.queryAll((User) session.getAttribute("user"));
                    String title = "员工工资信息";
                    String[] rowsName = new String[]{"工资发放编号", "用户编号", "用户名称", "奖金", "罚款", "总工资", "工资发放描述", "工资发放时间", "工资发放创建时间"};
                    List<Object[]> dataList = new ArrayList<Object[]>();
                    Object[] objs = null;
                    for (int i = 0; i < userlist.size(); i++) {
                        Salary salary1 = userlist.get(i);
                        objs = new Object[rowsName.length];
                        objs[0] = salary1.getSalaryId();
                        objs[1] = salary1.getUserId();
                        objs[2] = salary1.getUser().getUserName();
                        objs[3] = salary1.getPrizeSalary();
                        objs[4] = salary1.getMinusSalay();
                        objs[5] = salary1.getTotalSalary();
                        objs[6] = salary1.getSalaryDes();
                        objs[7] = salary1.getSalaryTime();
                        objs[8] = salary1.getSalaryCreatedTime();
                        dataList.add(objs);
                    }
                    ExcelExport ex = new ExcelExport(title, rowsName, dataList, response);
                    ex.exportData();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            } else {
                logger.info("此用户无拥有导出工资信息的角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }

    }




    @ResponseBody
    @RequestMapping(value = "addFile", method = RequestMethod.POST)
    public ControllerResult addFile(@RequestParam("txt_file") MultipartFile file, HttpServletRequest request) {
        try {
            String fileName = file.getOriginalFilename();
            String prefix = fileName.substring(fileName.lastIndexOf(".") + 1);
            String newFileName = System.currentTimeMillis() + "." + prefix;
            String filePath = Methods.getRootPath(request) + Methods.createNewFolder() + "\\" + newFileName;
            InputStream in = file.getInputStream(); // 获取文件输入流
            if (fileName != null && !fileName.equals("")) {
                FileUtils.copyInputStreamToFile(in, new File(filePath));
            }
            ExcelReader.readExcelFile(filePath);
        } catch (Exception e) {
            e.printStackTrace();
            return ControllerResult.getFailResult("上传失败");
        }
        return ControllerResult.getSuccessResult("上传成功");
    }



}
