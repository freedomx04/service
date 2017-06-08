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
import org.springframework.web.multipart.MultipartFile;

import com.hongmeng.service.common.ReturnStatus;
import com.hongmeng.service.entity.Output;
import com.hongmeng.service.entity.OutputList;
import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.authority.BaseUserEntity;
import com.hongmeng.service.entity.talent.JobEntity;
import com.hongmeng.service.service.authority.AreaService;
import com.hongmeng.service.service.authority.UserService;
import com.hongmeng.service.service.common.UeditorService;
import com.hongmeng.service.service.talent.JobService;

@RestController
@RequestMapping("talent/job")
public class JobController {

	static Logger log = LoggerFactory.getLogger(JobController.class);

	@Autowired
	JobService jobService;

	@Autowired
	AreaService areaService;

	@Autowired
	UserService userService;

	@Autowired
	UeditorService ueditorService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam Long userId, @RequestParam String name, @RequestParam Integer sex,
			@RequestParam("uploadImage") MultipartFile uploadImage, @RequestParam Integer birthYear,
			@RequestParam Integer workingYears, @RequestParam Integer education, @RequestParam String contact,
			@RequestParam String intention, @RequestParam Integer profession, @RequestParam Long areaId,
			@RequestParam Integer salary, @RequestParam String introduction, @RequestParam String workExperience,
			@RequestParam String educationExperience) {
		try {
			BaseUserEntity user = userService.findOneBase(userId);
			AreaEntity area = areaService.findOne(areaId);
			String imagePath = "";
			if (uploadImage != null && !uploadImage.isEmpty()) {
				imagePath = ueditorService.saveImage(uploadImage);
			}

			JobEntity job = new JobEntity(user, area, name, sex, imagePath, birthYear, workingYears, education, contact,
					intention, profession, salary, introduction, workExperience, educationExperience);
			jobService.save(job);

			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long jobId, @RequestParam String name, @RequestParam Integer sex,
			@RequestParam("uploadImage") MultipartFile uploadImage, @RequestParam Integer birthYear,
			@RequestParam Integer workingYears, @RequestParam Integer education, @RequestParam String contact,
			@RequestParam String intention, @RequestParam Integer profession, @RequestParam Long areaId,
			@RequestParam Integer salary, @RequestParam String introduction, @RequestParam String workExperience,
			@RequestParam String educationExperience) {
		try {
			AreaEntity area = areaService.findOne(areaId);
			JobEntity job = jobService.findOne(jobId);
			String imagePath = job.getImagePath();
			if (uploadImage != null && !uploadImage.isEmpty()) {
				imagePath = ueditorService.saveImage(uploadImage);
			}

			jobService.update(job, area, name, sex, imagePath, birthYear, workingYears, education, contact, intention,
					profession, salary, introduction, workExperience, educationExperience);

			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String jobIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(jobIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			jobService.delete(list);
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
	public Output detail(@RequestParam Long jobId) {
		try {
			JobEntity job = jobService.findOne(jobId);
			return new Output(job, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/refresh", method = RequestMethod.POST)
	public Output refresh(@RequestParam Long jobId) {
		try {
			JobEntity job = jobService.findOne(jobId);
			jobService.update(job);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<JobEntity> list = jobService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPaging", method = RequestMethod.POST)
	public Output listPaging(@RequestParam int page, @RequestParam int size) {
		try {
			Page<JobEntity> retPage = jobService.listPage(page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByUserId", method = RequestMethod.POST)
	public OutputList listByUserId(@RequestParam Long userId) {
		try {
			List<JobEntity> list = jobService.listByUserId(userId);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPagingByUserId", method = RequestMethod.POST)
	public Output listPagingByUserId(@RequestParam Long userId, @RequestParam int page, @RequestParam int size) {
		try {
			Page<JobEntity> retPage = jobService.listByUserId(userId, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public Output search(@RequestParam String searchStr, @RequestParam int page, @RequestParam int size) {
		try {
			Page<JobEntity> ret = jobService.search(searchStr, page, size);
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
			Page<JobEntity> retPage = jobService.filter(area, profession, education, workingYears, salary, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}