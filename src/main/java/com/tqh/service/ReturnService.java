package com.tqh.service;

import com.tqh.pojo.QueryVo;
import com.tqh.pojo.ReturnRecode;
import com.tqh.util.PageBean;

public interface ReturnService {
	//获得所有归还信息
	public PageBean<ReturnRecode> getReturnRecodeList(QueryVo vo);
	//删除归还记录
	public void deleteReturnRecode(Integer id);
	//删除多条
	public void deleteReturnRecodes(String ids);
	//获得归还记录信息
	public ReturnRecode getReturnRecode(Integer uid);
	//还车处理，增加还车记录，删除租赁记录
	public void addReturnRecode(ReturnRecode returnRecode);
}
