package com.gs.service.impl;

import com.gs.bean.Appointment;
import com.gs.bean.User;
import com.gs.common.bean.Pager;
import com.gs.dao.AppointmentDAO;
import com.gs.service.AppointmentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:51:11
*@des 预约Service实现
*/
@Service
public class AppointmentServiceImpl implements AppointmentService {

	@Resource
	private AppointmentDAO appointmentDAO;
	@Override
	public int insert(Appointment appointment) {return appointmentDAO.insert(appointment);
	}

	public int delete(Appointment appointment) { return appointmentDAO.delete(appointment); }
	public int deleteById(String id) {
        return appointmentDAO.deleteById(id);
    }
	public int batchDelete(List<Appointment> list) { return appointmentDAO.batchDelete(list); }
	public int update(Appointment appointment) { return appointmentDAO.update(appointment); }
	public int batchUpdate(List<Appointment> list) { return appointmentDAO.batchUpdate(list); }

	@Override
	public List<Appointment> queryAll(User user) {return appointmentDAO.queryAll(user);
	}
	@Override
	public List<Appointment> queryAll(String status) {return appointmentDAO.queryAll(status);
	}
	public List<Appointment> queryByStatus(String status) { return appointmentDAO.queryAll(status); }
	public Appointment query(Appointment appointment) { return appointmentDAO.query(appointment); }
	public Appointment queryById(String id) { return appointmentDAO.queryById(id); }
	public List<Appointment> queryByPager(Pager pager) { return appointmentDAO.queryByPager(pager); }
	@Override
	public int count(User user) {return appointmentDAO.count(user);
	}
	public int inactive(String id) { return appointmentDAO.inactive(id); }
	public int active(String id) { return appointmentDAO.active(id); }
	public List<Appointment> queryByPagerDisable(Pager pager) {
		return appointmentDAO.queryByPagerDisable(pager);
	}
	@Override
	public int countByDisable(User user) {return appointmentDAO.countByDisable(user);
	}
	public List<Appointment> blurredQuery(Pager pager, Appointment appointment) {return appointmentDAO.blurredQuery(pager, appointment);
	}
	@Override
	public int countByBlurred(Appointment appointment, User user) {return appointmentDAO.countByBlurred(appointment,user);
	}

	@Override
	public int batchInsert(List<Appointment> list) {
		return 0;
	}
}