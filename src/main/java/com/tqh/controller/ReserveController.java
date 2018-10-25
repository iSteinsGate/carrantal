package com.tqh.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tqh.pojo.QueryVo;
import com.tqh.pojo.ReserveRecode;
import com.tqh.service.ReserveService;
import com.tqh.util.PageBean;

@Controller
public class ReserveController {
	@Autowired
	private ReserveService reserveService;
	//跳转到reservelist.jsp界面
	@RequestMapping("page_reservelist")
	public String toReserveList(){
		return "back/reservelist";
	}
	//reservelist.jsp界面的ajax请求reservelist数据
	@RequestMapping("reservelist")
	@ResponseBody
	public PageBean<ReserveRecode> getReserveList(QueryVo vo){
		PageBean<ReserveRecode> pageBean = reserveService.getReserveRecodeList(vo);
		/*System.out.println(pageBean);*/
		return pageBean;
	}
	//删除
	@RequestMapping("delete_reserve")
	public String deleteReserve(String ids){
		reserveService.deleteReserveRecodes(ids);
		return "redirect:page_reservelist";
	}
	//跳转到预约处理列表
	@RequestMapping("page_reserve")
	public String toReserve(){
		return "back/service_reserve";
	}
	//处理预约
	@RequestMapping("/service_reserve")
	public String serviceReserve(Integer id){
		reserveService.updateReserveRecode(id);
		return "redirect:page_reserve";
	}
}
