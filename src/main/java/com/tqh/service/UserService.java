package com.tqh.service;


import java.util.List;

import com.tqh.pojo.QueryVo;
import com.tqh.pojo.User;
import com.tqh.util.PageBean;

public interface UserService {
	//获得所有用户信息
	public PageBean<User> getUserList(QueryVo vo);
	//添加用户
	public void addUser(User user);
	//修改用户
	public void updateUser(User user);
	//删除用户
	public void deleteUser(Integer id);
	//删除过个用户
	public void deleteUsers(String ids);
	//根据电话查询用户
	public PageBean<User> getUserByPhone(String phone) ;
	//根据姓名查询用户
	public PageBean<User> getUserByName(String name);
	public User login(String username,String password);
}
