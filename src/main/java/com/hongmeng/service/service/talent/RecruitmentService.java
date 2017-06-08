package com.hongmeng.service.service.talent;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.talent.RecruitmentEntity;

public interface RecruitmentService {

	RecruitmentEntity findOne(Long recruitmentId);

	void save(RecruitmentEntity recruitment);

	void update(RecruitmentEntity recruitment);

	void update(RecruitmentEntity recruitment, AreaEntity area, String position, Integer profession, Integer salary,
			Integer workingYears, Integer education, Integer number, String responsibilities, String requirements,
			String address, String workingHours, String contact);

	void delete(List<Long> recruitmentIds);

	List<RecruitmentEntity> list();

	Page<RecruitmentEntity> listPage(int page, int size);

	List<RecruitmentEntity> listByCompanyId(Long companyId);

	Page<RecruitmentEntity> listByCompanyId(Long companyId, int page, int size);

	Page<RecruitmentEntity> search(String searchStr, int page, int size);

	Page<RecruitmentEntity> filter(String area, String profession, String education, String workingYears, String salary,
			int page, int size);

}