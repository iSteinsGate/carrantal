package com.tqh.service;


import java.util.List;

import com.tqh.pojo.Car;
import com.tqh.pojo.QueryVo;
import com.tqh.pojo.User;
import com.tqh.util.PageBean;

public interface CarService {
	//获得所有车辆信息
	public PageBean<Car> getCarList(QueryVo vo);
	//添加车辆
	public void addCar(Car car);
	//修改车辆
	public void updateCar(Car car);
	//删除车辆
	public void deleteCar(Integer id);
	//删除多辆车
	public void deleteCars(String ids);
	//根据姓名(车型)查找车
	public PageBean<Car> getCarByModel(String model);
	//根据车牌号找车
	public PageBean<Car> getCarByNumber(String number);
	//根据id查找car
	public Car getCar(String cid);
	//随机获取6条数据首页车辆展示
	public List<Car> getSixCarList();
}
