package com.hongmeng.service.service.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.manufacture.ManufactureProductEntity;

public interface ManufactureProductService {

	ManufactureProductEntity findOne(Long productId);

	void save(ManufactureProductEntity product);

	void update(ManufactureProductEntity product, String name, String imagePath, Integer clazz, Integer subClazz,
			String model, Double price, String location, String origin, Integer property, String introduction,
			String description);

	void delete(List<Long> productIds);

	List<ManufactureProductEntity> list();

	Page<ManufactureProductEntity> list(int page, int size);

	List<ManufactureProductEntity> listByCompanyId(Long companyId);

	Page<ManufactureProductEntity> listByCompanyId(Long companyId, int page, int size);

	Page<ManufactureProductEntity> listByClazz(Integer clazz, int page, int size);

	Page<ManufactureProductEntity> listBySubClazz(Integer subClazz, int page, int size);

}
