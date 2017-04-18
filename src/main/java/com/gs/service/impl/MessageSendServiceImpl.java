package com.gs.service.impl;

import com.gs.bean.MessageSend;
import com.gs.dao.MessageSendDAO;
import com.gs.service.MessageSendService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由Wjhsmart技术支持
*
*@author Wjhsmart
*@since 2017-04-17 16:08:50
*@des 短信发送记录表Service实现
*/
@Service
public class MessageSendServiceImpl implements MessageSendService {

	@Resource
	private MessageSendDAO messageSendDAO;

	public int insert(MessageSend messageSend) { return messageSendDAO.insert(messageSend); }
	public int batchInsert(List<MessageSend> list) { return messageSendDAO.batchInsert(list); }
	public int delete(MessageSend messageSend) { return messageSendDAO.delete(messageSend); }
	public int deleteById(String id) {
        return messageSendDAO.deleteById(id);
    }
	public int batchDelete(List<MessageSend> list) { return messageSendDAO.batchDelete(list); }
	public int update(MessageSend messageSend) { return messageSendDAO.update(messageSend); }
	public int batchUpdate(List<MessageSend> list) { return messageSendDAO.batchUpdate(list); }
	public List<MessageSend> queryAll() { return messageSendDAO.queryAll(); }

	@Override
	public List<MessageSend> queryAll(String status) {
		return messageSendDAO.queryAll();
	}

	public List<MessageSend> queryByStatus(String status) { return messageSendDAO.queryAll(status); }
	public MessageSend query(MessageSend messageSend) { return messageSendDAO.query(messageSend); }
	public MessageSend queryById(String id) { return messageSendDAO.queryById(id); }
	public List<MessageSend> queryByPager(Pager pager) { return messageSendDAO.queryByPager(pager); }
	public int count() { return messageSendDAO.count(); }
	public int inactive(String id) { return messageSendDAO.inactive(id); }
	public int active(String id) { return messageSendDAO.active(id); }

}