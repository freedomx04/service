package com.hongmeng.service.service.talent;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.talent.JobEntity;

public interface JobService {

	JobEntity findOne(Long jobId);

	void save(JobEntity job);
	
	void update(JobEntity job);

	void update(JobEntity job, AreaEntity area, String name, Integer sex, String imagePath, Integer birthYear, Integer workingYears,
			Integer education, String contact, String intention, Integer profession, Integer salary,
			String introduction, String workExperience, String educationExperience);

	void delete(List<Long> jobIds);
	
	List<JobEntity> listByUserId(Long userId);
	
	Page<JobEntity> listByUserId(Long userId, int page, int size);

	List<JobEntity> list();

	Page<JobEntity> listPage(int page, int size);
	
	Page<JobEntity> search(String searchStr, int page, int size);
	
	Page<JobEntity> filter(String area, String profession, String education, String workingYears, String salary,
			int page, int size);

}