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
import com.hongmeng.service.entity.authority.BaseUserEntity;
import com.hongmeng.service.entity.financing.FinancingEntity;
import com.hongmeng.service.service.authority.UserService;
import com.hongmeng.service.service.financing.FinancingService;

@RestController
@RequestMapping("financing/financing")
public class FinancingController {

	static Logger log = LoggerFactory.getLogger(FinancingController.class);

	@Autowired
	UserService userService;

	@Autowired
	FinancingService financingService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam Long userId, @RequestParam String name, @RequestParam String location,
			@RequestParam Integer profession, @RequestParam String purpose, @RequestParam String amount,
			@RequestParam Integer financingType, @RequestParam String description, @RequestParam String advantage,
			@RequestParam String companyName, @RequestParam String contactUser, @RequestParam String contact) {
		try {
			BaseUserEntity user = userService.findOneBase(userId);
			FinancingEntity financing = new FinancingEntity(user, name, location, profession, purpose, amount,
					financingType, description, advantage, companyName, contactUser, contact);
			financingService.save(financing);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long financingId, @RequestParam String name, @RequestParam String location,
			@RequestParam Integer profession, @RequestParam String purpose, @RequestParam String amount,
			@RequestParam Integer financingType, @RequestParam String description, @RequestParam String advantage,
			@RequestParam String companyName, @RequestParam String contactUser, @RequestParam String contact) {
		try {
			FinancingEntity financing = financingService.findOne(financingId);
			financingService.update(financing, name, location, profession, purpose, amount, financingType, description,
					advantage, companyName, contactUser, contact);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String financingIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(financingIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			financingService.delete(list);
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
	public Output detail(@RequestParam Long financingId) {
		try {
			FinancingEntity financing = financingService.findOne(financingId);
			return new Output(financing, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public Output search(@RequestParam String searchStr, @RequestParam int page, @RequestParam int size) {
		try {
			Page<FinancingEntity> retPage = financingService.search(searchStr, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/filter", method = RequestMethod.POST)
	public Output filter(@RequestParam String profession, @RequestParam String financingType, @RequestParam int page,
			@RequestParam int size) {
		try {
			Page<FinancingEntity> retPage = financingService.filter(profession, financingType, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<FinancingEntity> list = financingService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPaging", method = RequestMethod.POST)
	public Output listPaging(@RequestParam int page, @RequestParam int size) {
		try {
			Page<FinancingEntity> retPage = financingService.list(page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByUserId", method = RequestMethod.POST)
	public OutputList listByUserId(@RequestParam Long userId) {
		try {
			List<FinancingEntity> list = financingService.listByUserId(userId);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByUserIdPaging", method = RequestMethod.POST)
	public Output listByUserIdPaging(@RequestParam Long userId, @RequestParam int page, @RequestParam int size) {
		try {
			Page<FinancingEntity> retPage = financingService.listByUserId(userId, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}