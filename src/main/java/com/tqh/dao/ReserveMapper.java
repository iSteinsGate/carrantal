package com.tqh.dao;

import java.util.List;

import com.tqh.pojo.QueryVo;
import com.tqh.pojo.ReserveRecode;

public interface ReserveMapper {
	//获得分页预约列表
	public List<ReserveRecode> selectReserveRecodeByPage(QueryVo vo);
	//返回所有行
	public Integer selectCount(QueryVo vo);
	//删除预约记录
	public void deleteReserveRecode(Integer id);
	//增加预约记录
	public void insertReserveRecode(ReserveRecode recode);
	//根据用户id查询我的预约，关联汽车信息
	public ReserveRecode selectReserveRecodeByUid(Integer uid);
	//根据id查询预约
	public ReserveRecode selectReserveRecodeById(Integer id);
	//修改预约记录
	public void updateReserveRecode(ReserveRecode reserveRecode);
}
