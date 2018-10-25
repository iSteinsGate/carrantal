package com.tqh.dao;

import java.util.List;

import com.tqh.pojo.QueryVo;
import com.tqh.pojo.ReturnRecode;

public interface ReturnMapper {
	//获得分页用户列表
	public List<ReturnRecode> selectReturnRecodeByPage(QueryVo vo);
	//返回所有行
	public Integer selectCount();
	//删除归还记录
	public void deleteReturnRecode(Integer id);
	//根据用户id查询归还信息
	public ReturnRecode selectReturnRecodeByUid(Integer uid);
	//增加归还记录
	public void insertReturnRecode(ReturnRecode ruturnRecode);
}
