package com.situ.rbac.common;

public class ServerResponse<T> {

	//状态码，成功返回0失败返回1
	private Integer status;
	//状态信息
	private String msg;
	//返回的数据
	private T data;
	public ServerResponse() {
		super();
		
	}
	public ServerResponse(Integer status) {
		super();
		this.status = status;
	}
	public ServerResponse(Integer status, String msg) {
		super();
		this.status = status;
		this.msg = msg;
	}
	
	public ServerResponse(Integer status, T data) {
		super();
		this.status = status;
		this.data = data;
	}
	public ServerResponse(Integer status, String msg, T data) {
		super();
		this.status = status;
		this.msg = msg;
		this.data = data;
	}
	
	//返回告诉前台状态码
	public static<T> ServerResponse<T> createERROR() {
		return new ServerResponse<>(ResponseCode.ERROR.getCode());
	}
	//返回错误的信息，告诉前台
	public static<T> ServerResponse<T> createERROR(String msg) {
		return new ServerResponse<>(ResponseCode.ERROR.getCode(), msg);
	}
	//返回错误的信息，并且返回错误的得数据
	public static<T> ServerResponse<T> createERROR(String msg, T data) {
		return new ServerResponse<>(ResponseCode.ERROR.getCode(), msg, data);
	}
	//返回成功状态码
	public static<T> ServerResponse<T> createSUCCESS() {
		return new ServerResponse<>(ResponseCode.SUCCESS.getCode());
	}
	//返回成功的信息
	public static<T> ServerResponse<T> createSUCCESS(String msg) {
		return new ServerResponse<>(ResponseCode.SUCCESS.getCode(), msg);
	}
	//返回成功的信息，和数据
	public static<T> ServerResponse<T> createSUCCESS(String msg, T data) {
		return new ServerResponse<>(ResponseCode.SUCCESS.getCode(), msg, data);
	}
	//返回成功的数据
	public static<T> ServerResponse<T> createSUCCESS(T data) {
		return new ServerResponse<>(ResponseCode.SUCCESS.getCode(), data);
	}
	
	/**
	 * @return the status
	 */
	public Integer getStatus() {
		return status;
	}
	/**
	 * @return the msg
	 */
	public String getMsg() {
		return msg;
	}
	/**
	 * @return the data
	 */
	public T getData() {
		return data;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}
	/**
	 * @param msg the msg to set
	 */
	public void setMsg(String msg) {
		this.msg = msg;
	}
	/**
	 * @param data the data to set
	 */
	public void setData(T data) {
		this.data = data;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ServerResponse [status=" + status + ", msg=" + msg + ", data=" + data + "]";
	}
	
	
	
}
