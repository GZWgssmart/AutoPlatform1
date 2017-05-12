package com.gs.controller.FinancialManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.ChargeBill;
import com.gs.bean.User;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.RoleUtil;
import com.gs.common.util.SessionUtil;
import com.gs.service.ChargeBillService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by GZWangBin on 2017/4/21.
 */
@Controller
@RequestMapping("/chargeBill")
public class ChargeBillController {

    private Logger logger = (Logger) LoggerFactory.getLogger(ChargeBillController.class);

    /**
     * 收入Service
     */
    @Resource
    public ChargeBillService chargeBillService;

    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<ChargeBill> queryByPager(HttpSession session, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {

        if (SessionUtil.isLogin(session)) {
            String roles = "平台管理员,汽修公司管理员,汽修公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("收费单据分页查询");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(chargeBillService.count((User) session.getAttribute("user")));
                List<ChargeBill> chargeBills = chargeBillService.queryByPager(pager);
                return new Pager4EasyUI<ChargeBill>(pager.getTotalRecords(), chargeBills);
            } else {
                logger.info("此用户无拥有此方法的角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }


    }

    @ResponseBody
    @RequestMapping(value = "queryByPagerDisable",method = RequestMethod.GET)
    public Pager4EasyUI<ChargeBill> queryByPagerDisable(HttpSession session, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {


        if (SessionUtil.isLogin(session)) {
            String roles = "平台管理员,汽修公司管理员,汽修公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("禁用收费单据分页查询");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(chargeBillService.countByDisable((User) session.getAttribute("user")));
                List<ChargeBill> ChargeBills = chargeBillService.queryByPagerDisable(pager);
                return new Pager4EasyUI<ChargeBill>(pager.getTotalRecords(), ChargeBills);
            } else {
                logger.info("此用户无拥有此方法的角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
    }


    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(String id, String status) {
        if (id != null && !id.equals("") && status != null && !status.equals("")) {
            if (status.equals("N")) {
                chargeBillService.active(id);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                chargeBillService.inactive(id);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
            return ControllerResult.getFailResult("操作失败");
        }
    }

    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(ChargeBill chargeBill) {
        logger.info("添加收费单据");
        chargeBillService.insert(chargeBill);
        return ControllerResult.getSuccessResult("添加成功");
    }


}
