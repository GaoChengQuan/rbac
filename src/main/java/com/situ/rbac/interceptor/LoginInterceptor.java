package com.situ.rbac.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.situ.rbac.entity.User;
import com.situ.rbac.util.UserContext;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object target) throws Exception {
        User user = (User) request.getSession().getAttribute(UserContext.USER_IN_SESSION);
        if (user != null) {
        	return true;
        } else {
            response.sendRedirect(request.getContextPath() + "/user/getLoginPage.action");
            return false;
        }
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
