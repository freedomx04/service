package com.hongmeng.service.controller.talent;

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
import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.common.CompanyEntity;
import com.hongmeng.service.entity.talent.RecruitmentEntity;
import com.hongmeng.service.service.authority.AreaService;
import com.hongmeng.service.service.common.CompanyService;
import com.hongmeng.service.service.talent.RecruitmentService;

@RestController
@RequestMapping("talent/recruitment")
public class RecruitmentController {

	static Logger log = LoggerFactory.getLogger(RecruitmentController.class);

	@Autowired
	RecruitmentService recruitmentService;

	@Autowired
	AreaService areaService;

	@Autowired
	CompanyService companyService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam Long companyId, @RequestParam Long areaId, @RequestParam String position,
			@RequestParam Integer profession, @RequestParam Integer salary, @RequestParam Integer workingYears,
			@RequestParam Integer education, @RequestParam Integer number, @RequestParam String responsibilities,
			@RequestParam String requirements, @RequestParam String address, @RequestParam String workingHours,
			@RequestParam String contact) {
		try {
			CompanyEntity company = companyService.findOne(companyId);
			AreaEntity area = areaService.findOne(areaId);

			RecruitmentEntity recruitment = new RecruitmentEntity(company, area, position, profession, salary,
					workingYears, education, number, responsibilities, requirements, address, workingHours, contact);
			recruitmentService.save(recruitment);

			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long recruitmentId, @RequestParam Long areaId, @RequestParam String position,
			@RequestParam Integer profession, @RequestParam Integer salary, @RequestParam Integer workingYears,
			@RequestParam Integer education, @RequestParam Integer number, @RequestParam String responsibilities,
			@RequestParam String requirements, @RequestParam String address, @RequestParam String workingHours,
			@RequestParam String contact) {
		try {
			RecruitmentEntity recruitment = recruitmentService.findOne(recruitmentId);
			AreaEntity area = areaService.findOne(areaId);

			recruitmentService.update(recruitment, area, position, profession, salary, workingYears, education, number,
					responsibilities, requirements, address, workingHours, contact);

			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String recruitmentIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(recruitmentIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			recruitmentService.delete(list);
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
	public Output detail(@RequestParam Long recruitmentId) {
		try {
			RecruitmentEntity recruitment = recruitmentService.findOne(recruitmentId);
			return new Output(recruitment, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/refresh", method = RequestMethod.POST)
	public Output refresh(@RequestParam Long recruitmentId) {
		try {
			RecruitmentEntity recruitment = recruitmentService.findOne(recruitmentId);
			recruitmentService.update(recruitment);
			return new Output(recruitment, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<RecruitmentEntity> list = recruitmentService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPaging", method = RequestMethod.POST)
	public Output listPaging(@RequestParam int page, @RequestParam int size) {
		try {
			Page<RecruitmentEntity> retPage = recruitmentService.listPage(page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByCompanyId", method = RequestMethod.POST)
	public OutputList listByCompanyId(@RequestParam Long companyId) {
		try {
			List<RecruitmentEntity> list = recruitmentService.listByCompanyId(companyId);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByCompanyIdPaging", method = RequestMethod.POST)
	public Output listByCompanyIdPaging(@RequestParam Long companyId, @RequestParam int page, @RequestParam int size) {
		try {
			Page<RecruitmentEntity> retPage = recruitmentService.listByCompanyId(companyId, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public Output search(@RequestParam String searchStr, @RequestParam int page, @RequestParam int size) {
		try {
			Page<RecruitmentEntity> ret = recruitmentService.search(searchStr, page, size);
			return new Output(ret, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/filter", method = RequestMethod.POST)
	public Output filter(@RequestParam String area, @RequestParam String profession, @RequestParam String education,
			@RequestParam String workingYears, @RequestParam String salary, @RequestParam int page,
			@RequestParam int size) {
		try {
			Page<RecruitmentEntity> retPage = recruitmentService.filter(area, profession, education, workingYears,
					salary, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}