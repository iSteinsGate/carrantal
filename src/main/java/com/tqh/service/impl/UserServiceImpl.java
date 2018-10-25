package com.tqh.service.impl;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tqh.dao.UserMapper;
import com.tqh.pojo.QueryVo;
import com.tqh.pojo.User;
import com.tqh.service.UserService;
import com.tqh.util.PageBean;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserMapper userMapper;
	
	public PageBean<User> getUserList(QueryVo vo) {
		int currentPage=vo.getPage();
		vo.setStart((currentPage-1)*vo.getRows());
		List<User> userList = userMapper.selectUserByPage(vo);
		Integer total = userMapper.selectCount();
		PageBean<User> pageBean = new PageBean<User>();
		pageBean.setRows(userList);
		pageBean.setTotal(total);
		return pageBean;
	}
	
	public void addUser(User user) {
		userMapper.insertUser(user);
	}

	public void updateUser(User user) {
		userMapper.updateUser(user);
	}

	public void deleteUser(Integer id) {
		userMapper.deleteUser(id);
	}

	public void deleteUsers(String ids) {//1,2,4
		String[] id = ids.split(",");
		for(int i=0;i<id.length;i++){
			Integer uid = Integer.parseInt(id[i]);
			userMapper.deleteUser(uid);
		}
	}

	public PageBean<User> getUserByPhone(String phone) {
		User user = userMapper.selectUserByPhone(phone);
		List<User> userList = new ArrayList<User>();
		if(user!=null){
			userList.add(user);
		}
		PageBean<User> pageBean = new PageBean<User>();
		pageBean.setRows(userList);
		pageBean.setTotal(userList.size());
		return pageBean;
	}

	public PageBean<User> getUserByName(String name) {
		List<User> userList = userMapper.selectUserByName(name);
		PageBean<User> pageBean = new PageBean<User>();
		pageBean.setRows(userList);
		pageBean.setTotal(userList.size());
		
		
		return pageBean;
	}

	public User login(String username, String password) {
		User loginUser = new User();
		loginUser.setUsername(username);
		loginUser.setPassword(password);
		User user = userMapper.selectUserByNameAndPassword(loginUser);
		return user;
	}
}