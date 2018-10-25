package com.tqh.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tqh.pojo.Car;
import com.tqh.pojo.QueryVo;
import com.tqh.pojo.User;
import com.tqh.service.CarService;
import com.tqh.util.PageBean;

@Controller
public class CarController {
	@Autowired
	private CarService carService;
	
	//跳转到carlist.jsp界面
	@RequestMapping("page_carlist")
	public String toCarList(){
		return "back/carlist";
	}
	//carlist.jsp界面的ajax请求carlist数据
	@RequestMapping("carlist")
	@ResponseBody
	public PageBean<Car> getCarList(QueryVo vo){
		PageBean<Car> pageBean = carService.getCarList(vo);
		//System.out.println(pageBean);
		return pageBean;
	}
	//添加车  MultipartFile:上传图片接口，需要自己配置实现类
	@RequestMapping("addcar")
	public String addCar(HttpServletRequest request, Car car,MultipartFile pictureFile) throws IllegalStateException, IOException{
		//如果上传了图片
		if(pictureFile.getSize()>0){
			//uuid自己生成图片名
			String uname = UUID.randomUUID().toString().replaceAll("-", "");
			String orrName = pictureFile.getOriginalFilename();
			//获得扩展名
			String extName = orrName.substring(orrName.lastIndexOf("."));
			//图片完整名字
			String pname="images/"+uname+extName;
			
			//保存图片到images
			String realPath = request.getSession().getServletContext().getRealPath("/");
			pictureFile.transferTo(new File(realPath+pname));
			car.setPicture(pname);
		}
		carService.addCar(car);
		return "redirect:page_carlist";
	}
	//修改车  MultipartFile:上传图片接口，需要自己配置实现类
	@RequestMapping("updatecar")
	public String updateCar(HttpServletRequest request, Car car,MultipartFile pictureFile) throws IllegalStateException, IOException{
		//如果上传了图片
		if(pictureFile.getSize()>0){
			//uuid自己生成图片名
			String uname = UUID.randomUUID().toString().replaceAll("-", "");
			String orrName = pictureFile.getOriginalFilename();
			//获得扩展名
			String extName = orrName.substring(orrName.lastIndexOf("."));
			//图片完整名字
			String pname="images/"+uname+extName;
			//保存图片到images
			String realPath = request.getSession().getServletContext().getRealPath("/");
			pictureFile.transferTo(new File(realPath+pname));
			car.setPicture(pname);
		}
		
		carService.updateCar(car);
		return "redirect:page_carlist";
	}
	//删除汽车
	@RequestMapping("deletecar")
	public String deletCar(String ids){
		carService.deleteCars(ids);
		return "redirect:page_carlist";
	}
	//ajax请求查找车
	//查找
	@RequestMapping("querycar")
	@ResponseBody
	public PageBean<Car> queryCer(String flag,String content,Model model){
		PageBean<Car> carBean;
		if(flag.equals("1")){
			//根据姓名（汽车型号）查找
			carBean = carService.getCarByModel(content);
		}else{
			//根据车牌号查找
			carBean = carService.getCarByNumber(content);
		}
		//System.out.println(carBean);
		return carBean;
	}
}
