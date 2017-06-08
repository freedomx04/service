package com.hongmeng.service.controller.manufacture;

import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.hongmeng.service.common.ReturnStatus;
import com.hongmeng.service.entity.Output;
import com.hongmeng.service.entity.OutputList;
import com.hongmeng.service.entity.common.CompanyEntity;
import com.hongmeng.service.entity.manufacture.ManufactureProductEntity;
import com.hongmeng.service.service.common.CompanyService;
import com.hongmeng.service.service.common.UeditorService;
import com.hongmeng.service.service.manufacture.ManufactureProductService;

@RestController
@RequestMapping("manufacture/product")
public class ManufactureProductController {

	static Logger log = LoggerFactory.getLogger(ManufactureProductController.class);

	@Autowired
	CompanyService companyService;

	@Autowired
	ManufactureProductService productService;

	@Autowired
	UeditorService ueditorService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam Long companyId, @RequestParam String name,
			@RequestParam(name = "uploadImage") MultipartFile uploadImage,
			@RequestParam Integer clazz, @RequestParam Integer subClazz, @RequestParam String model,
			@RequestParam Double price, @RequestParam String location, @RequestParam String origin,
			@RequestParam Integer property, @RequestParam String introduction, @RequestParam String description) {
		try {
			CompanyEntity company = companyService.findOne(companyId);
			String imagePath = "";
			if (uploadImage != null && !uploadImage.isEmpty()) {
				imagePath = ueditorService.saveImage(uploadImage);
			}

			ManufactureProductEntity product = new ManufactureProductEntity(company, name, imagePath, clazz, subClazz,
					model, price, location, origin, property, introduction, description);
			productService.save(product);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long productId, @RequestParam String name,
			@RequestParam(name = "uploadImage") MultipartFile uploadImage,
			@RequestParam Integer clazz, @RequestParam Integer subClazz, @RequestParam String model,
			@RequestParam Double price, @RequestParam String location, @RequestParam String origin,
			@RequestParam Integer property, @RequestParam String introduction, @RequestParam String description) {
		try {
			ManufactureProductEntity product = productService.findOne(productId);
			
			String imagePath = product.getImagePath();
			if (uploadImage!= null && !uploadImage.isEmpty()) {
				imagePath = ueditorService.saveImage(uploadImage);
			}
			
			productService.update(product, name, imagePath, clazz, subClazz, model, price, location, origin, property,
					introduction, description);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String productIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(productIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			productService.delete(list);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Output(null, ReturnStatus.CONSTRAINT.status(), e.getMessage());
			}
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public Output detail(@RequestParam Long productId) {
		try {
			ManufactureProductEntity product = productService.findOne(productId);
			return new Output(product, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<ManufactureProductEntity> list = productService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPaging", method = RequestMethod.POST)
	public Output listPaging(@RequestParam int page, @RequestParam int size) {
		try {
			Page<ManufactureProductEntity> retPage = productService.list(page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByCompanyId", method = RequestMethod.POST)
	public OutputList listByCompanyId(@RequestParam Long companyId) {
		try {
			List<ManufactureProductEntity> list = productService.listByCompanyId(companyId);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByCompanyIdPaging", method = RequestMethod.POST)
	public Output listByCompanyIdPaging(@RequestParam Long companyId, @RequestParam int page, @RequestParam int size) {
		try {
			Page<ManufactureProductEntity> retPage = productService.listByCompanyId(companyId, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByClazzPaging", method = RequestMethod.POST)
	public Output listByClazzPaging(@RequestParam Integer clazz, @RequestParam int page, @RequestParam int size) {
		try {
			Page<ManufactureProductEntity> retPage = productService.listByClazz(clazz, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listBySubClazzPaging", method = RequestMethod.POST)
	public Output listBySubClazzPaging(@RequestParam Integer subClazz, @RequestParam int page, @RequestParam int size) {
		try {
			Page<ManufactureProductEntity> retPage = productService.listBySubClazz(subClazz, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}