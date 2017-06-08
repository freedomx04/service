package com.hongmeng.service.controller.authority;

import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hongmeng.service.common.ReturnStatus;
import com.hongmeng.service.entity.Output;
import com.hongmeng.service.entity.OutputList;
import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.service.authority.AreaService;

@RestController
@RequestMapping("area")
public class AreaController {
	
	static Logger log = LoggerFactory.getLogger(AreaController.class);
	
	@Autowired
	AreaService areaService;
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam String name, @RequestParam String description) {
		try {
			AreaEntity area = areaService.findByName(name);
			if (area != null) {
				return new Output(null, ReturnStatus.EXISTED.status(), ReturnStatus.EXISTED.msg());
			}
			
			area = new AreaEntity(name, description);
			areaService.save(area);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long areaId, @RequestParam String name, @RequestParam String description) {
		try {
			AreaEntity area = areaService.findOne(areaId);
			areaService.update(area, name, description);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String areaIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr: StringUtils.split(areaIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			areaService.delete(list);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			if(e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Output(null, ReturnStatus.CONSTRAINT.status(), e.getMessage());
			}
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<AreaEntity> list = areaService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public Output detail(@RequestParam Long areaId) {
		try {
			AreaEntity area = areaService.findOne(areaId);
			return new Output(area, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
}