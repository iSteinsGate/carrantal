package com.tqh.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tqh.pojo.LeaseRecode;
import com.tqh.pojo.QueryVo;
import com.tqh.service.LeaseService;
import com.tqh.util.PageBean;

@Controller
public class LeaseController {
	@Autowired
	private LeaseService leaseService;
	
	//跳转到leaselist.jsp界面
	@RequestMapping("page_leaselist")
	public String toLeaseList(){
		return "back/leaselist";
	}
	//leaselist.jsp界面的ajax请求leaselist数据
	@RequestMapping("leaselist")
	@ResponseBody
	public PageBean<LeaseRecode> getLeaseList(QueryVo vo){
		PageBean<LeaseRecode> pageBean =leaseService.getLeaseRecodeList(vo);
		//System.out.println(pageBean);
		return pageBean;
	}
	//删除
	@RequestMapping("delete_lease")
	public String deleteLease(String ids){
		leaseService.deleteLeaseRecodes(ids);
		return "redirect:page_leaselist";
	}
	//计算费用
	@RequestMapping("service_lease")
	@ResponseBody
	public int calculate(Integer id){
		int cost = leaseService.getCost(id);
		return cost;
	}
}
