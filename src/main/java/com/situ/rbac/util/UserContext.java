package com.situ.rbac.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class UserContext {
	public static final String USER_IN_SESSION = "user_in_session";
	public static final String PERMISSION_IN_SESSION = "permission_in_session";

	public static HttpSession session;
	
	
	/*// 创建当前线程对象
	private static ThreadLocal<HttpServletRequest> thread = new ThreadLocal();

	// 把请求加入当前线程中
	public static void setLocalThread(HttpServletRequest request) {
		thread.set(request);
	}

	// 获取当前线程
	public static HttpServletRequest getLocalRequest() {
		return thread.get();
	}*/

}
