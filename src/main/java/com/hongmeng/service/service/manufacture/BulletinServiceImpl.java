package com.hongmeng.service.service.manufacture;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.manufacture.BulletinEntity;
import com.hongmeng.service.repository.manufacture.BulletinRepository;

@Service
public class BulletinServiceImpl implements BulletinService {
	
	@Autowired
	BulletinRepository bulletinRepository;

	@Override
	public BulletinEntity findOne(Long bulletinId) {
		return bulletinRepository.findOne(bulletinId);
	}

	@Override
	public void save(BulletinEntity bulletin) {
		Date now = new Date();
		bulletin.setCreateTime(now);
		bulletin.setUpdateTime(now);
		bulletinRepository.save(bulletin);
	}

	@Override
	public void update(BulletinEntity bulletin, String imagePath, String title, String source,
			String linkPath) {
		bulletin.setImagePath(imagePath);
		bulletin.setTitle(title);
		bulletin.setSource(source);
		bulletin.setLinkPath(linkPath);
		
		bulletin.setUpdateTime(new Date());
		bulletinRepository.save(bulletin);
	}

	@Override
	public void delete(List<Long> bulletinIds) {
		Iterable<BulletinEntity> it = bulletinRepository.findByIdIn(bulletinIds);
		bulletinRepository.delete(it);
	}

	@Override
	public List<BulletinEntity> listByType(Integer type) {
		return bulletinRepository.findByTypeOrderByUpdateTimeDesc(type);
	}

	@Override
	public Page<BulletinEntity> listByType(Integer type, int page, int size) {
		return bulletinRepository.findByTypeOrderByUpdateTimeDesc(type, new PageRequest(page, size));
	}

}