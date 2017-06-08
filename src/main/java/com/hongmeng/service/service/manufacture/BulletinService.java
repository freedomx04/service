package com.hongmeng.service.service.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.manufacture.BulletinEntity;

public interface BulletinService {
	
	BulletinEntity findOne(Long bulletinId);
	
	void save(BulletinEntity bulletin);
	
	void update(BulletinEntity bulletin, String imagePath, String title, String source, String linkPath);
	
	void delete(List<Long> bulletinIds);
	
	List<BulletinEntity> listByType(Integer type);
	
	Page<BulletinEntity> listByType(Integer type, int page, int size);

}
