package com.tqh.dao;

import java.util.List;

import com.tqh.pojo.Car;
import com.tqh.pojo.QueryVo;

public interface CarMapper {
	//获得分页车辆列表
	public List<Car> selectCarByPage(QueryVo vo);
	//返回所有行
	public Integer selectCount(QueryVo vo);
	//添加车
	public void insertCar(Car car);
	//修改车信息
	public void updateCar(Car car);
	//删除车
	public void deleteCar(Integer id);
	//根据车牌查找
	public Car selectCarByNumber(String number);
	//根据车名(车型号)查找
	public List<Car> selectCarByModel(String model);
	//根据品牌查询
	public List<Car> selectCarByBrand(String brand);
	//根据uid查询车
	public Car selectCarById(String id);
	//随机获取6辆车的信息用于页面展示
	public List<Car> selectCarByRand(Integer rows);
}
