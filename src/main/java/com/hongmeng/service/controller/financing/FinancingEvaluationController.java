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
import com.hongmeng.service.entity.authority.BaseUserEntity;
import com.hongmeng.service.entity.financing.FinancingEvaluationEntity;
import com.hongmeng.service.service.authority.UserService;
import com.hongmeng.service.service.financing.FinancingEvaluationService;

@RestController
@RequestMapping("financing/evaluation")
public class FinancingEvaluationController {

	Logger log = LoggerFactory.getLogger(FinancingEvaluationController.class);

	@Autowired
	UserService userService;

	@Autowired
	FinancingEvaluationService evaluationService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam Long companyId, @RequestParam Long userId, @RequestParam Integer score,
			@RequestParam String comment, @RequestParam Integer anonymous) {
		try {
			BaseUserEntity user = userService.findOneBase(userId);
			FinancingEvaluationEntity evaluation = new FinancingEvaluationEntity(companyId, user, score, comment, anonymous);
			evaluationService.save(evaluation);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/listByCompanyId", method = RequestMethod.POST)
	public OutputList listByCompanyId(@RequestParam Long companyId) {
		try {
			List<FinancingEvaluationEntity> list = evaluationService.listByCompanyId(companyId);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/listByCompanyIdPaging", method = RequestMethod.POST)
	public Output listByCompanyIdPaging(@RequestParam Long companyId, @RequestParam int page, @RequestParam int size) {
		try {
			Page<FinancingEvaluationEntity> retPage = evaluationService.listByCompanyId(companyId, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/listByUserId", method = RequestMethod.POST)
	public OutputList listByUserId(@RequestParam Long userId) {
		try {
			List<FinancingEvaluationEntity> list = evaluationService.listByUserId(userId);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/listByUserIdPaging", method = RequestMethod.POST)
	public Output listByUserIdPaging(@RequestParam Long userId, @RequestParam int page, @RequestParam int size) {
		try {
			Page<FinancingEvaluationEntity> retPage = evaluationService.listByUserId(userId, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}