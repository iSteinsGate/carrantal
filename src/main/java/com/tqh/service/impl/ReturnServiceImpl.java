package com.tqh.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tqh.dao.CarMapper;
import com.tqh.dao.LeaseMapper;
import com.tqh.dao.ReturnMapper;
import com.tqh.pojo.Car;
import com.tqh.pojo.LeaseRecode;
import com.tqh.pojo.QueryVo;
import com.tqh.pojo.ReturnRecode;
import com.tqh.service.ReturnService;
import com.tqh.util.PageBean;
@Service
public class ReturnServiceImpl implements ReturnService{

	@Autowired
	private ReturnMapper returnMapper;
	@Autowired 
	private CarMapper carMapper;
	@Autowired
	private LeaseMapper leaseMapper;
	
	public PageBean<ReturnRecode> getReturnRecodeList(QueryVo vo) {
		int currentPage=vo.getPage();
		vo.setStart((currentPage-1)*vo.getRows());
		List<ReturnRecode> returnList = returnMapper.selectReturnRecodeByPage(vo);
		Integer total = returnMapper.selectCount();
		PageBean<ReturnRecode> pageBean = new PageBean<ReturnRecode>();
		pageBean.setRows(returnList);
		pageBean.setTotal(total);
		return pageBean;
	}

	public void deleteReturnRecode(Integer id) {
		returnMapper.deleteReturnRecode(id);
	}

	public void deleteReturnRecodes(String ids) {
		String[] id = ids.split(",");
		for (int i = 0; i < id.length; i++) {
			Integer rid = Integer.parseInt(id[i]);
			returnMapper.deleteReturnRecode(rid);
		}
	}

	public ReturnRecode getReturnRecode(Integer uid) {
		ReturnRecode recode = returnMapper.selectReturnRecodeByUid(uid);
		Car car = carMapper.selectCarById(recode.getCid().toString());
		recode.setCar(car);
		return null;
	}
	/**
	 * 还车处理：增加还车记录，改变租赁记录状态为已归还
	 */
	public void addReturnRecode(ReturnRecode returnRecode) {
		//1.封装returnRecode
		Date date = new Date();
		returnRecode.setEndtime(date);
		//2.增加换车记录
		returnMapper.insertReturnRecode(returnRecode);
		//3。改变租赁记录状态
		LeaseRecode leaseRecode = new LeaseRecode();
		leaseRecode.setState("2");
		leaseRecode.setUid(returnRecode.getUid());
		leaseRecode.setCid(returnRecode.getCid());
		leaseMapper.updateLeaseRecode(leaseRecode);
	}
}
