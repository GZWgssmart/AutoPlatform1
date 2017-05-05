package com.gs.controller.custManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.TrackList;
import com.gs.bean.User;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.TrackListService;
import com.gs.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by XiaoQiao on 2017/4/27.
 */

@Controller
@RequestMapping("/tracklist")
public class TracklistController {

    private Logger logger = (Logger) LoggerFactory.getLogger(TracklistController.class);

    @Autowired
    private HttpServletRequest req;

    @Resource
    private TrackListService trackListService;

    @Resource
    private UserService userService;

    @ResponseBody
    @RequestMapping("queryByPager")
    public Pager4EasyUI<TrackList> queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        logger.info("分页查看跟踪回访记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        int count = trackListService.count();
        pager.setTotalRecords(count);
        List<TrackList> queryList = trackListService.queryByPager(pager);
        return new Pager4EasyUI<TrackList>(pager.getTotalRecords(), queryList);
    }

    @ResponseBody
    @RequestMapping("queryName")
    public Pager4EasyUI<TrackList> queryName(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize, TrackList trackList) {
        logger.info("模糊查询跟踪回访记录");
        String text = req.getParameter("text");
        String value = req.getParameter("value");
        if(text != null && text != "") {
            Pager pager = new Pager();
            pager.setPageNo(Integer.valueOf(pageNumber));
            pager.setPageSize(Integer.valueOf(pageSize));
            if(text.equals("回访人")) {
                trackList.setUserId(value);
            } else if (text.equals("本次服务评价")) {
                trackList.setServiceEvaluate(Integer.valueOf(value));
            } else if (text.equals("跟踪回访用户")) {
                trackList.setTrackUser(value);
            } else if (text.equals("回访问题")) {
                trackList.setTrackContent(value);
            }
            int count = trackListService.countName(trackList);
            pager.setTotalRecords(count);
            List<TrackList> queryList = trackListService.queryByPagerName(pager,trackList);
            return new Pager4EasyUI<TrackList>(pager.getTotalRecords(), queryList);
        }
        return null;
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

    @ResponseBody
    @RequestMapping(value = "insert", method = RequestMethod.POST)
    public ControllerResult insert(TrackList trackList) {
        logger.info("跟踪回访记录添加操作");
        trackListService.insert(trackList);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(TrackList trackList) {
        logger.info("跟踪回访记录修改操作");
        trackListService.update(trackList);
        return ControllerResult.getSuccessResult("修改成功");
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
