package com.hongmeng.service.service.talent;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.talent.JobEntity;
import com.hongmeng.service.repository.talent.JobRepository;

@Service
public class JobServiceImpl implements JobService {
	
	@Autowired
	JobRepository jobRepository;

	@Override
	public JobEntity findOne(Long jobId) {
		return jobRepository.findOne(jobId);
	}

	@Override
	public void save(JobEntity job) {
		Date now = new Date();
		job.setCreateTime(now);
		job.setUpdateTime(now);
		jobRepository.save(job);
	}
	
	@Override
	public void update(JobEntity job) {
		job.setUpdateTime(new Date());
		jobRepository.save(job);
	}

	@Override
	public void update(JobEntity job, AreaEntity area, String name, Integer sex, String imagePath, Integer birthYear, Integer workingYears,
			Integer education, String contact, String intention, Integer profession, Integer salary,
			String introduction, String workExperience, String educationExperience) {
		job.setArea(area);
		job.setName(name);
		job.setSex(sex);
		job.setImagePath(imagePath);
		job.setBirthYear(birthYear);
		job.setWorkingYears(workingYears);
		job.setEducation(education);
		job.setContact(contact);
		job.setIntention(intention);
		job.setProfession(profession);
		job.setSalary(salary);
		job.setIntroduction(introduction);
		job.setWorkExperience(workExperience);
		job.setEducationExperience(educationExperience);
		
		job.setUpdateTime(new Date());
		jobRepository.save(job);
	}

	@Override
	public void delete(List<Long> jobIds) {
		Iterable<JobEntity> it = jobRepository.findByIdIn(jobIds);
		jobRepository.delete(it);
	}

	@Override
	public List<JobEntity> list() {
		return (List<JobEntity>) jobRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<JobEntity> listPage(int page, int size) {
		return jobRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public List<JobEntity> listByUserId(Long userId) {
		return jobRepository.findByUserIdOrderByUpdateTimeDesc(userId);
	}

	@Override
	public Page<JobEntity> listByUserId(Long userId, int page, int size) {
		return jobRepository.findByUserIdOrderByUpdateTimeDesc(userId, new PageRequest(page, size));
	}

	@Override
	public Page<JobEntity> search(String searchStr, int page, int size) {
		return jobRepository.findByIntentionContainingOrderByUpdateTimeDesc(searchStr, new PageRequest(page, size));
	}

	@Override
	public Page<JobEntity> filter(String area, String profession, String education, String workingYears, String salary,
			int page, int size) {
		List<Long> arList = new LinkedList<>();
		for (String ar : StringUtils.split(area, '-')) {
			arList.add(Long.parseLong(ar));
		}

		List<Integer> prlist = new LinkedList<>();
		for (String pr : StringUtils.split(profession, '-')) {
			prlist.add(Integer.parseInt(pr));
		}

		List<Integer> edlist = new LinkedList<>();
		for (String ed : StringUtils.split(education, '-')) {
			edlist.add(Integer.parseInt(ed));
		}

		List<Integer> wylist = new LinkedList<>();
		for (String wy : StringUtils.split(workingYears, '-')) {
			wylist.add(Integer.parseInt(wy));
		}

		List<Integer> salist = new LinkedList<>();
		for (String sa : StringUtils.split(salary, '-')) {
			salist.add(Integer.parseInt(sa));
		}

		return jobRepository.findByAreaIdInAndProfessionInAndEducationInAndWorkingYearsInAndSalaryIn(arList,
				prlist, edlist, wylist, salist, new PageRequest(page, size));
	}

}