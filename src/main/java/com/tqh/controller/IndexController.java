package com.tqh.controller;



import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tqh.pojo.Car;
import com.tqh.pojo.LeaseRecode;
import com.tqh.pojo.QueryVo;
import com.tqh.pojo.ReserveRecode;
import com.tqh.pojo.User;
import com.tqh.service.CarService;
import com.tqh.service.LeaseService;
import com.tqh.service.ReserveService;
import com.tqh.service.UserService;
import com.tqh.util.PageBean;

@Controller
public class IndexController {
	@Autowired
	private CarService carService;
	@Autowired
	private UserService userService;
	@Autowired
	private ReserveService reserveService;
	@Autowired
	private LeaseService leaseService;
	//到首页
	@RequestMapping("/")
	public String toIndex2(Model model){
		List<Car> carList = carService.getSixCarList();
		model.addAttribute("carList", carList);
		return "index";
	}
	// 到汽车列表页面
	@RequestMapping("/carlists")
	public String toIndex(Model model, QueryVo vo) {
		//开始显示第一页
		if (vo.getPage() == 0) {
			vo.setPage(1);
		}
		//显示条数
		if (vo.getRows() == 0) {
			vo.setRows(8);
		}
		if(vo.getBrand()!=null){
			if (vo.getBrand().equals("0")) {
				vo.setBrand("宝马");
			} else if (vo.getBrand().equals("1")) {
				vo.setBrand("大众");
			} else if (vo.getBrand().equals("2")) {
				vo.setBrand("奥迪");
			}else if(vo.getBrand().equals("3")){
				vo.setBrand("丰田");
			}
		}
		PageBean<Car> pageBean = carService.getCarList(vo);
		model.addAttribute("pageBean", pageBean);
		return "carlist";
	}
	//后台主界面
		@RequestMapping("/main")
		public String toMain(){
			return "back/main";
		}
		//去登陆界面
			@RequestMapping(value="/login",method=RequestMethod.GET)
			public String toLogin(){
				return "login";
			}
		//登录
		@RequestMapping(value="/login",method=RequestMethod.POST)
		public String login(String username,String password,HttpSession session,Model model){
			if(null!=username&&null!=password){
				User user = userService.login(username, password);
				if(null!=user){
					if(user.getRole().equals("管理员")){
						session.setAttribute("admin", user);
						return "redirect:/main";
					}else{
						session.setAttribute("user", user);
						return "redirect:/";
					}
				}else{
					return "redirect:/login";
				}
			}else{
				return "redirect:/login";
			}
			
		}
		//去注册
		@RequestMapping(value="/register",method=RequestMethod.GET)
		public String toRegister(){
			return "register";
		}
		//注册
		@RequestMapping(value="/register",method=RequestMethod.POST)
		public String register(User user){
			user.setRole("用户");
			userService.addUser(user);
			return "redirect:/login";
		}
		//退出登录
		@RequestMapping("/exit")
		public String exit(HttpSession session){
			session.invalidate();
			return "redirect:/";
		}
	
	//车辆信息
	@RequestMapping("/carinfo")
	public String carInfo(String cid,Model model,HttpSession session){
		User user = (User)session.getAttribute("user");
		if(null!=user){
			Car car = carService.getCar(cid);
			model.addAttribute("car", car);
			return "carinfo";
		}else{
			return "redirect:/login";
		}
	}
	//修改用户信息
	@RequestMapping("updateinfo")
	public String toupdateUser(){
		return "updateinfo";
	}
	//修改用户信息
	@RequestMapping("user_update")
	public String updateUser(User user){
		userService.updateUser(user);
		return "redirect:/";
	}
	//用户信息
	@RequestMapping("/userinfo")
	public String userInfo(Model model,HttpSession session){
		User user = (User)session.getAttribute("user");
		model.addAttribute("user", user);
		return "userinfo";
	}
	//预约表单提交
	@RequestMapping("/reserve")
	public String reserveCar(ReserveRecode reserveRecode){
		reserveService.reserveCar(reserveRecode);
		return "redirect:/";
	}
	//获得用户预约信息
	@RequestMapping("/user_reserve")
	public String userReserve(Integer uid,Model model){
		ReserveRecode reserveRecode = reserveService.getReserveRecodeByUser(uid);
		model.addAttribute("recode",reserveRecode);
		return "user_reserve";
	}
	/**
	 * 搜索车辆信息
	 */
	@RequestMapping("/searchcar")
	public String seracheCar(QueryVo vo,Model model){
		//开始显示第一页
		if (vo.getPage() == 0) {
			vo.setPage(1);
		}
		//显示条数
		if (vo.getRows() == 0) {
			vo.setRows(8);
		}
		PageBean<Car> pageBean = carService.getCarList(vo);
		model.addAttribute("pageBean", pageBean);
		return "carlist";
	}
	/**
	 * 去取车
	 */
	@RequestMapping("/getcar")
	public String getCar(Integer id){
		leaseService.addLeaseRecode(id);
		return "redirect:/";
	}
	//获得用户预约信息
	@RequestMapping("/user_lease")
	public String userLease(Integer uid,Model model){
		LeaseRecode leaseRecode = leaseService.getLeaseRecode(uid);
		model.addAttribute("recode",leaseRecode);
		return "user_lease";
	}
	//用户去归还
	@RequestMapping("/user_return")
	public String userReturn(Integer id){
		leaseService.updateLeaseState(id);
		return "redirect:/";
	}
}