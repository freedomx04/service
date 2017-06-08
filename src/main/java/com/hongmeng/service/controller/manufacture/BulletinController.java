package com.hongmeng.service.controller.manufacture;

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
import com.hongmeng.service.entity.manufacture.BulletinEntity;
import com.hongmeng.service.service.common.UeditorService;
import com.hongmeng.service.service.manufacture.BulletinService;

@RestController
@RequestMapping("manufacture/bulletin")
public class BulletinController {

	static Logger log = LoggerFactory.getLogger(BulletinController.class);

	@Autowired
	BulletinService bulletinService;

	@Autowired
	UeditorService ueditorService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam("type") Integer type,
			@RequestParam(name = "uploadImage", required = false) MultipartFile uploadImage,
			@RequestParam("title") String title, @RequestParam("source") String source,
			@RequestParam("content") String content) {
		try {
			String imagePath = "";
			if (uploadImage!= null && !uploadImage.isEmpty()) {
				imagePath = ueditorService.saveImage(uploadImage);
			}
			
			String linkPath = ueditorService.save(content);
			BulletinEntity bulletin = new BulletinEntity(type, imagePath, title, source, linkPath);
			bulletinService.save(bulletin);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam("bulletinId") Long bulletinId,
			@RequestParam(name = "uploadImage", required = false) MultipartFile uploadImage,
			@RequestParam("title") String title, @RequestParam("source") String source,
			@RequestParam("content") String content) {
		try {
			BulletinEntity bulletin = bulletinService.findOne(bulletinId);
			
			String imagePath = bulletin.getImagePath();
			if (uploadImage!= null && !uploadImage.isEmpty()) {
				imagePath = ueditorService.saveImage(uploadImage);
			}
			
			String linkPath = ueditorService.update(bulletin.getLinkPath(), content);
			bulletinService.update(bulletin, imagePath, title, source, linkPath);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String bulletinIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(bulletinIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			bulletinService.delete(list);
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
	public Output detail(@RequestParam Long bulletinId) {
		try {
			BulletinEntity bulletin = bulletinService.findOne(bulletinId);
			String content = ueditorService.getContent(bulletin.getLinkPath());
			bulletin.setContent(content);
			return new Output(bulletin, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByType", method = RequestMethod.POST)
	public OutputList listByType(@RequestParam Integer type) {
		try {
			List<BulletinEntity> list = bulletinService.listByType(type);
			
			for (BulletinEntity bulletin: list) {
				String content = ueditorService.getContent(bulletin.getLinkPath());
				bulletin.setContent(content);
			}
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/listByTypePaging", method = RequestMethod.POST)
	public Output listByTypePaging(@RequestParam Integer type, @RequestParam int page, @RequestParam int size) {
		try {
			Page<BulletinEntity> retPage = bulletinService.listByType(type, page, size);
			
			List<BulletinEntity> list = retPage.getContent();
			for (BulletinEntity bulletin: list) {
				String content = ueditorService.getContent(bulletin.getLinkPath());
				bulletin.setContent(content);
			}
			return new Output(retPage, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}