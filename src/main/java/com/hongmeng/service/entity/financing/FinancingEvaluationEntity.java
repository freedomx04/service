package com.hongmeng.service.entity.financing;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.authority.BaseUserEntity;
import com.hongmeng.service.entity.talent.TalentEvaluationEntity.AnonymousStatus;

@Entity
@Table(name = "financing_evaluation", indexes = {
		@Index(name = "index_financing_evaluation_company_createTime", columnList = "company_id, createTime"),
		@Index(name = "index_financing_evaluation_user_createTime", columnList = "user_id, createTime") })
public class FinancingEvaluationEntity extends BaseEntity {

	@Column(name = "company_id")
	private Long companyId; // 公司id

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "user_id")
	private BaseUserEntity user; // 用户

	private Integer score; // 综合评分

	private String comment; // 评论

	private Integer anonymous = AnonymousStatus.STATUS_NO_ANONYMOUS; // 匿名

	public FinancingEvaluationEntity() {
		// TODO Auto-generated constructor stub
	}

	public FinancingEvaluationEntity(Long companyId, BaseUserEntity user, Integer score, String comment,
			Integer anonymous) {
		super();
		this.companyId = companyId;
		this.user = user;
		this.score = score;
		this.comment = comment;
		this.anonymous = anonymous;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public BaseUserEntity getUser() {
		return user;
	}

	public void setUser(BaseUserEntity user) {
		this.user = user;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Integer getAnonymous() {
		return anonymous;
	}

	public void setAnonymous(Integer anonymous) {
		this.anonymous = anonymous;
	}

}