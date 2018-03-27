package com.situ.rbac.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.rbac.common.DataGrideResult;
import com.situ.rbac.common.ServerResponse;
import com.situ.rbac.entity.Permission;
import com.situ.rbac.entity.Role;
import com.situ.rbac.entity.RolePermission;
import com.situ.rbac.mapper.RoleMapper;
import com.situ.rbac.mapper.RolePermissionMapper;
import com.situ.rbac.service.IRoleService;
@Service
public class RoleServiceImpl implements IRoleService{
	@Autowired
	private RoleMapper roleMapper;
	
	@Autowired
	private RolePermissionMapper rolePermissionMapper;
	
	@Override
	public DataGrideResult<Role> pageList(Integer page, Integer rows, Role role) {
		//1.设置分页
		PageHelper.startPage(page, rows);
		//2.执行查询(查询的是分页之后的数据)
		List<Role> list = roleMapper.pageList(role);
		//3.得到满足条件的所有数据的数量，而上面的list是满足这个条件的某一页的数据
		PageInfo pageInfo = new PageInfo<>(list);
		Integer total = (int) pageInfo.getTotal();
		return new DataGrideResult<>(total, list);
	}

	@Override
	public ServerResponse delete(String ids) {
		String[] idsArray = ids.split(",");//[1,2,3]
		/*for (String id : idsArray) {
			roleMapper.deleteByPrimaryKey(Integer.parseInt(id));
		}
		return ServerResponse.createSUCCESS("删除成功");*/
		
		// delete from role where id in (1,2,3);
		int count = roleMapper.deleteAll(idsArray);
		if (count == idsArray.length) {
			return ServerResponse.createSUCCESS("删除成功");
		}
		return ServerResponse.createERROR("删除失败");
	}

	@Override
	public ServerResponse add(Role role) {
		int count = roleMapper.insert(role);
		// 保存role和permission的Id到role_permission中间表,建立role和permission之间的关系
        for (Permission p : role.getPermissions()) {
        	RolePermission rolePermission = new RolePermission();
        	rolePermission.setRoleId(role.getId());
        	rolePermission.setPermissionId(p.getId());
        	rolePermissionMapper.insert(rolePermission);
        }
		if (count > 0) {
			return ServerResponse.createSUCCESS("添加成功");
		}
		return ServerResponse.createERROR("添加失败");
	}
	
	@Override
	public ServerResponse update(Role role) {
		// 删除原来的权限
		rolePermissionMapper.deleteByRoleId(role.getId());
        // 重新新增权限
        for (Permission p : role.getPermissions()) {
        	RolePermission rolePermission = new RolePermission();
        	rolePermission.setRoleId(role.getId());
        	rolePermission.setPermissionId(p.getId());
        	rolePermissionMapper.insert(rolePermission);
        }
		
		int count = roleMapper.updateByPrimaryKey(role);
		if (count > 0) {
			return ServerResponse.createSUCCESS("更新成功");
		}
		return ServerResponse.createERROR("更新失败");
	}

	@Override
	public List<Role> selectAll() {
		return roleMapper.pageList(new Role());
	}
}
