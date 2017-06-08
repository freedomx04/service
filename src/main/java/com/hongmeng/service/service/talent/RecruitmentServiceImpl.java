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
import com.hongmeng.service.entity.talent.RecruitmentEntity;
import com.hongmeng.service.repository.talent.RecruitmentRepository;

@Service
public class RecruitmentServiceImpl implements RecruitmentService {

	@Autowired
	RecruitmentRepository recruitmentRepository;

	@Override
	public RecruitmentEntity findOne(Long recruitmentId) {
		return recruitmentRepository.findOne(recruitmentId);
	}

	@Override
	public void save(RecruitmentEntity recruitment) {
		Date now = new Date();
		recruitment.setCreateTime(now);
		recruitment.setUpdateTime(now);
		recruitmentRepository.save(recruitment);
	}

	@Override
	public void update(RecruitmentEntity recruitment) {
		recruitment.setUpdateTime(new Date());
		recruitmentRepository.save(recruitment);
	}

	@Override
	public void update(RecruitmentEntity recruitment, AreaEntity area, String position, Integer profession,
			Integer salary, Integer workingYears, Integer education, Integer number, String responsibilities,
			String requirements, String address, String workingHours, String contact) {
		recruitment.setArea(area);
		recruitment.setPosition(position);
		recruitment.setProfession(profession);
		recruitment.setSalary(salary);
		recruitment.setWorkingYears(workingYears);
		recruitment.setEducation(education);
		recruitment.setNumber(number);
		recruitment.setResponsibilities(responsibilities);
		recruitment.setRequirements(requirements);
		recruitment.setAddress(address);
		recruitment.setWorkingHours(workingHours);
		recruitment.setContact(contact);

		recruitment.setUpdateTime(new Date());
		recruitmentRepository.save(recruitment);
	}

	@Override
	public void delete(List<Long> recruitmentIds) {
		Iterable<RecruitmentEntity> it = recruitmentRepository.findByIdIn(recruitmentIds);
		recruitmentRepository.delete(it);
	}

	@Override
	public List<RecruitmentEntity> list() {
		return (List<RecruitmentEntity>) recruitmentRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<RecruitmentEntity> listPage(int page, int size) {
		return recruitmentRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public List<RecruitmentEntity> listByCompanyId(Long companyId) {
		return recruitmentRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId);
	}

	@Override
	public Page<RecruitmentEntity> listByCompanyId(Long companyId, int page, int size) {
		return recruitmentRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId, new PageRequest(page, size));
	}

	@Override
	public Page<RecruitmentEntity> search(String searchStr, int page, int size) {
		return recruitmentRepository.findByPositionContainingOrderByUpdateTimeDesc(searchStr,
				new PageRequest(page, size));
	}

	@Override
	public Page<RecruitmentEntity> filter(String area, String profession, String education, String workingYears,
			String salary, int page, int size) {
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

		return recruitmentRepository.findByAreaIdInAndProfessionInAndEducationInAndWorkingYearsInAndSalaryIn(arList,
				prlist, edlist, wylist, salist, new PageRequest(page, size));
	}

}