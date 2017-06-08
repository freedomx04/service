package com.hongmeng.service.entity.financing;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;

@Entity
@Table(name = "financing_policy")
public class PolicyEntity extends BaseEntity {

	private String title; // 政策标题

	private String source; // 政策来源

	private String linkPath; // 地址

	private String content; // 内容
	
	public PolicyEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public PolicyEntity(String title, String source, String linkPath) {
		super();
		this.title = title;
		this.source = source;
		this.linkPath = linkPath;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getLinkPath() {
		return linkPath;
	}

	public void setLinkPath(String linkPath) {
		this.linkPath = linkPath;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}