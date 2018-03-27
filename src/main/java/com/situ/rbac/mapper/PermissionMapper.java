package com.situ.rbac.mapper;

import java.util.List;

import com.situ.rbac.entity.Permission;
import com.situ.rbac.entity.Permission;

public interface PermissionMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Permission record);

    int insertSelective(Permission record);

    Permission selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Permission record);

    int updateByPrimaryKey(Permission record);
    
    List<Permission> pageList(Permission Permission);

	int deleteAll(String[] idsArray);
}