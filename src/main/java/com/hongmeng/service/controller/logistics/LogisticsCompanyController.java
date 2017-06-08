package com.hongmeng.service.controller.logistics;

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
import com.hongmeng.service.entity.logistics.LogisticsCompanyEntity;
import com.hongmeng.service.entity.logistics.LogisticsEvaluationEntity;
import com.hongmeng.service.service.logistics.LogisticsCompanyService;

@RestController
@RequestMapping("logistics/company")
public class LogisticsCompanyController {

	static Logger log = LoggerFactory.getLogger(LogisticsCompanyController.class);

	@Autowired
	LogisticsCompanyService companyService;

	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public Output detail(@RequestParam Long companyId) {
		try {
			LogisticsCompanyEntity company = companyService.findOne(companyId);
			
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
			List<LogisticsCompanyEntity> list = companyService.list();
			
			for (LogisticsCompanyEntity company: list) {
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
			Page<LogisticsCompanyEntity> retPage = companyService.listPaging(page, size);
			
			List<LogisticsCompanyEntity> list = retPage.getContent();
			for (LogisticsCompanyEntity company: list) {
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
			LogisticsCompanyEntity company = companyService.findByUserId(userId);
			if (company != null) {
				company.setScore(averageScore(company.getEvaluations()));
			}
			return new Output(company, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/editContact", method = RequestMethod.POST)
	public Output editContact(@RequestParam Long companyId, @RequestParam String phone, @RequestParam String address,
			@RequestParam String contactUser, @RequestParam String contact, @RequestParam String fax,
			@RequestParam String website) {
		try {
			LogisticsCompanyEntity company = companyService.findOne(companyId);
			companyService.update(company, phone, address, contactUser, contact, fax, website);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	public int averageScore(List<LogisticsEvaluationEntity> evaluations) {
		double average = 0;
		if (evaluations.size() > 0) {
			double sum = 0;
			for (LogisticsEvaluationEntity evaluation: evaluations) {
				sum += evaluation.getScore();
			}
			average = sum / evaluations.size();
		}
		return (int) Math.round(average);
	}

}