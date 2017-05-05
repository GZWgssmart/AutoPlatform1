package com.gs.controller.custManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.MaintainRemind;
import com.gs.bean.User;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.MaintainRemindService;
import com.gs.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by XiaoQiao on 2017/5/4.
 */

/**
 * 维修保养提醒
 */

@Controller
@RequestMapping("/maintainRemind")
public class MaintainRemindController {

    private Logger logger = (Logger) LoggerFactory.getLogger(MaintainRemindController.class);

    @Autowired
    private HttpServletRequest req;

    @Resource
    private MaintainRemindService maintainRemindService;

    @Resource
    private UserService userService;

    @ResponseBody
    @RequestMapping("queryByPager")
    public Pager4EasyUI<MaintainRemind> queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        logger.info("分页查看维修保养提醒记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        int count = maintainRemindService.count();
        pager.setTotalRecords(count);
        List<MaintainRemind> queryList = maintainRemindService.queryByPager(pager);
        return new Pager4EasyUI<MaintainRemind>(pager.getTotalRecords(), queryList);
    }

    @ResponseBody
    @RequestMapping("queryCombox")
    public List<ComboBox4EasyUI> queryCombox() {
        logger.info("查看用户");
        List<User> users = userService.queryAll();
        List<ComboBox4EasyUI> combo = new ArrayList<ComboBox4EasyUI>();
        for(User user : users) {
            ComboBox4EasyUI co = new ComboBox4EasyUI();
            co.setId(user.getUserId());
            co.setText(user.getUserName());
            String userId = req.getParameter("userId");
            if(user.getUserId().equals(userId)) {
                co.setSelected(true);
            }
            combo.add(co);
        }
        return combo;
    }

    /**
     * 时间格式化
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
