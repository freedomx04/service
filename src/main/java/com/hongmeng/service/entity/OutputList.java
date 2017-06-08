package com.hongmeng.service.entity;

import java.util.List;

public class OutputList {

	public List<?> data;

	public int status;

	public String msg;

	public OutputList() {
		// TODO Auto-generated constructor stub
	}

	public OutputList(List<?> data, int status, String msg) {
		this.data = data;
		this.status = status;
		this.msg = msg;
	}
	
}
