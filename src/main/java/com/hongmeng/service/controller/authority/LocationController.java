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
import com.hongmeng.service.entity.authority.LocationEntity;
import com.hongmeng.service.service.authority.LocationService;

@RestController
@RequestMapping("location")
public class LocationController {
	
	static Logger log = LoggerFactory.getLogger(LocationEntity.class);
	
	@Autowired
	LocationService locationService;
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam(required = false) Long pid, @RequestParam Integer level, @RequestParam String name) {
		try {
			LocationEntity location = new LocationEntity(pid, level, name);
			locationService.save(location);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long locationId, @RequestParam(required = false) Long pid, @RequestParam Integer level, @RequestParam String name) {
		try {
			LocationEntity location = locationService.findOne(locationId);
			locationService.update(location, pid, level, name);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String locationIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr: StringUtils.split(locationIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			locationService.delete(list);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			if(e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Output(null, ReturnStatus.CONSTRAINT.status(), e.getMessage());
			}
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/listByLevel", method = RequestMethod.POST)
	public OutputList listByLevel(@RequestParam Integer level) {
		try {
			List<LocationEntity> list = locationService.listByLevel(level);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/listByPid", method = RequestMethod.POST)
	public OutputList listByPid(@RequestParam Long pid) {
		try {
			List<LocationEntity> list = locationService.listByPid(pid);
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}
