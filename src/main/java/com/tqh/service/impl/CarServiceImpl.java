package com.tqh.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tqh.dao.CarMapper;
import com.tqh.pojo.Car;
import com.tqh.pojo.QueryVo;
import com.tqh.service.CarService;
import com.tqh.util.PageBean;

@Service
public class CarServiceImpl implements CarService {

	@Autowired
	private CarMapper carMapper;

	public PageBean<Car> getCarList(QueryVo vo) {
		int currentPage=vo.getPage();
		vo.setStart((currentPage-1)*vo.getRows());
		List<Car> carList = carMapper.selectCarByPage(vo);
		Integer total = carMapper.selectCount(vo);
		//总页数
		int pageCount;
		if(total%vo.getRows()==0){
			pageCount=total/vo.getRows();
		}else{
			pageCount=total/vo.getRows()+1;
		}
		//封装pageBean
		PageBean<Car> pageBean = new PageBean<Car>();
		pageBean.setRows(carList);
		pageBean.setTotal(total);
		pageBean.setCurrentPage(vo.getPage());
		pageBean.setPageSize(vo.getRows());
		pageBean.setPageCount(pageCount);
		return pageBean;
	}

	public void addCar(Car car) {
		carMapper.insertCar(car);
	}

	public void updateCar(Car car) {
		carMapper.updateCar(car);
	}

	public void deleteCar(Integer id) {
		carMapper.deleteCar(id);
	}

	public void deleteCars(String ids) {
		String[] id = ids.split(",");
		for (int i = 0; i < id.length; i++) {
			Integer cid = Integer.parseInt(id[i]);
			carMapper.deleteCar(cid);
		}
	}

	public PageBean<Car> getCarByModel(String model) {
		List<Car> carList = carMapper.selectCarByModel(model);
		PageBean<Car> pageBean = new PageBean<Car>();
		pageBean.setRows(carList);
		pageBean.setTotal(carList.size());
		return pageBean;
	}

	public PageBean<Car> getCarByNumber(String number) {
		Car car = carMapper.selectCarByNumber(number);
		List<Car> carList = new ArrayList<Car>();
		if(car!=null){
			carList.add(car);
		}
		PageBean<Car> pageBean = new PageBean<Car>();
		pageBean.setRows(carList);
		pageBean.setTotal(carList.size());
		System.out.println(carList.size());
		return pageBean;
	}

	public Car getCar(String cid) {
		return carMapper.selectCarById(cid);
	}

	public List<Car> getSixCarList() {
		return carMapper.selectCarByRand(6);
	}
}
