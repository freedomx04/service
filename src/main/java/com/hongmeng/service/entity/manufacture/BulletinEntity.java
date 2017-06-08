package com.hongmeng.service.entity.manufacture;

import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;

@Entity
@Table(name = "manufacture_bulletin", indexes = {
	@Index(name = "index_manufacture_bulletin_type_updateTime", columnList = "type, updateTime")
})
public class BulletinEntity extends BaseEntity {
	
	private Integer type; // 快报类型
	
	private String imagePath; // 图片地址

	private String title; // 标题

	private String source; // 来源

	private String linkPath; // 文章地址

	private String content; // 文章内容

	public BulletinEntity() {
		// TODO Auto-generated constructor stub
	}

	public BulletinEntity(Integer type, String imagePath, String title, String source, String linkPath) {
		super();
		this.type = type;
		this.imagePath = imagePath;
		this.title = title;
		this.source = source;
		this.linkPath = linkPath;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
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

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	
}