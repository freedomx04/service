package com.hongmeng.service.repository.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.manufacture.BulletinEntity;

public interface BulletinRepository extends PagingAndSortingRepository<BulletinEntity, Long>  {
	
	Iterable<BulletinEntity> findByIdIn(List<Long> bulletinIds);

	List<BulletinEntity> findByTypeOrderByUpdateTimeDesc(Integer type);

	Page<BulletinEntity> findByTypeOrderByUpdateTimeDesc(Integer type, Pageable pageable);

}