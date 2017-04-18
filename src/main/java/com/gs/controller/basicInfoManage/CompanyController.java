package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Company;
import com.gs.common.bean.ControllerResult;
import com.gs.service.CompanyService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

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
    @RequestMapping(value = "queryAll")
    public List<Company> queryAll() {
        logger.info("查询所有公司信息");
        List<Company> companyList = companyService.queryAll();
            return companyList;
    }

    @ResponseBody
    @RequestMapping(value = "insertCompany", method = RequestMethod.POST)
    public ControllerResult insertCompany(Company company){
            companyService.insert(company);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "updateCompany",method = RequestMethod.POST)
    public ControllerResult updateCompany(Company company){
        companyService.update(company);
        logger.info("修改成功");
        return ControllerResult.getSuccessResult("修改成功");
    }

    @ResponseBody
    @RequestMapping(value = "deleteByIdCompany",method = RequestMethod.POST)
    public ControllerResult deleteConmpany(Company company){
        companyService.delete(company);
        logger.info( "删除成功");
        return ControllerResult.getSuccessResult("删除成功");
    }
}
