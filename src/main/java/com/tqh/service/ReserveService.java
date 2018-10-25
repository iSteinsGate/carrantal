package com.tqh.service;

import com.tqh.pojo.QueryVo;
import com.tqh.pojo.ReserveRecode;
import com.tqh.util.PageBean;

public interface ReserveService {
	//获得所有预约信息
	public PageBean<ReserveRecode> getReserveRecodeList(QueryVo vo);
	//删除预约信息
	public void deleteReserveRecode(Integer id);
	//删除多条
	public void deleteReserveRecodes(String ids);
	//用户预定车辆
	public void reserveCar(ReserveRecode reserveRecode);
	//获得预约信息包含预约车辆信息
	public ReserveRecode getReserveRecodeByUser(Integer uid);
	//处理预约请求
	public ReserveRecode updateReserveRecode(Integer id);
}
