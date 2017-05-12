package com.gs.controller.FinancialManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.IncomingOutgoing;
import com.gs.bean.IncomingType;
import com.gs.bean.OutgoingType;
import com.gs.bean.User;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.PagerUtil;
import com.gs.common.util.RoleUtil;
import com.gs.common.util.SessionUtil;
import com.gs.common.util.UUIDUtil;
import com.gs.controller.FinancialViewController;
import com.gs.service.OutgoingTypeService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by GZWangBin on 2017/4/18.
 */
@Controller
@RequestMapping("/outGoingType")
public class OutGoingTypeController {

    private Logger logger = (Logger) LoggerFactory.getLogger(OutGoingTypeController.class);

    /**
     * 支出Service
     */
    @Resource
    public OutgoingTypeService outgoingTypeService;

    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<OutgoingType> queryByPager(HttpSession session, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "平台管理员,汽修公司管理员,汽修公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("支出类型分页查询");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(outgoingTypeService.count((User) session.getAttribute("user")));
                List<OutgoingType> outgoingTypes = outgoingTypeService.queryByPager(pager);
                return new Pager4EasyUI<OutgoingType>(pager.getTotalRecords(), outgoingTypes);
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
    public Pager4EasyUI<OutgoingType> queryByPagerDisable(HttpSession session,@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "平台管理员,汽修公司管理员,汽修公司财务人员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("禁用支出类型分页查询");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(outgoingTypeService.countByDisable((User) session.getAttribute("user")));
                List<OutgoingType> outgoingTypes = outgoingTypeService.queryByPagerDisable(pager);
                return new Pager4EasyUI<OutgoingType>(pager.getTotalRecords(), outgoingTypes);
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
                outgoingTypeService.active(id);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                outgoingTypeService.inactive(id);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
            return ControllerResult.getFailResult("操作失败");
        }
    }

    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(OutgoingType outgoingType) {
        logger.info("添加支出类型");
        outgoingType.setOutTypeId(UUIDUtil.uuid());
        outgoingType.setCompanyId("1");
        outgoingType.setOutTypeStatus("Y");
        outgoingTypeService.insert(outgoingType);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "checkOutTypeName", method = RequestMethod.GET)
    public boolean checkOutTypeName(String outTypeName) {
        OutgoingType outgoingType = outgoingTypeService.queryById(outTypeName);
        if(outgoingType != null){
            return true;
        }
        return false;
    }

    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(OutgoingType outgoingType) {
        System.out.printf(outgoingType.getOutTypeId() +"," + outgoingType.getOutTypeName());
        logger.info("修改支出类型");
        outgoingTypeService.update(outgoingType);
        return ControllerResult.getSuccessResult("修改成功");
    }


}
