package com.tqh.dao;

import java.util.List;

import com.tqh.pojo.LeaseRecode;
import com.tqh.pojo.QueryVo;

public interface LeaseMapper {
	//获得分页租赁记录列表
	public List<LeaseRecode> selectLeaseRecodeByPage(QueryVo vo);
	//返回所有行
	public Integer selectCount();
	//删除租赁记录
	public void deleteLeaseRecode(Integer id);
	//根据uid，cid删除记录
	public void deleteLeaseRecodeByUidAndCid(LeaseRecode leaseRecode);
	//根据用户id查询正在租赁记录并关联车信息 
	public LeaseRecode selectLeaseRecodeByUid(Integer uid);
	//根据id查询出租赁信息
	public LeaseRecode selectLeaseRecodeById(Integer id);
	//修改租赁
	public void updateLeaseRecode(LeaseRecode leaseRecode);
	//增加租赁记录
	public void addLeaseRecode(LeaseRecode leaseRecode);
}
