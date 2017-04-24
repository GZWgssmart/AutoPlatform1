package com.gs.service.impl;

import com.gs.bean.Appointment;
import com.gs.bean.Checkin;
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

	public int insert(Appointment appointment) { return appointmentDAO.insert(appointment); }
	public int batchInsert(List<Appointment> list) { return appointmentDAO.batchInsert(list); }
	public int delete(Appointment appointment) { return appointmentDAO.delete(appointment); }
	public int deleteById(String id) {
        return appointmentDAO.deleteById(id);
    }
	public int batchDelete(List<Appointment> list) { return appointmentDAO.batchDelete(list); }
	public int update(Appointment appointment) { return appointmentDAO.update(appointment); }
	public int batchUpdate(List<Appointment> list) { return appointmentDAO.batchUpdate(list); }
	public List<Appointment> queryAll() { return appointmentDAO.queryAll(); }

	public List<Appointment> queryAll(String status) {
		return appointmentDAO.queryAll();
	}

	public List<Appointment> queryByStatus(String status) { return appointmentDAO.queryAll(status); }
	public Appointment query(Appointment appointment) { return appointmentDAO.query(appointment); }
	public Appointment queryById(String id) { return appointmentDAO.queryById(id); }
	public List<Appointment> queryByPager(Pager pager) { return appointmentDAO.queryByPager(pager); }
	public int count() { return appointmentDAO.count(); }
	public int inactive(String id) { return appointmentDAO.inactive(id); }
	public int active(String id) { return appointmentDAO.active(id); }

	public List<Appointment> queryByPagerDisable(Pager pager) {
		return appointmentDAO.queryByPagerDisable(pager);
	}

	public int countByDisable() {
		return appointmentDAO.countByDisable();
	}

	public List<Appointment> blurredQuery(Pager pager, String cloumn, String value) {
		return null;
	}

	public int countByBlurred() {
		return 0;
	}

	public List<Appointment> blurredQuery(Pager pager, Appointment appointment) {
		return null;
	}

	public int countByBlurred(Appointment appointment) {
		return 0;
	}
}