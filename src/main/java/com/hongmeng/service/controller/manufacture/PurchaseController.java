package com.hongmeng.service.controller.manufacture;

import java.util.Date;
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
import com.hongmeng.service.entity.manufacture.PurchaseEntity;
import com.hongmeng.service.service.authority.UserService;
import com.hongmeng.service.service.manufacture.PurchaseService;

@RestController
@RequestMapping("manufacture/purchase")
public class PurchaseController {

	static Logger log = LoggerFactory.getLogger(PurchaseController.class);

	@Autowired
	PurchaseService purchaseService;

	@Autowired
	UserService userService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam Long userId, @RequestParam String name, @RequestParam String description,
			@RequestParam(required = false) Date validDate, @RequestParam String num, @RequestParam String location,
			@RequestParam String contactUser, @RequestParam String contact) {
		try {
			BaseUserEntity user = userService.findOneBase(userId);
			PurchaseEntity purchase = new PurchaseEntity(user, name, description, validDate, num, location, contactUser,
					contact);
			purchaseService.save(purchase);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long purchaseId, @RequestParam String name, @RequestParam String description,
			@RequestParam(required = false) Date validDate, @RequestParam String num, @RequestParam String location,
			@RequestParam String contactUser, @RequestParam String contact) {
		try {
			PurchaseEntity purchase = purchaseService.findOne(purchaseId);
			purchaseService.update(purchase, name, description, validDate, num, location, contactUser, contact);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String purchaseIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(purchaseIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			purchaseService.delete(list);
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
	public Output detail(@RequestParam Long purchaseId) {
		try {
			PurchaseEntity purchase = purchaseService.findOne(purchaseId);
			return new Output(purchase, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<PurchaseEntity> list = purchaseService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPaging", method = RequestMethod.POST)
	public Output listPaging(@RequestParam int page, @RequestParam int size) {
		try {
			Page<PurchaseEntity> retPage = purchaseService.list(page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByUserId", method = RequestMethod.POST)
	public OutputList listByUserId(@RequestParam Long userId) {
		try {
			List<PurchaseEntity> list = purchaseService.listByUserId(userId);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByUserIdPaging", method = RequestMethod.POST)
	public Output listByUserIdPaging(@RequestParam Long userId, @RequestParam int page, @RequestParam int size) {
		try {
			Page<PurchaseEntity> retPage = purchaseService.listByUserId(userId, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}