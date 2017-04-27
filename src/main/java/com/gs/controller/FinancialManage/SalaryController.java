package com.gs.controller.FinancialManage;

import com.gs.bean.Salary;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.ExcelReader;
import com.gs.service.SalaryService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
public class SalaryController{

    private Logger logger = (Logger) LoggerFactory.getLogger(SalaryController.class);

    /**
     * 收入Service
     */
    @Resource
    public SalaryService salaryService;




    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<Salary> queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("工资信息分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(salaryService.count());
        List<Salary> salaries = salaryService.queryByPager(pager);
        return new Pager4EasyUI<Salary>(pager.getTotalRecords(), salaries);
    }


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(Salary salary) {
        logger.info("添加工资信息");
        salaryService.insert(salary);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "checkUserId", method = RequestMethod.GET)
    public boolean checkUserId(String userId) {
        Salary salary1 = salaryService.queryById(userId);
        if(salary1 != null){
            return true;
        }
        return false;
    }


    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(Salary salary) {
        logger.info("修改工资信息");
        System.out.printf(salary.getUserId()+ "ddddddd" +  salary.getSalaryId() + "ccc" + salary.getPrizeSalary());
        salaryService.update(salary);
        return ControllerResult.getSuccessResult("修改成功");
    }

    @RequestMapping(value ="exportExcel")
    public ModelAndView exportExcel(HttpServletRequest request, HttpServletResponse response){
        try {
            Salary salary =new Salary();
            // 查询工资信息
            List<Salary> userlist = salaryService.queryAll();
            String title ="用户信息表";
            String[] rowsName=new String[]{"工资发放编号","用户编号","奖金","罚款","总工资","工资发放描述", "工资发放时间", "工资发放创建时间"};
            List<Object[]>  dataList = new ArrayList<Object[]>();
            Object[] objs = null;
            for (int i = 0; i < userlist.size(); i++) {
                Salary salary1 =userlist.get(i);
                objs = new Object[rowsName.length];
                objs[0] = salary1.getSalaryId();
                objs[1] = salary1.getUser().getUserName();
                objs[2] = salary1.getPrizeSalary();
                objs[3] =  salary1.getMinusSalay();
                objs[4] = salary1.getTotalSalary();
                objs[5] = salary1.getSalaryDes();
                objs[6] = salary1.getSalaryTime();
                objs[7] = salary1.getSalaryCreatedTime();
                dataList.add(objs);
            }
            ExcelReader ex =new ExcelReader(title, rowsName, dataList,response);
            ex.exportData();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }





}
