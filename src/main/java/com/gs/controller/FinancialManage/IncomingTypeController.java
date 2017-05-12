package com.gs.controller.FinancialManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Checkin;
import com.gs.bean.IncomingType;
import com.gs.bean.OutgoingType;
import com.gs.bean.User;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.RoleUtil;
import com.gs.common.util.SessionUtil;
import com.gs.common.util.UUIDUtil;
import com.gs.controller.FinancialViewController;
import com.gs.service.IncomingTypeService;
import com.gs.service.OutgoingTypeService;
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
 * Created by GZWangBin on 2017/4/18.
 */
@Controller
@RequestMapping("/incomingType")
public class IncomingTypeController {

    private Logger logger = (Logger) LoggerFactory.getLogger(IncomingTypeController.class);

    /**
     * 收入Service
     */
    @Resource
    public IncomingTypeService incomingTypeService;

    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<IncomingType> queryByPager(HttpSession session, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("收入类型分页查询");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(incomingTypeService.count((User) session.getAttribute("user")));
                List<IncomingType> incomingTypes = incomingTypeService.queryByPager(pager);
                return new Pager4EasyUI<IncomingType>(pager.getTotalRecords(), incomingTypes);
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
    public Pager4EasyUI<IncomingType> queryByPagerDisable(HttpSession session, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("禁用收入类型分页查询");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(incomingTypeService.countByDisable((User) session.getAttribute("user")));
                List<IncomingType> incomingTypes = incomingTypeService.queryByPagerDisable(pager);
                return new Pager4EasyUI<IncomingType>(pager.getTotalRecords(), incomingTypes);
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
                incomingTypeService.active(id);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                incomingTypeService.inactive(id);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
            return ControllerResult.getFailResult("操作失败");
        }
    }

    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(HttpSession session, IncomingType incomingType) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("添加收入类型");
                incomingType.setInTypeId(UUIDUtil.uuid());
                User user = (User)session.getAttribute("user");
                incomingType.setCompanyId(user.getCompanyId());
                incomingType.setInTypeStatus("Y");
                incomingTypeService.insert(incomingType);
                return ControllerResult.getSuccessResult("添加成功");
            } else {
                logger.info("此用户无拥有此方法的角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }

    }

    /**
     * 验证收入类型名称
     * @param inTypeName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "checkInTypeName", method = RequestMethod.GET)
    public boolean checkInTypeName(String inTypeName) {
        System.out.printf("lllll", inTypeName + "dgdsgfdgfdg");
        IncomingType incomingType = incomingTypeService.queryById(inTypeName);
        if(incomingType != null){
            return true;
        }
        return false;
    }


    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(HttpSession session, IncomingType incomingType) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("修改收入类型");
                User user = (User)session.getAttribute("user");
                incomingType.setCompanyId(user.getCompanyId());
                incomingTypeService.update(incomingType);
                return ControllerResult.getSuccessResult("修改成功");

            } else {
                logger.info("此用户无拥有此方法的角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
    }


}
