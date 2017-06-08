package com.hongmeng.service.service.manufacture;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.manufacture.ManufactureProductEntity;
import com.hongmeng.service.repository.manufacture.ManufactureProductRepository;

@Service
public class ManufactureProductServiceImpl implements ManufactureProductService {

	@Autowired
	ManufactureProductRepository productRepository;

	@Override
	public ManufactureProductEntity findOne(Long productId) {
		return productRepository.findOne(productId);
	}

	@Override
	public void save(ManufactureProductEntity product) {
		Date now = new Date();
		product.setCreateTime(now);
		product.setUpdateTime(now);
		productRepository.save(product);
	}

	@Override
	public void update(ManufactureProductEntity product, String name, String imagePath, Integer clazz, Integer subClazz,
			String model, Double price, String location, String origin, Integer property, String introduction,
			String description) {
		product.setName(name);
		product.setImagePath(imagePath);
		product.setClazz(clazz);
		product.setSubClazz(subClazz);
		product.setModel(model);
		product.setPrice(price);
		product.setLocation(location);
		product.setOrigin(origin);
		product.setProperty(property);
		product.setIntroduction(introduction);
		product.setDescription(description);

		product.setUpdateTime(new Date());
		productRepository.save(product);
	}

	@Override
	public void delete(List<Long> productIds) {
		Iterable<ManufactureProductEntity> it = productRepository.findByIdIn(productIds);
		productRepository.delete(it);
	}

	@Override
	public List<ManufactureProductEntity> list() {
		return (List<ManufactureProductEntity>) productRepository.findAll();
	}

	@Override
	public Page<ManufactureProductEntity> list(int page, int size) {
		return productRepository.findAll(new PageRequest(page, size));
	}

	@Override
	public List<ManufactureProductEntity> listByCompanyId(Long companyId) {
		return productRepository.findByCompanyId(companyId);
	}

	@Override
	public Page<ManufactureProductEntity> listByCompanyId(Long companyId, int page, int size) {
		return productRepository.findByCompanyId(companyId, new PageRequest(page, size));
	}

	@Override
	public Page<ManufactureProductEntity> listByClazz(Integer clazz, int page, int size) {
		return productRepository.findByClazz(clazz, new PageRequest(page, size));
	}

	@Override
	public Page<ManufactureProductEntity> listBySubClazz(Integer subClazz, int page, int size) {
		return productRepository.findBySubClazz(subClazz, new PageRequest(page, size));
	}

}