package com.hongmeng.service.service.recommend;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.recommend.RecommendProductEntity;

public interface RecommendProductService {

	RecommendProductEntity findOne(Long productId);

	void save(RecommendProductEntity product);

	void update(RecommendProductEntity product, String name, String imagePath, String model, String location,
			String introduction, String description);

	void delete(List<Long> productIds);

	List<RecommendProductEntity> list();

	Page<RecommendProductEntity> list(int page, int size);

	List<RecommendProductEntity> listByCompanyId(Long companyId);

	Page<RecommendProductEntity> listByCompanyId(Long companyId, int page, int size);

}
