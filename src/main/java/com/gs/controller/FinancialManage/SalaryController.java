package com.gs.controller.FinancialManage;

import com.gs.bean.OutgoingType;
import com.gs.bean.Salary;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.UUIDUtil;
import com.gs.service.SalaryService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Calendar;
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

    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(Salary salary) {
        logger.info("添加工资信息");
        salary.setSalaryId(UUIDUtil.uuid());
        salary.setSalaryTime(Calendar.getInstance().getTime());

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


}
