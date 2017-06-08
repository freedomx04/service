package com.hongmeng.service.repository.talent;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.talent.RecruitmentEntity;

public interface RecruitmentRepository extends PagingAndSortingRepository<RecruitmentEntity, Long> {

	List<RecruitmentEntity> findByIdIn(List<Long> recruitmentId);

	List<RecruitmentEntity> findByIdInOrderByUpdateTimeDesc(List<Long> recruitmentId);

	List<RecruitmentEntity> findAllByOrderByUpdateTimeDesc();

	Page<RecruitmentEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);

	List<RecruitmentEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId);

	Page<RecruitmentEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId, Pageable pageable);

	Page<RecruitmentEntity> findByPositionContainingOrderByUpdateTimeDesc(String position, Pageable pageable);

	Page<RecruitmentEntity> findByAreaIdInAndProfessionInAndEducationInAndWorkingYearsInAndSalaryIn(List<Long> areaId,
			List<Integer> profession, List<Integer> education, List<Integer> workingYears, List<Integer> salary,
			Pageable pageable);

}