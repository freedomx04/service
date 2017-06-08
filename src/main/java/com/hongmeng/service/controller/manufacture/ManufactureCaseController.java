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
import com.hongmeng.service.entity.manufacture.ManufactureCaseEntity;
import com.hongmeng.service.service.common.CompanyService;
import com.hongmeng.service.service.common.UeditorService;
import com.hongmeng.service.service.manufacture.ManufactureCaseService;

@RestController
@RequestMapping("manufacture/case")
public class ManufactureCaseController {

	static Logger log = LoggerFactory.getLogger(ManufactureCaseController.class);

	@Autowired
	ManufactureCaseService caseService;
	
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
			ManufactureCaseEntity manufactureCase = new ManufactureCaseEntity(company, title, source, linkPath);
			caseService.save(manufactureCase);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long caseId, @RequestParam String title, @RequestParam String source,
			@RequestParam String content) {
		try {
			ManufactureCaseEntity manufactureCase = caseService.findOne(caseId);
			String linkPath = ueditorService.update(manufactureCase.getLinkPath(), content);
			caseService.update(manufactureCase, title, source, linkPath);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String caseIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(caseIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			caseService.delete(list);
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
	public Output detail(@RequestParam Long caseId) {
		try {
			ManufactureCaseEntity manufactureCase = caseService.findOne(caseId);
			
			String content = ueditorService.getContent(manufactureCase.getLinkPath());
			manufactureCase.setContent(content);
			return new Output(manufactureCase, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<ManufactureCaseEntity> list = caseService.list();
			
			for (ManufactureCaseEntity manufactureCase : list) {
				String content = ueditorService.getContent(manufactureCase.getLinkPath());
				manufactureCase.setContent(content);
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
			Page<ManufactureCaseEntity> retPage = caseService.list(page, size);
			
			List<ManufactureCaseEntity> list = retPage.getContent();
			for (ManufactureCaseEntity manufactureCase : list) {
				String content = ueditorService.getContent(manufactureCase.getLinkPath());
				manufactureCase.setContent(content);
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
			List<ManufactureCaseEntity> list = caseService.listByCompanyId(companyId);
			
			for (ManufactureCaseEntity manufactureCase : list) {
				String content = ueditorService.getContent(manufactureCase.getLinkPath());
				manufactureCase.setContent(content);
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
			Page<ManufactureCaseEntity> retPage = caseService.listByCompanyId(companyId, page, size);
			
			List<ManufactureCaseEntity> list = retPage.getContent();
			for (ManufactureCaseEntity manufactureCase : list) {
				String content = ueditorService.getContent(manufactureCase.getLinkPath());
				manufactureCase.setContent(content);
			}
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}