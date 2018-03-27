package com.situ.rbac.common;

public enum ResponseCode {

	SUCCESS(0,"SUCCESS"),
	ERROR(1,"ERROR");
	private Integer code;
	private String desc;
	
	private ResponseCode(Integer code, String desc) {
		this.code = code;
		this.desc = desc;
	}

	/**
	 * @return the code
	 */
	public Integer getCode() {
		return code;
	}

	/**
	 * @return the desc
	 */
	public String getDesc() {
		return desc;
	}

	/**
	 * @param code the code to set
	 */
	public void setCode(Integer code) {
		this.code = code;
	}

	/**
	 * @param desc the desc to set
	 */
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	
}
