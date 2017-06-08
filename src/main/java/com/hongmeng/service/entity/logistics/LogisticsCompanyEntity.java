package com.hongmeng.service.entity.logistics;

import java.util.LinkedList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.hongmeng.service.entity.common.BaseCompanyEntity;

@Entity
@Table(name = "common_company")
public class LogisticsCompanyEntity extends BaseCompanyEntity {
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<NetworkEntity> networks = new LinkedList<>(); // 网点
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<LineEntity> lines = new LinkedList<>(); // 线路
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<LogisticsEvaluationEntity> evaluations = new LinkedList<>(); // 评价
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<LogisticsDynamicEntity> dynamics = new LinkedList<>(); // 动态
	
	private int score = 0;
	
	public LogisticsCompanyEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public List<NetworkEntity> getNetworks() {
		return networks;
	}

	public void setNetworks(List<NetworkEntity> networks) {
		this.networks = networks;
	}

	public List<LineEntity> getLines() {
		return lines;
	}

	public void setLines(List<LineEntity> lines) {
		this.lines = lines;
	}

	public List<LogisticsEvaluationEntity> getEvaluations() {
		return evaluations;
	}

	public void setEvaluations(List<LogisticsEvaluationEntity> evaluations) {
		this.evaluations = evaluations;
	}

	public List<LogisticsDynamicEntity> getDynamics() {
		return dynamics;
	}

	public void setDynamics(List<LogisticsDynamicEntity> dynamics) {
		this.dynamics = dynamics;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}
	
}