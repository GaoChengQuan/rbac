package com.situ.rbac.mapper;

import com.situ.rbac.entity.EmployeeRole;

public interface EmployeeRoleMapper {
    int insert(EmployeeRole record);

    int insertSelective(EmployeeRole record);
}