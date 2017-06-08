package com.hongmeng.service.controller.common;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.hongmeng.service.entity.common.BaseCompanyEntity.CompanyStatus;
import com.hongmeng.service.entity.common.BaseCompanyEntity.ServiceType;
import com.hongmeng.service.entity.common.CompanyEntity;
import com.hongmeng.service.service.authority.AreaService;
import com.hongmeng.service.service.authority.UserService;
import com.hongmeng.service.service.common.CompanyService;
import com.hongmeng.service.service.common.UeditorService;

@RestController
@RequestMapping("company")
public class CompanyController {

	static Logger log = LoggerFactory.getLogger(CompanyController.class);

	@Autowired
	CompanyService companyService;

	@Autowired
	UserService userService;

	@Autowired
	AreaService areaService;

	@Autowired
	UeditorService ueditorService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam Long userId, @RequestParam Long areaId, @RequestParam String name,
			@RequestParam("uploadImage") MultipartFile uploadImage, @RequestParam Integer profession,
			@RequestParam("property") Integer property, @RequestParam Integer scale,
			@RequestParam("address") String address, @RequestParam String phone,
			@RequestParam(required = false) String fax, @RequestParam String contactUser, @RequestParam String contact,
			@RequestParam(required = false) String website, @RequestParam(required = false) String introduction) {
		try {
			BaseUserEntity user = userService.findOneBase(userId);
			AreaEntity area = areaService.findOne(areaId);

			String imagePath = "";
			if (uploadImage != null && !uploadImage.isEmpty()) {
				imagePath = ueditorService.saveImage(uploadImage);
			}

			CompanyEntity company = new CompanyEntity(user, area, name, imagePath, profession, property, scale, address,
					phone, fax, contactUser, contact, website, introduction);
			company.setStatus(CompanyStatus.STATUS_NEW);
			company = companyService.save(company);
			return new Output(company, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long companyId, @RequestParam Long areaId,
			@RequestParam("uploadImage") MultipartFile uploadImage, @RequestParam Integer scale,
			@RequestParam String address, @RequestParam String phone, @RequestParam String fax,
			@RequestParam String contactUser, @RequestParam String contact, @RequestParam String website,
			@RequestParam String introduction) {
		try {
			CompanyEntity company = companyService.findOne(companyId);
			AreaEntity area = areaService.findOne(areaId);

			String imagePath = company.getImagePath();
			if (uploadImage != null && !uploadImage.isEmpty()) {
				imagePath = ueditorService.saveImage(uploadImage);
			}

			companyService.update(company, area, imagePath, scale, address, phone, fax, contactUser, contact, website,
					introduction);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public Output detail(@RequestParam Long companyId) {
		try {
			CompanyEntity company = companyService.findOne(companyId);
			return new Output(company, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<CompanyEntity> list = companyService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPass", method = RequestMethod.POST)
	public OutputList listPass() {
		try {
			List<CompanyEntity> list = companyService.listPass();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listCertification", method = RequestMethod.POST)
	public OutputList listCertification() {
		try {
			List<CompanyEntity> list = companyService.listCertification();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/uploadData", method = RequestMethod.POST)
	public Output uploadData(@RequestParam Long companyId, @RequestParam String license,
			@RequestParam("attachment") MultipartFile attachment,
			@RequestParam(name = "protocol", required = false) MultipartFile protocol) {
		try {
			CompanyEntity company = companyService.findOne(companyId);
			String attachmentPath = "";
			if (attachment != null && !attachment.isEmpty()) {
				attachmentPath = ueditorService.saveImage(attachment);
			}

			String protocolPath = "";
			if (protocol != null && !protocol.isEmpty()) {
				protocolPath = ueditorService.saveImage(protocol);
			}

			companyService.update(company, license, attachmentPath, protocolPath, CompanyStatus.STATUS_BEING_CERTIFIED);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/certification", method = RequestMethod.POST)
	public Output certification(@RequestParam Long companyId, @RequestParam Integer status) {
		try {
			CompanyEntity company = companyService.findOne(companyId);
			company.setStatus(status);

			companyService.update(company, status);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/apply", method = RequestMethod.POST)
	public Output apply(@RequestParam Long companyId, @RequestParam Integer type) {
		try {
			CompanyEntity company = companyService.findOne(companyId);
			switch (type) {
			case ServiceType.SERVICE_RECOMMEND:
				company.setStatusRecommend(CompanyStatus.STATUS_PASS);
				break;
			case ServiceType.SERVICE_MANUFACTURE:
				company.setStatusManufacture(CompanyStatus.STATUS_PASS);
				break;
			case ServiceType.SERVICE_TALENT:
				company.setStatusTalent(CompanyStatus.STATUS_PASS);
				break;
			case ServiceType.SERVICE_FINANCING:
				company.setStatusFinancing(CompanyStatus.STATUS_PASS);
				break;
			case ServiceType.SERVICE_LOGISTICS:
				company.setStatusLogistics(CompanyStatus.STATUS_PASS);
				break;
			default:
				break;
			}

			companyService.update(company);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/findByUserId", method = RequestMethod.POST)
	public Output findByUserId(@RequestParam Long userId) {
		try {
			CompanyEntity company = companyService.findByUserId(userId);
			return new Output(company, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}