package com.hongmeng.service.controller.logistics;

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
import com.hongmeng.service.entity.logistics.SupplyEntity;
import com.hongmeng.service.service.authority.UserService;
import com.hongmeng.service.service.logistics.SupplyService;

@RestController
@RequestMapping("logistics/supply")
public class SupplyController {

	static Logger log = LoggerFactory.getLogger(SupplyController.class);

	@Autowired
	SupplyService supplyService;

	@Autowired
	UserService userService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam Long userId, @RequestParam String origin, @RequestParam String destination,
			@RequestParam String description, @RequestParam Integer supplyType, @RequestParam Date validDate,
			@RequestParam String remark, @RequestParam String contactUser, @RequestParam String contact,
			@RequestParam String address) {
		try {
			BaseUserEntity user = userService.findOneBase(userId);
			SupplyEntity supply = new SupplyEntity(user, origin, destination, description, supplyType, validDate,
					remark, contactUser, contact, address);
			supplyService.save(supply);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long supplyId, @RequestParam String origin, @RequestParam String destination,
			@RequestParam String description, @RequestParam Integer supplyType, @RequestParam Date validDate,
			@RequestParam String remark, @RequestParam String contactUser, @RequestParam String contact,
			@RequestParam String address) {
		try {
			SupplyEntity supply = supplyService.findOne(supplyId);
			supplyService.update(supply, origin, destination, description, supplyType, validDate, remark, contactUser,
					contact, address);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public Output detail(@RequestParam Long supplyId) {
		try {
			SupplyEntity supply = supplyService.findOne(supplyId);
			return new Output(supply, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String supplyIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(supplyIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			supplyService.delete(list);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Output(null, ReturnStatus.CONSTRAINT.status(), e.getMessage());
			}
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public Output search(@RequestParam String origin, @RequestParam String destination, @RequestParam int page,
			@RequestParam int size) {
		try {
			Page<SupplyEntity> retPage = supplyService.search(origin, destination, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<SupplyEntity> list = supplyService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPaging", method = RequestMethod.POST)
	public Output listPaging(@RequestParam int page, @RequestParam int size) {
		try {
			Page<SupplyEntity> retPage = supplyService.listPaging(page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByUserId", method = RequestMethod.POST)
	public OutputList listByUserId(@RequestParam Long userId) {
		try {
			List<SupplyEntity> list = supplyService.listByUserId(userId);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByUserIdPaging", method = RequestMethod.POST)
	public Output listPaging(@RequestParam Long userId, @RequestParam int page, @RequestParam int size) {
		try {
			Page<SupplyEntity> retPage = supplyService.listByUserIdPaging(userId, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
}
