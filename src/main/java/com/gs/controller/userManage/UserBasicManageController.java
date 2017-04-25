package com.gs.controller.userManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.User;
import com.gs.bean.UserRole;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.UUIDUtil;
import com.gs.service.UserRoleService;
import com.gs.service.UserService;
import org.activiti.engine.impl.Page;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.plugin.util.UIUtil;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by 小蜜蜂 on 2017-04-19.
 * 控制 员工基本信息管理的 增、改、查 操作
 */
@Controller
@RequestMapping("/userBasicManage")
public class UserBasicManageController {

    private Logger logger = (Logger) LoggerFactory.getLogger(UserBasicManageController.class);

    @Resource
    private UserService userService;

    @Resource
    protected UserRoleService userRoleService;

    /**
     * 添加人员基本信息 返回json
     */
    @ResponseBody
    @RequestMapping(value = "addUser", method = RequestMethod.POST)
    public ControllerResult addUser(User user) {
        logger.info("添加人员");
        user.setUserId(UUIDUtil.uuid());
        UserRole userRole = new UserRole();
        userRole.setUserId(user.getUserId());
        userRole.setRoleId(user.getRoleId());
        userService.insert(user);
        userRoleService.insert(userRole);
        return ControllerResult.getSuccessResult("添加成功");
    }

    /**
     * 修改人员基本信息
     */
    @ResponseBody
    @RequestMapping(value = "updateUser", method =RequestMethod.POST)
    public ControllerResult updateUser(User user) {
        UserRole userRole = new UserRole();
        userRole.setRoleId(user.getRoleId());

        userService.update(user);
        userRoleService.update(userRole);
        logger.info("修改成功");
        return ControllerResult.getSuccessResult("修改成功");
    }

    /**
     * setDisabled  禁用
     */
    @ResponseBody
    @RequestMapping(value = "setDisabled", method = RequestMethod.POST)
    public ControllerResult setDisabled(String id) {
        userService.inactive(id);
        logger.info("修改状态成功，已禁用");
        return ControllerResult.getSuccessResult("修改状态成功，已禁用");
    }

    /**
     * setActivate 激活
     */
    public ControllerResult setActivate(String id) {
        logger.info("修改状态成功，已激活");
        return ControllerResult.getSuccessResult("修改状态成功，已激活");
    }

    /**
     * 分页查询人员基本信息
     */
    @ResponseBody
    @RequestMapping(value="queryByPager", method = RequestMethod.GET)
    public Pager4EasyUI queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(userService.count());
        logger.info("分页查询人员基本信息成功");
        List<User> users = userService.queryByPager(pager);
        return new Pager4EasyUI<User>(pager.getTotalRecords(), users);
    }

    /**
     * 查询全部人员基本信息  下拉列表
     */
    @ResponseBody
    @RequestMapping(value = "queryAll", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAll() {
        List<User> users = userService.queryAll();
        List<ComboBox4EasyUI> combo = new ArrayList<ComboBox4EasyUI>();
        for(User u: users) {
            ComboBox4EasyUI c = new ComboBox4EasyUI();
            c.setId(u.getUserId());
            c.setText(u.getUserName());
            combo.add(c);
        }
        return combo;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

}
