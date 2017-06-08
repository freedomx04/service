package com.hongmeng.service.controller.financing;

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
import com.hongmeng.service.entity.financing.PolicyEntity;
import com.hongmeng.service.service.common.UeditorService;
import com.hongmeng.service.service.financing.PolicyService;

@RestController
@RequestMapping("financing/policy")
public class PolicyController {

	static Logger log = LoggerFactory.getLogger(PolicyController.class);

	@Autowired
	PolicyService policyService;

	@Autowired
	UeditorService ueditorService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam String title, @RequestParam String source, @RequestParam String content) {
		try {
			String linkPath = ueditorService.save(content);
			PolicyEntity policy = new PolicyEntity(title, source, linkPath);
			policyService.save(policy);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long policyId, @RequestParam String title, @RequestParam String source,
			@RequestParam String content) {
		try {
			PolicyEntity policy = policyService.findOne(policyId);
			String linkPath = ueditorService.update(policy.getLinkPath(), content);
			policyService.update(policy, title, source, linkPath);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String policyIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(policyIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			policyService.delete(list);
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
	public Output detail(@RequestParam Long policyId) {
		try {
			PolicyEntity policy = policyService.findOne(policyId);
			String content = ueditorService.getContent(policy.getLinkPath());
			policy.setContent(content);
			return new Output(policy, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<PolicyEntity> list = policyService.list();
			for (PolicyEntity policy: list) {
				String content = ueditorService.getContent(policy.getLinkPath());
				policy.setContent(content);
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
			Page<PolicyEntity> list = policyService.list(page, size);
			for (PolicyEntity policy: list) {
				String content = ueditorService.getContent(policy.getLinkPath());
				policy.setContent(content);
			}
			return new Output(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}