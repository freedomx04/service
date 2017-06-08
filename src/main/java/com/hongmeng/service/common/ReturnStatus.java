package com.hongmeng.service.common;

public enum ReturnStatus {
	
	/**
	 * common
	 */
	SUCCESS		(0, 	"操作成功"),
	FAILED 		(1, 	"操作失败"),
	NULL   		(2, 	"不存在"),
	EXISTED		(3, 	"已存在"),
	CONSTRAINT	(4, 	"有关联"),
	
	/**
	 * user
	 */
	USER_EXISTED			(10, 	"用户已存在"),
	USER_PWD_ERROR			(11, 	"密码错误"),
	USER_REGISTER_SUCCESS	(12, 	"注册成功"),
	USER_STATUS_NO_VALID	(13, 	"用户已被禁用"),
	USER_NO_EXIST			(14, 	"用户不存在"),
	
	;
	
	private final int status;
	private final String msg;
	
	private ReturnStatus(int status, String msg) {
		this.status = status;
		this.msg = msg;
	}
	
	public int status() {
		return this.status;
	}

	public String msg() {
		return this.msg;
	}
	
	@Override
	public String toString() {
		return String.valueOf(this.status);
	}
	
}