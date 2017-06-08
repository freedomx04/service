package com.hongmeng.service.controller.financing;

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
import com.hongmeng.service.entity.financing.FinancingCompanyEntity;
import com.hongmeng.service.entity.financing.FinancingEvaluationEntity;
import com.hongmeng.service.service.financing.FinancingCompanyService;

@RestController
@RequestMapping("financing/company")
public class FinancingCompanyController {
	
	static Logger log = LoggerFactory.getLogger(FinancingCompanyController.class);
	
	@Autowired
	FinancingCompanyService companyService;
	
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public Output detail(@RequestParam Long companyId) {
		try {
			FinancingCompanyEntity company = companyService.findOne(companyId);
			
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
			List<FinancingCompanyEntity> list = companyService.list();
			
			for (FinancingCompanyEntity company: list) {
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
			Page<FinancingCompanyEntity> retPage = companyService.listPaging(page, size);
			
			List<FinancingCompanyEntity> list = retPage.getContent();
			for (FinancingCompanyEntity company: list) {
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
			FinancingCompanyEntity company = companyService.findByUserId(userId);
			
			if (company != null) {
				company.setScore(averageScore(company.getEvaluations()));
			}
			return new Output(company, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	public int averageScore(List<FinancingEvaluationEntity> evaluations) {
		double average = 0;
		if (evaluations.size() > 0) {
			double sum = 0;
			for (FinancingEvaluationEntity evaluation: evaluations) {
				sum += evaluation.getScore();
			}
			average = sum / evaluations.size();
		}
		return (int) Math.round(average);
	}

}