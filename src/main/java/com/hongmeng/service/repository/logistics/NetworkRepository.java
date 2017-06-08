package com.hongmeng.service.repository.logistics;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.logistics.NetworkEntity;

public interface NetworkRepository extends PagingAndSortingRepository<NetworkEntity, Long> {
	
	Iterable<NetworkEntity> findByIdIn(List<Long> networkIds);
	
	Page<NetworkEntity> findByNameContainingOrAddressContaining(String name, String address, Pageable pageable);
	
	List<NetworkEntity> findByCompanyId(Long companyId);
	
	Page<NetworkEntity> findByCompanyId(Long companyId, Pageable pageable);

}
