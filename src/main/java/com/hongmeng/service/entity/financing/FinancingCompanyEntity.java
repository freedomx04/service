package com.hongmeng.service.entity.financing;

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
public class FinancingCompanyEntity extends BaseCompanyEntity {

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<InvestEntity> invests = new LinkedList<>(); // 投资

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<FinancingEvaluationEntity> evaluations = new LinkedList<>(); // 评价
	
	private int score = 0;
	
	public FinancingCompanyEntity() {
		// TODO Auto-generated constructor stub
	}

	public List<InvestEntity> getInvests() {
		return invests;
	}

	public void setInvests(List<InvestEntity> invests) {
		this.invests = invests;
	}

	public List<FinancingEvaluationEntity> getEvaluations() {
		return evaluations;
	}

	public void setEvaluations(List<FinancingEvaluationEntity> evaluations) {
		this.evaluations = evaluations;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}
	
}