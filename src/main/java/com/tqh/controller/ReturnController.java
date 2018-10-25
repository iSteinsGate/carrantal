package com.tqh.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tqh.pojo.QueryVo;
import com.tqh.pojo.ReturnRecode;
import com.tqh.service.ReturnService;
import com.tqh.util.PageBean;

@Controller
public class ReturnController {
	@Autowired
	private ReturnService returnService;
	//跳转到returnlist.jsp界面
	@RequestMapping("page_returnlist")
	public String toreturnlist(){
		return "back/returnlist";
	}
	//returnlist.jsp界面的ajax请求returnlist数据
	@RequestMapping("returnlist")
	@ResponseBody
	public PageBean<ReturnRecode> getUserList(QueryVo vo){
		PageBean<ReturnRecode> pageBean = returnService.getReturnRecodeList(vo);
		//System.out.println(pageBean);
		return pageBean;
	}
	//删除
	@RequestMapping("delete_return")
	public String deleteReturn(String ids){
		returnService.deleteReturnRecodes(ids);
		return "redirect:page_returnlist";
	}
	//跳转到租赁处理列表
	@RequestMapping("page_return")
	public String toReserve(){
		return "back/service_return";
	}
	//归还处理
	@RequestMapping("service_return")
	public String returnSercie(ReturnRecode returnRecode){
		returnService.addReturnRecode(returnRecode);
		return "redirect:page_leaselist";
	}
	
}
