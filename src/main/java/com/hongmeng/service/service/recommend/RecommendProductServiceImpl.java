package com.hongmeng.service.service.recommend;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.recommend.RecommendProductEntity;
import com.hongmeng.service.repository.recommend.RecommendProductRepository;

@Service
public class RecommendProductServiceImpl implements RecommendProductService {

	@Autowired
	RecommendProductRepository productRepository;

	@Override
	public RecommendProductEntity findOne(Long productId) {
		return productRepository.findOne(productId);
	}

	@Override
	public void save(RecommendProductEntity product) {
		Date now = new Date();
		product.setCreateTime(now);
		product.setUpdateTime(now);
		productRepository.save(product);
	}

	@Override
	public void update(RecommendProductEntity product, String name, String imagePath, String model, String location,
			String introduction, String description) {
		product.setName(name);
		product.setImagePath(imagePath);
		product.setModel(model);
		product.setLocation(location);
		product.setIntroduction(introduction);
		product.setDescription(description);

		product.setUpdateTime(new Date());
		productRepository.save(product);
	}

	@Override
	public void delete(List<Long> productIds) {
		Iterable<RecommendProductEntity> it = productRepository.findByIdIn(productIds);
		productRepository.delete(it);
	}

	@Override
	public List<RecommendProductEntity> list() {
		return (List<RecommendProductEntity>) productRepository.findAll();
	}

	@Override
	public Page<RecommendProductEntity> list(int page, int size) {
		return productRepository.findAll(new PageRequest(page, size));
	}

	@Override
	public List<RecommendProductEntity> listByCompanyId(Long companyId) {
		return productRepository.findByCompanyId(companyId);
	}

	@Override
	public Page<RecommendProductEntity> listByCompanyId(Long companyId, int page, int size) {
		return productRepository.findByCompanyId(companyId, new PageRequest(page, size));
	}

}