package com.hongmeng.service.repository.talent;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.talent.JobEntity;

public interface JobRepository extends PagingAndSortingRepository<JobEntity, Long> {

	Iterable<JobEntity> findByIdIn(List<Long> jobIds);

	List<JobEntity> findAllByOrderByUpdateTimeDesc();

	Page<JobEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);

	List<JobEntity> findByUserIdOrderByUpdateTimeDesc(Long userId);

	Page<JobEntity> findByUserIdOrderByUpdateTimeDesc(Long userId, Pageable pageable);

	Page<JobEntity> findByIntentionContainingOrderByUpdateTimeDesc(String intention, Pageable pageable);

	Page<JobEntity> findByAreaIdInAndProfessionInAndEducationInAndWorkingYearsInAndSalaryIn(List<Long> areaId,
			List<Integer> profession, List<Integer> education, List<Integer> workingYears, List<Integer> salary,
			Pageable pageable);

}