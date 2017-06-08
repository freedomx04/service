package com.hongmeng.service.controller.recommend;

import java.util.List;

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
import com.hongmeng.service.entity.recommend.RecommendCompanyEntity;
import com.hongmeng.service.service.common.UeditorService;
import com.hongmeng.service.service.recommend.RecommendCompanyService;

@RestController
@RequestMapping("recommend/company")
public class RecommendCompanyController {
	
	static Logger log = LoggerFactory.getLogger(RecommendCompanyController.class);
	
	@Autowired
	RecommendCompanyService companyService;
	
	@Autowired
	UeditorService ueditorService;
	
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public Output detail(@RequestParam Long companyId) {
		try {
			RecommendCompanyEntity company = companyService.findOne(companyId);
			String content = ueditorService.getContent(company.getRecommendPath());
			company.setContent(content);
			return new Output(company, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<RecommendCompanyEntity> list = companyService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPaging", method = RequestMethod.POST)
	public Output listPaging(@RequestParam int page, @RequestParam int size) {
		try {
			Page<RecommendCompanyEntity> retPage = companyService.listPaging(page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/findByUserId", method = RequestMethod.POST)
	public Output findByUserId(@RequestParam Long userId) {
		try {
			RecommendCompanyEntity company = companyService.findByUserId(userId);
			String content = ueditorService.getContent(company.getRecommendPath());
			company.setContent(content);
			return new Output(company, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/editRecommend", method = RequestMethod.POST)
	public Output editRecommend(@RequestParam Long companyId, @RequestParam String content) {
		try {
			RecommendCompanyEntity company = companyService.findOne(companyId);
			String linkPath = ueditorService.save(content);
			company.setRecommendPath(linkPath);
			companyService.save(company);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}