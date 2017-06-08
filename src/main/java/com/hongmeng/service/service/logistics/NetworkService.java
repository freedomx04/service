package com.hongmeng.service.service.logistics;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.hongmeng.service.entity.logistics.NetworkEntity;

public interface NetworkService {

	NetworkEntity findOne(Long networkId);

	void save(NetworkEntity network);

	void update(NetworkEntity network, String name, String address, String contact, String business);
	
	void delete(List<Long> networkIds);
	
	Page<NetworkEntity> search(String searchStr, int page, int size);
	
	List<NetworkEntity> list();
	
	Page<NetworkEntity> list(Pageable pageable);
	
	List<NetworkEntity> listByCompanyId(Long companyId);
	
	Page<NetworkEntity> listByCompanyId(Long companyId, Pageable pageable);
	
}
