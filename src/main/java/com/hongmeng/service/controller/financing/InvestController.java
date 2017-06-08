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
import com.hongmeng.service.entity.common.CompanyEntity;
import com.hongmeng.service.entity.financing.InvestEntity;
import com.hongmeng.service.service.common.CompanyService;
import com.hongmeng.service.service.financing.InvestService;

@RestController
@RequestMapping("financing/invest")
public class InvestController {

	static Logger log = LoggerFactory.getLogger(InvestController.class);

	@Autowired
	InvestService investService;

	@Autowired
	CompanyService companyService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam Long companyId, @RequestParam String name, @RequestParam Integer investType,
			@RequestParam Integer fundType, @RequestParam String location,
			@RequestParam("profession") String[] profession, @RequestParam("investArea") String[] investArea,
			@RequestParam String amount, @RequestParam String description, @RequestParam String remark) {
		try {
			CompanyEntity company = companyService.findOne(companyId);

			InvestEntity invest = new InvestEntity(company, name, investType, fundType, location,
					String.join(",", profession), String.join(",", investArea), amount, description, remark);
			investService.save(invest);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long investId, @RequestParam String name, @RequestParam Integer investType,
			@RequestParam Integer fundType, @RequestParam String location,
			@RequestParam("profession") String[] profession, @RequestParam("investArea") String[] investArea,
			@RequestParam String amount, @RequestParam String description, @RequestParam String remark) {
		try {
			InvestEntity invest = investService.findOne(investId);
			investService.update(invest, name, investType, fundType, location, String.join(",", profession),
					String.join(",", investArea), amount, description, remark);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String investIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(investIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			investService.delete(list);
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
	public Output detail(@RequestParam Long investId) {
		try {
			InvestEntity invest = investService.findOne(investId);
			return new Output(invest, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public Output search(@RequestParam String searchStr, @RequestParam int page, @RequestParam int size) {
		try {
			Page<InvestEntity> retPage = investService.search(searchStr, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/filter", method = RequestMethod.POST)
	public Output filter(@RequestParam String investType, @RequestParam String fundType, @RequestParam int page,
			@RequestParam int size) {
		try {
			Page<InvestEntity> retPage = investService.filter(investType, fundType, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<InvestEntity> list = investService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPaging", method = RequestMethod.POST)
	public Output listPaging(@RequestParam int page, @RequestParam int size) {
		try {
			Page<InvestEntity> retPage = investService.list(page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByCompanyId", method = RequestMethod.POST)
	public OutputList listByCompanyId(@RequestParam Long companyId) {
		try {
			List<InvestEntity> list = investService.listByCompanyId(companyId);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByCompanyIdPaging", method = RequestMethod.POST)
	public Output listByCompanyIdPaging(@RequestParam Long companyId, @RequestParam int page, @RequestParam int size) {
		try {
			Page<InvestEntity> retPage = investService.listByCompanyId(companyId, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}