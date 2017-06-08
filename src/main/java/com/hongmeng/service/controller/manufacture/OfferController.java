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
import org.springframework.web.multipart.MultipartFile;

import com.hongmeng.service.common.ReturnStatus;
import com.hongmeng.service.entity.Output;
import com.hongmeng.service.entity.OutputList;
import com.hongmeng.service.entity.common.CompanyEntity;
import com.hongmeng.service.entity.manufacture.OfferEntity;
import com.hongmeng.service.service.common.CompanyService;
import com.hongmeng.service.service.common.UeditorService;
import com.hongmeng.service.service.manufacture.OfferService;

@RestController
@RequestMapping("manufacture/offer")
public class OfferController {

	static Logger log = LoggerFactory.getLogger(OfferController.class);

	@Autowired
	OfferService offerService;

	@Autowired
	CompanyService companyService;

	@Autowired
	UeditorService ueditorService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam Long companyId, @RequestParam String name,
			@RequestParam(name = "uploadImage") MultipartFile uploadImage, @RequestParam Double price,
			@RequestParam String origin, @RequestParam String location, @RequestParam Integer lowest,
			@RequestParam Integer total, @RequestParam String description,
			@RequestParam(required = false) Date validDate) {
		try {
			CompanyEntity company = companyService.findOne(companyId);
			String imagePath = "";
			if (uploadImage != null && !uploadImage.isEmpty()) {
				imagePath = ueditorService.saveImage(uploadImage);
			}

			OfferEntity offer = new OfferEntity(company, name, imagePath, price, origin, location, lowest, total,
					description, validDate);
			offerService.save(offer);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long offerId, @RequestParam String name,
			@RequestParam(name = "uploadImage") MultipartFile uploadImage, @RequestParam Double price,
			@RequestParam String origin, @RequestParam String location, @RequestParam Integer lowest,
			@RequestParam Integer total, @RequestParam String description,
			@RequestParam(required = false) Date validDate) {
		try {
			OfferEntity offer = offerService.findOne(offerId);
			
			String imagePath = offer.getImagePath();
			if (uploadImage!= null && !uploadImage.isEmpty()) {
				imagePath = ueditorService.saveImage(uploadImage);
			}
			
			offerService.update(offer, name, imagePath, price, origin, location, lowest, total, description);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String offerIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(offerIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			offerService.delete(list);
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
	public Output detail(@RequestParam Long offerId) {
		try {
			OfferEntity offer = offerService.findOne(offerId);
			return new Output(offer, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<OfferEntity> list = offerService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listPaging", method = RequestMethod.POST)
	public Output listPaging(@RequestParam int page, @RequestParam int size) {
		try {
			Page<OfferEntity> retPage = offerService.list(page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByCompanyId", method = RequestMethod.POST)
	public OutputList listByCompanyId(@RequestParam Long companyId) {
		try {
			List<OfferEntity> list = offerService.listByCompanyId(companyId);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByCompanyIdPaging", method = RequestMethod.POST)
	public Output listByCompanyIdPaging(@RequestParam Long companyId, @RequestParam int page, @RequestParam int size) {
		try {
			Page<OfferEntity> retPage = offerService.listByCompanyId(companyId, page, size);
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}