package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Company;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.UUIDUtil;
import com.gs.service.CompanyService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
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
    @RequestMapping(value = "queryAllCompany",method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAll(){
        logger.info("查询所有公司信息");
        List<Company> companys = companyService.queryAll();
        List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
        for(Company c : companys){
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(c.getCompanyId());
            comboBox4EasyUI.setText(c.getCompanyName());
            comboxs.add(comboBox4EasyUI);
        }
        return comboxs;
    }

    @ResponseBody
    @RequestMapping(value="queryByPagerCompany", method = RequestMethod.GET)
    public Pager4EasyUI<Company> queryAll(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有公司信息");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(companyService.count());
        List<Company> companys = companyService.queryByPager(pager);
        return new Pager4EasyUI<Company>(pager.getTotalRecords(), companys);
    }

    @ResponseBody
    @RequestMapping(value = "addCompany",method = RequestMethod.POST)
    public ControllerResult add(Company company){
        if (company != null && !company.equals("")) {
            logger.info("添加公司信息");
            companyService.insert(company);
            return ControllerResult.getSuccessResult("添加成功");
        }else {
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }

    @ResponseBody
    @RequestMapping(value = "updateCompany",method = RequestMethod.POST)
    public ControllerResult update(Company company){
        if (company != null && !company.equals("")) {
            logger.info("修改汽车品牌");
            companyService.update(company);
            return ControllerResult.getSuccessResult("修改成功");
        }else {
            return ControllerResult.getFailResult("修改失败，请输入必要的信息");
        }
    }
}
