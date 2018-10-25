package com.tqh.dao;

import java.util.List;

import com.tqh.pojo.QueryVo;
import com.tqh.pojo.User;

public interface UserMapper {
	//获得分页用户列表
	public List<User> selectUserByPage(QueryVo vo);
	//返回所有行
	public Integer selectCount();
	//添加用户
	public void insertUser(User user);
	//修改用户
	public void updateUser(User user);
	//删除用户
	public void deleteUser(Integer id);
	//删除多个用户
	public void deleteUsers(Integer[] ids);
	//根据姓名查找用户
	public List<User> selectUserByName(String name);
	//根据电话号码查找用户
	public User selectUserByPhone(String phone);
	//根据用户密码查找用户
	public User selectUserByNameAndPassword(User user);
	//根据用户id查找用户
	public User selectUserById(Integer id);
}
