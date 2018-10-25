package com.tqh.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tqh.dao.CarMapper;
import com.tqh.dao.LeaseMapper;
import com.tqh.dao.ReserveMapper;
import com.tqh.pojo.Car;
import com.tqh.pojo.LeaseRecode;
import com.tqh.pojo.QueryVo;
import com.tqh.pojo.ReserveRecode;
import com.tqh.service.LeaseService;
import com.tqh.util.PageBean;
@Service
public class LeaseServiceImpl implements LeaseService{

	@Autowired
	private LeaseMapper leaseMapper;
	@Autowired
	private  CarMapper carMapper;
	@Autowired
	private  ReserveMapper reserveMapper;
	
	public PageBean<LeaseRecode> getLeaseRecodeList(QueryVo vo) {
		int currentPage=vo.getPage();
		vo.setStart((currentPage-1)*vo.getRows());
		List<LeaseRecode> leaseList = leaseMapper.selectLeaseRecodeByPage(vo);
		Integer total = leaseMapper.selectCount();
		PageBean<LeaseRecode> pageBean = new PageBean<LeaseRecode>();
		pageBean.setRows(leaseList);
		pageBean.setTotal(total);
		return pageBean;
	}

	public void deleteLeaseRecode(Integer id) {
		leaseMapper.deleteLeaseRecode(id);
	}

	public void deleteLeaseRecodes(String ids) {
		String[] id = ids.split(",");
		for (int i = 0; i < id.length; i++) {
			Integer lid = Integer.parseInt(id[i]);
			leaseMapper.deleteLeaseRecode(lid);
		}
		
	}
	public LeaseRecode getLeaseRecode(Integer uid) {
		LeaseRecode leaseRecode  = leaseMapper.selectLeaseRecodeByUid(uid);
		if(null!=leaseRecode){
			String state = leaseRecode.getState();
			if(state.equals("0")){
				leaseRecode.setState("正在用车");
			}else if(state.equals("1")){
				leaseRecode.setState("请求还车");
			}else{
				leaseRecode.setState("已还车");
			}
		}
		return leaseRecode;
	}
	/**
	 * 根据租赁编号计算费用
	 * 根据id查询出开始时间以及租车的费用，再根据当前时间进行计算
	 */
	public int getCost(Integer id) {
		LeaseRecode leaseRecode = leaseMapper.selectLeaseRecodeById(id);
		Date start = leaseRecode.getStarttime();
		Integer cid = leaseRecode.getCid();
		Car car = carMapper.selectCarById(cid.toString());
		String price = car.getPrice();
		int carPrice = Integer.parseInt(price);
		Date now = new Date();
		//间隔=Date1.getTime()-Date2.getTime();得出来的是毫秒数. 
		//除1000是秒,再除60是分,再除60是小时...
		Double time = (now.getTime()-start.getTime())*1.0/(1000*60*60*24);
		//ceil():返回不小于它的最小整数
		Double cost = Math.ceil(carPrice*time);
		int intValue = cost.intValue();
		return intValue;
	}
	/**
	 * 去取车
	 *	获取预约记录的id
	 * 查询预约记录转为租赁记录
	 */
	public void addLeaseRecode(Integer id) {
		ReserveRecode reserveRecode = reserveMapper.selectReserveRecodeById(id);
		LeaseRecode leaseRecode = new LeaseRecode();
		leaseRecode.setCid(reserveRecode.getCid());
		leaseRecode.setUid(reserveRecode.getUid());
		leaseRecode.setStarttime(reserveRecode.getStarttime());
		leaseRecode.setEstimateday(reserveRecode.getEstimateday());
		leaseRecode.setState("0");
		leaseMapper.addLeaseRecode(leaseRecode);
	}
	/**
	 * 用户去归还，改变租赁状态
	 */
	public void updateLeaseState(Integer id) {
		LeaseRecode leaseRecode = leaseMapper.selectLeaseRecodeById(id);
		leaseRecode.setState("1");
		leaseMapper.updateLeaseRecode(leaseRecode);
	}
	
}
