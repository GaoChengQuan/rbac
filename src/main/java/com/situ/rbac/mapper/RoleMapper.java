package com.situ.rbac.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.situ.rbac.entity.Role;
import com.situ.rbac.entity.Role;

public interface RoleMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
    
    List<Role> pageList(Role role);

	int deleteAll(String[] idsArray);
}