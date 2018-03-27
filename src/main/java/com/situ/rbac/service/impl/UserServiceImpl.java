package com.situ.rbac.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.rbac.common.DataGrideResult;
import com.situ.rbac.common.ServerResponse;
import com.situ.rbac.entity.Role;
import com.situ.rbac.entity.User;
import com.situ.rbac.entity.UserRole;
import com.situ.rbac.mapper.UserMapper;
import com.situ.rbac.mapper.UserRoleMapper;
import com.situ.rbac.service.IUserService;
@Service
public class UserServiceImpl implements IUserService{
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private UserRoleMapper userRoleMapper;
	
	@Override
	public DataGrideResult<User> pageList(Integer page, Integer rows, User user) {
		//1.设置分页
		PageHelper.startPage(page, rows);
		//2.执行查询(查询的是分页之后的数据)
		List<User> list = userMapper.pageList(user);
		//3.得到满足条件的所有数据的数量，而上面的list是满足这个条件的某一页的数据
		PageInfo pageInfo = new PageInfo<>(list);
		Integer total = (int) pageInfo.getTotal();
		return new DataGrideResult<>(total, list);
	}

	@Override
	public ServerResponse delete(String ids) {
		String[] idsArray = ids.split(",");//[1,2,3]
		/*for (String id : idsArray) {
			userMapper.deleteByPrimaryKey(Integer.parseInt(id));
		}
		return ServerResponse.createSUCCESS("删除成功");*/
		
		// delete from user where id in (1,2,3);
		int count = userMapper.deleteAll(idsArray);
		if (count == idsArray.length) {
			return ServerResponse.createSUCCESS("删除成功");
		}
		return ServerResponse.createERROR("删除失败");
	}

	@Override
	public ServerResponse add(User user) {
		int count = userMapper.insert(user);
		List<Role> roles = user.getRoles();
		//员工有角色时候，保存user_role关系到表中
		if (roles != null && roles.size() > 0) {
			for (Role role : roles) {
				UserRole userRole = new UserRole();
				userRole.setRoleId(role.getId());
				userRole.setUserId(user.getId());
				userRoleMapper.insert(userRole);
			}
		}
		if (count > 0) {
			return ServerResponse.createSUCCESS("添加成功");
		}
		return ServerResponse.createERROR("添加失败");
	}
	
	@Override
	public ServerResponse update(User user) {
		// 删除原来的角色
		userRoleMapper.deleteByUserId(user.getId());
		
		List<Role> roles = user.getRoles();
		//员工有角色时候，保存user_role关系到表中
		if (roles != null && roles.size() > 0) {
			for (Role role : roles) {
				UserRole userRole = new UserRole();
				userRole.setRoleId(role.getId());
				userRole.setUserId(user.getId());
				userRoleMapper.insert(userRole);
			}
		}
		
		int count = userMapper.updateByPrimaryKey(user);
		if (count > 0) {
			return ServerResponse.createSUCCESS("更新成功");
		}
		return ServerResponse.createERROR("更新失败");
	}

	@Override
	public List<Long> selectRoleIdByUserId(Long userId) {
		List<Long> list = userMapper.selectRoleIdByUserId(userId);
		return list;
	}
}
