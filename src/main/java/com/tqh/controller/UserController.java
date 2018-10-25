package com.tqh.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tqh.pojo.QueryVo;
import com.tqh.pojo.User;
import com.tqh.service.UserService;
import com.tqh.util.PageBean;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	//跳转到userlist.jsp界面
	@RequestMapping("page_userlist")
	public String toUserList(){
		return "back/userlist";
	}
	//userlist.jsp界面的ajax请求userlist数据
	@RequestMapping("userlist")
	@ResponseBody
	public PageBean<User> getUserList(QueryVo vo){
		PageBean<User> pageBean = userService.getUserList(vo);
		return pageBean;
	}
	@RequestMapping("adduser")
	public String addUser(User user){
		userService.addUser(user);
		return "redirect:page_userlist";
	}
	@RequestMapping("updateuser")
	public String updateUser(User user){
		userService.updateUser(user);
		return "redirect:page_userlist";
	}
	@RequestMapping("deleteusers")
	public String deleteUser(String ids){
		userService.deleteUsers(ids);
		return "redirect:page_userlist";
	}
	//查找
	@RequestMapping("queryuser")
	@ResponseBody
	public PageBean<User> queryUser(String flag,String content,Model model){
		PageBean<User> userBean;
		if(flag.equals("1")){
			//根据姓名查找
			userBean = userService.getUserByName(content);
		}else{
			userBean = userService.getUserByPhone(content);
		}
		//System.out.println(userBean);
		return userBean;
	}
}
