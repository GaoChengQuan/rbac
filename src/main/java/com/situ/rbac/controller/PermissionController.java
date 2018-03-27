package com.situ.rbac.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.rbac.common.DataGrideResult;
import com.situ.rbac.common.ServerResponse;
import com.situ.rbac.entity.Permission;
import com.situ.rbac.service.IPermissionService;

@Controller
@RequestMapping("/permission")
public class PermissionController {
	@Autowired
	private IPermissionService permissionService;

	@RequestMapping("/index")
	public String index() {
		return "permission_index";
	}
	
	@RequestMapping("/pageList")
	@ResponseBody
	public DataGrideResult pageList(Integer page, Integer rows, Permission permission) {
		return permissionService.pageList(page, rows, permission);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ServerResponse delete(String ids) {
		return permissionService.delete(ids);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ServerResponse add(Permission permission) {
		return permissionService.add(permission);
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public ServerResponse update(Permission permission) {
		return permissionService.update(permission);
	}
	
	@RequestMapping("/selectByRoleId")
	@ResponseBody
	public DataGrideResult selectByRoleId(Integer roleId) {
		return permissionService.selectByRoleId(roleId);
	}
}
