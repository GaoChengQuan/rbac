package com.situ.rbac.service;

import com.situ.rbac.common.DataGrideResult;
import com.situ.rbac.common.ServerResponse;
import com.situ.rbac.entity.Permission;

public interface IPermissionService {

	/**
	 * 返回datagride分页和搜索之后的数据
	 * @param page 第几页
	 * @param rows 每一个多少个
	 * @param permission 封装搜索条件
	 * @return
	 */
	DataGrideResult pageList(Integer page, Integer rows, Permission permission);

	ServerResponse delete(String ids);

	ServerResponse add(Permission permission);

	ServerResponse update(Permission permission);
}
