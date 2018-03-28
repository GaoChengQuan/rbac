package com.situ.rbac.util;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.situ.rbac.entity.Permission;
import com.situ.rbac.entity.User;
import com.situ.rbac.mapper.PermissionMapper;

@Component
public class PermissionUtils {

    private static PermissionMapper permissionMapper;

    public static boolean checkPermission(String resource) {
        //User user = (User) UserContext.getLocalRequest().getSession().getAttribute(UserContext.USER_IN_SESSION);
    	User user = (User) UserContext.session.getAttribute(UserContext.USER_IN_SESSION);
        //1:该用户是超级管理员的话,返回true,直接放行
        if (user.getAdmin()!= null && user.getAdmin()) {
            return true;
        }
        //2:根据访问的方法的权限表单式去数据库权限表中查询,如果数据库存在则需要权限控制,数据库不存在,则不需要控制,直接放行
        Permission p = permissionMapper.selectByResource(resource);

        if (p != null) {
            //3:查询该用户是否拥有该方法的权限
            List<Permission> permissions = permissionMapper.selectByUserId(user.getId());
            for (Permission permission : permissions) {
                //4:如果用户拥有该权限则放行
                if (permission.getResource().equals(resource)) {
                    return true;
                }
            }
            // 不满足,则拦截
            return false;
        } else {
            return true;
        }

    }

    // 因为字段为static,不能直接注入,所以注入到setter方法上
    @Autowired
    public void setPermissionMapper(PermissionMapper permissionMapper) {
    	System.out.println("PermissionUtils.setPermissionMapper()");
        PermissionUtils.permissionMapper = permissionMapper;
    }
}
