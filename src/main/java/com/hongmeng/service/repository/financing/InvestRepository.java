package com.hongmeng.service.repository.financing;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.financing.InvestEntity;

public interface InvestRepository extends PagingAndSortingRepository<InvestEntity, Long> {
	
	Iterable<InvestEntity> findByIdIn(List<Long> investIds);
	
	Page<InvestEntity> findByNameContaining(String name, Pageable pageable);
	
	Page<InvestEntity> findByInvestTypeInAndFundTypeIn(List<Integer> investType, List<Integer> fundType, Pageable pageable);
	
	List<InvestEntity> findAllByOrderByUpdateTimeDesc();

	Page<InvestEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);

	List<InvestEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId);

	Page<InvestEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId, Pageable pageable);

}