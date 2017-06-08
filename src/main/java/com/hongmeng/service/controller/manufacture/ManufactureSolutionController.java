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
import com.hongmeng.service.entity.manufacture.ManufactureSolutionEntity;
import com.hongmeng.service.service.common.CompanyService;
import com.hongmeng.service.service.common.UeditorService;
import com.hongmeng.service.service.manufacture.ManufactureSolutionService;

@RestController
@RequestMapping("manufacture/solution")
public class ManufactureSolutionController {

	static Logger log = LoggerFactory.getLogger(ManufactureSolutionController.class);

	@Autowired
	ManufactureSolutionService solutionService;

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
			ManufactureSolutionEntity solution = new ManufactureSolutionEntity(company, title, source, linkPath);
			solutionService.save(solution);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long solutionId, @RequestParam String title, @RequestParam String source,
			@RequestParam String content) {
		try {
			ManufactureSolutionEntity solution = solutionService.findOne(solutionId);
			String linkPath = ueditorService.update(solution.getLinkPath(), content);
			solutionService.update(solution, title, source, linkPath);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String solutionIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(solutionIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			solutionService.delete(list);
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
	public Output detail(@RequestParam Long solutionId) {
		try {
			ManufactureSolutionEntity solution = solutionService.findOne(solutionId);
			
			String content = ueditorService.getContent(solution.getLinkPath());
			solution.setContent(content);
			return new Output(solution, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<ManufactureSolutionEntity> list = solutionService.list();
			
			for (ManufactureSolutionEntity solution : list) {
				String content = ueditorService.getContent(solution.getLinkPath());
				solution.setContent(content);
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
			Page<ManufactureSolutionEntity> retPage = solutionService.list(page, size);
			
			List<ManufactureSolutionEntity> list = retPage.getContent();
			for (ManufactureSolutionEntity solution : list) {
				String content = ueditorService.getContent(solution.getLinkPath());
				solution.setContent(content);
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
			List<ManufactureSolutionEntity> list = solutionService.listByCompanyId(companyId);
			
			for (ManufactureSolutionEntity solution : list) {
				String content = ueditorService.getContent(solution.getLinkPath());
				solution.setContent(content);
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
			Page<ManufactureSolutionEntity> retPage = solutionService.listByCompanyId(companyId, page, size);
			
			List<ManufactureSolutionEntity> list = retPage.getContent();
			for (ManufactureSolutionEntity solution : list) {
				String content = ueditorService.getContent(solution.getLinkPath());
				solution.setContent(content);
			}
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}