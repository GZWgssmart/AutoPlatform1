package com.gs.controller.userManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.User;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.UserService;
import org.activiti.engine.impl.Page;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

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

    /**
     * 添加人员基本信息 返回json
     */
    @ResponseBody
    @RequestMapping(value = "addUser", method = RequestMethod.POST)
    public ControllerResult addUser(User user) {
        if(user != null && !user.equals("")) {
            userService.insert(user);
            logger.info("添加成功, 添加的对象: " + user.toString());
            return ControllerResult.getSuccessResult("添加成功");
        }
        return ControllerResult.getFailResult("添加失败");
    }


    /**
     * 修改人员基本信息
     */
    @ResponseBody
    @RequestMapping(value = "updateUser", method =RequestMethod.POST)
    public ControllerResult updateUser(User user) {
        if(user != null && !user.equals("")) {
            userService.update(user);
            logger.info("修改成功：" + user.toString());
            return ControllerResult.getSuccessResult("修改成功");
        }
        return ControllerResult.getFailResult("修改失败");
    }

    /**
     * 分页查询人员基本信息
     */
    @RequestMapping(value="queryByPager", method = RequestMethod.POST)
    public Pager4EasyUI queryByPager(@Param("pageNo") int pageNo, @Param("pageSize") int pageSize) {
        Pager pager = new Pager();
        pager.setPageNo(pageNo);
        pager.setPageSize(pageSize);
        pager.setTotalRecords(userService.count());
        List<User> users = userService.queryByPager(pager);
        logger.info("分页查询成功");
        return new Pager4EasyUI<User>(pager.getTotalRecords(), users);
    }

    /**
     * 查询全部人员基本信息   (若是有什么问题就用这个方法测试)
     */
    @ResponseBody
    @RequestMapping(value = "queryAll", method = RequestMethod.POST)
    public List<User> queryAll() {
        List<User> users = userService.queryAll();
        if(users != null && users.size() > 0) {
            return users;
        }
        return  null;
    }


}
