package com.tqh.service;

import com.tqh.pojo.LeaseRecode;
import com.tqh.pojo.QueryVo;
import com.tqh.util.PageBean;

public interface LeaseService {
	//获得所有租赁信息
	public PageBean<LeaseRecode> getLeaseRecodeList(QueryVo vo);
	//删除租赁信息
	public void deleteLeaseRecode(Integer id);
	//删除多条
	public void deleteLeaseRecodes(String id);
	//根据用户id获得预约信息包括车辆信息
	public LeaseRecode getLeaseRecode(Integer uid);
	//根据租赁编号计算费用
	public int getCost(Integer id);
	//去取车
	public void addLeaseRecode(Integer id);
	//用户去归还
	public void updateLeaseState(Integer id);
}
