package com.hongmeng.service.controller.talent;

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
import com.hongmeng.service.entity.talent.TalentCompanyEntity;
import com.hongmeng.service.entity.talent.TalentEvaluationEntity;
import com.hongmeng.service.service.authority.AreaService;
import com.hongmeng.service.service.authority.UserService;
import com.hongmeng.service.service.common.UeditorService;
import com.hongmeng.service.service.talent.TalentCompanyService;

@RestController
@RequestMapping("talent/company")
public class TalentCompanyController {

	static Logger log = LoggerFactory.getLogger(TalentCompanyController.class);

	@Autowired
	TalentCompanyService companyService;

	@Autowired
	AreaService areaService;

	@Autowired
	UserService userService;

	@Autowired
	UeditorService ueditorService;
	
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public Output detail(@RequestParam Long companyId) {
		try {
			TalentCompanyEntity company = companyService.findOne(companyId);
			company.setScore(averageScore(company.getEvaluations()));
			return new Output(company, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<TalentCompanyEntity> list = companyService.list();
			
			for (TalentCompanyEntity company: list) {
				company.setScore(averageScore(company.getEvaluations()));
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
			Page<TalentCompanyEntity> retPage = companyService.listPaging(page, size);
			
			List<TalentCompanyEntity> list = retPage.getContent();
			for (TalentCompanyEntity company: list) {
				company.setScore(averageScore(company.getEvaluations()));
			}
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/findByUserId", method = RequestMethod.POST)
	public Output findByUserId(@RequestParam Long userId) {
		try {
			TalentCompanyEntity company = companyService.findByUserId(userId);
			
			if (company != null) {
				company.setScore(averageScore(company.getEvaluations()));
			}
			return new Output(company, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/searchPaging", method = RequestMethod.POST)
	public Output searchPaging(@RequestParam String searchStr, @RequestParam int page,
			@RequestParam int size) {
		try {
			Page<TalentCompanyEntity> ret = companyService.search(searchStr, page, size);
			return new Output(ret, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	public int averageScore(List<TalentEvaluationEntity> evaluations) {
		double average = 0;
		if (evaluations.size() > 0) {
			double sum = 0;
			for (TalentEvaluationEntity evaluation: evaluations) {
				sum += evaluation.getScore();
			}
			average = sum / evaluations.size();
		}
		return (int) Math.round(average);
	}
	
}