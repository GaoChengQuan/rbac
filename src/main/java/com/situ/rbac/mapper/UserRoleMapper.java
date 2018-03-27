package com.situ.rbac.mapper;

import com.situ.rbac.entity.UserRole;

public interface UserRoleMapper {
    int insert(UserRole record);

    int insertSelective(UserRole record);
}