package com.situ.rbac.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.situ.rbac.entity.User;

public interface UserMapper {
    int deleteByPrimaryKey(Long id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    List<User> pageList(User user);

	int deleteAll(String[] idsArray);

	List<Long> selectRoleIdByUserId(Long userId);

	User login(@Param("name")String name, @Param("password")String password);
}