package com.hongmeng.service.service.logistics;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.logistics.NetworkEntity;
import com.hongmeng.service.repository.logistics.NetworkRepository;

@Service
public class NetworkServiceImpl implements NetworkService {
	
	@Autowired
	NetworkRepository networkRepository;

	@Override
	public NetworkEntity findOne(Long networkId) {
		return networkRepository.findOne(networkId);
	}

	@Override
	public void save(NetworkEntity network) {
		Date now = new Date();
		network.setCreateTime(now);
		network.setUpdateTime(now);
		networkRepository.save(network);
	}

	@Override
	public void update(NetworkEntity network, String name, String address, String contact, String business) {
		network.setName(name);
		network.setAddress(address);
		network.setContact(contact);
		network.setBusiness(business);
		
		network.setUpdateTime(new Date());
		networkRepository.save(network);
	}

	@Override
	public void delete(List<Long> networkIds) {
		Iterable<NetworkEntity> it = networkRepository.findByIdIn(networkIds);
		networkRepository.delete(it);
	}
	
	@Override
	public Page<NetworkEntity> search(String searchStr, int page, int size) {
		return networkRepository.findByNameContainingOrAddressContaining(searchStr, searchStr, new PageRequest(page, size));
	}

	@Override
	public List<NetworkEntity> list() {
		return (List<NetworkEntity>) networkRepository.findAll();
	}

	@Override
	public Page<NetworkEntity> list(Pageable pageable) {
		return networkRepository.findAll(pageable);
	}

	@Override
	public List<NetworkEntity> listByCompanyId(Long companyId) {
		return networkRepository.findByCompanyId(companyId);
	}

	@Override
	public Page<NetworkEntity> listByCompanyId(Long companyId, Pageable pageable) {
		return networkRepository.findByCompanyId(companyId, pageable);
	}

}