package com.situ.rbac.mapper;

import com.situ.rbac.entity.RolePermission;

public interface RolePermissionMapper {
    int insert(RolePermission record);

    int insertSelective(RolePermission record);
}