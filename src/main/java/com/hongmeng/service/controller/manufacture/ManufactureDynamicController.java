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

import com.hongmeng.service.common.ReturnStatus;
import com.hongmeng.service.entity.Output;
import com.hongmeng.service.entity.OutputList;
import com.hongmeng.service.entity.common.CompanyEntity;
import com.hongmeng.service.entity.manufacture.ManufactureDynamicEntity;
import com.hongmeng.service.service.common.CompanyService;
import com.hongmeng.service.service.common.UeditorService;
import com.hongmeng.service.service.manufacture.ManufactureDynamicService;

@RestController
@RequestMapping("manufacture/dynamic")
public class ManufactureDynamicController {

	static Logger log = LoggerFactory.getLogger(ManufactureDynamicController.class);

	@Autowired
	ManufactureDynamicService dynamicService;

	@Autowired
	CompanyService companyService;

	@Autowired
	UeditorService ueditorService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam Long companyId, @RequestParam String title, @RequestParam String source,
			@RequestParam String content) {
		try {
			CompanyEntity company = companyService.findOne(companyId);
			String linkPath = ueditorService.save(content);
			ManufactureDynamicEntity dynamic = new ManufactureDynamicEntity(company, title, source, linkPath);
			dynamicService.save(dynamic);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long dynamicId, @RequestParam String title, @RequestParam String source,
			@RequestParam String content) {
		try {
			ManufactureDynamicEntity dynamic = dynamicService.findOne(dynamicId);
			String linkPath = ueditorService.update(dynamic.getLinkPath(), content);
			dynamicService.update(dynamic, title, source, linkPath);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String dynamicIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(dynamicIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			dynamicService.delete(list);
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
	public Output detail(@RequestParam Long dynamicId) {
		try {
			ManufactureDynamicEntity dynamic = dynamicService.findOne(dynamicId);
			
			String content = ueditorService.getContent(dynamic.getLinkPath());
			dynamic.setContent(content);
			return new Output(dynamic, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<ManufactureDynamicEntity> list = dynamicService.list();

			for (ManufactureDynamicEntity dynamic : list) {
				String content = ueditorService.getContent(dynamic.getLinkPath());
				dynamic.setContent(content);
			}
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPaging", method = RequestMethod.POST)
	public Output listPaging(@RequestParam int page, @RequestParam int size) {
		try {
			Page<ManufactureDynamicEntity> retPage = dynamicService.list(page, size);

			List<ManufactureDynamicEntity> list = retPage.getContent();
			for (ManufactureDynamicEntity dynamic : list) {
				String content = ueditorService.getContent(dynamic.getLinkPath());
				dynamic.setContent(content);
			}
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByCompanyId", method = RequestMethod.POST)
	public OutputList listByCompanyId(@RequestParam Long companyId) {
		try {
			List<ManufactureDynamicEntity> list = dynamicService.listByCompanyId(companyId);

			for (ManufactureDynamicEntity dynamic : list) {
				String content = ueditorService.getContent(dynamic.getLinkPath());
				dynamic.setContent(content);
			}
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByCompanyIdPaging", method = RequestMethod.POST)
	public Output listByCompanyIdPaging(@RequestParam Long companyId, @RequestParam int page, @RequestParam int size) {
		try {
			Page<ManufactureDynamicEntity> retPage = dynamicService.listByCompanyId(companyId, page, size);

			List<ManufactureDynamicEntity> list = retPage.getContent();
			for (ManufactureDynamicEntity dynamic : list) {
				String content = ueditorService.getContent(dynamic.getLinkPath());
				dynamic.setContent(content);
			}
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}