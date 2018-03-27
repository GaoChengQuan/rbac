package com.situ.rbac.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.rbac.common.DataGrideResult;
import com.situ.rbac.common.ServerResponse;
import com.situ.rbac.entity.Role;
import com.situ.rbac.service.IRoleService;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private IRoleService roleService;

	@RequestMapping("/index")
	public String index() {
		return "role_index";
	}
	
	@RequestMapping("/pageList")
	@ResponseBody
	public DataGrideResult pageList(Integer page, Integer rows, Role role) {
		return roleService.pageList(page, rows, role);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ServerResponse delete(String ids) {
		return roleService.delete(ids);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ServerResponse add(Role role) {
		return roleService.add(role);
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public ServerResponse update(Role role) {
		return roleService.update(role);
	}
}
