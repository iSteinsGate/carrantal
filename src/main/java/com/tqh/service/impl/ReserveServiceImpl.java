package com.tqh.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tqh.dao.CarMapper;
import com.tqh.dao.ReserveMapper;
import com.tqh.dao.UserMapper;
import com.tqh.pojo.Car;
import com.tqh.pojo.QueryVo;
import com.tqh.pojo.ReserveRecode;
import com.tqh.pojo.User;
import com.tqh.service.ReserveService;
import com.tqh.util.PageBean;
/**
 * @author Administrator
 *
 */
/**
 * @author Administrator
 *
 */
@Service
public class ReserveServiceImpl implements ReserveService{

	@Autowired
	private ReserveMapper reserveMapper;
	@Autowired
	private CarMapper carMapper;
	@Autowired
	private UserMapper userMapper;
	
	public PageBean<ReserveRecode> getReserveRecodeList(QueryVo vo) {
		if(vo.getPage()==0){
			vo.setPage(1);
		}
		if(vo.getRows()==0){
			vo.setRows(10);
		}
		int currentPage=vo.getPage();
		vo.setStart((currentPage-1)*vo.getRows());
		List<ReserveRecode> reserveList = reserveMapper.selectReserveRecodeByPage(vo);
		Integer total = reserveMapper.selectCount(vo);
		PageBean<ReserveRecode> pageBean = new PageBean<ReserveRecode>();
		pageBean.setRows(reserveList);
		pageBean.setTotal(total);
		return pageBean;
	}

	public void deleteReserveRecode(Integer id) {
		reserveMapper.deleteReserveRecode(id);
	}

	public void deleteReserveRecodes(String ids) {
		String[] id = ids.split(",");
		for (int i = 0; i < id.length; i++) {
			Integer rid = Integer.parseInt(id[i]);
			reserveMapper.deleteReserveRecode(rid);
		}
	}
	public void reserveCar(ReserveRecode reserveRecode) {
		reserveRecode.setState("0");
		reserveMapper.insertReserveRecode(reserveRecode);
	}
	//获得用户的预约记录
	public ReserveRecode getReserveRecodeByUser(Integer uid) {
		ReserveRecode recode =  reserveMapper.selectReserveRecodeByUid(uid);
		if(recode!=null){
			String state = recode.getState();
			if(state.equals("0")){
				recode.setState("正在预约");
			}else if(state.equals("1")){
				recode.setState("预约成功");
			}else{
				recode.setState("预约失败");
			}
		}
		 return recode;
	}
	/**
	 * 处理预约请求
	 * state：表示预约状态0：正在预约，1：预约成功，2：预约失败
	 * 用户存在，汽车未出租，预约时间超过当前时间，预约成功
	 */
	public ReserveRecode updateReserveRecode(Integer id) {
		ReserveRecode reserveRecode = reserveMapper.selectReserveRecodeById(id);
		User user = userMapper.selectUserById(reserveRecode.getUid());
		Car car = carMapper.selectCarById(reserveRecode.getCid().toString());
		String state="1";
		if(null==user){
			state="2";//不存在用户，预约失败
		}else if(car.getState().equals("1")){
			state="2";//汽车已出租，预约失败
		}else if(reserveRecode.getStarttime().getTime()<new Date().getTime()){
			state="2";
		}
		reserveRecode.setState(state);
		//修改数据库
		reserveMapper.updateReserveRecode(reserveRecode);
		return reserveRecode;
	}
}
