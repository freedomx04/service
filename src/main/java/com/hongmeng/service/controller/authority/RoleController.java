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
import com.hongmeng.service.entity.authority.RoleEntity;
import com.hongmeng.service.service.authority.RoleService;

@RestController
@RequestMapping("role")
public class RoleController {
	
	static Logger log = LoggerFactory.getLogger(RoleController.class);
	
	@Autowired
	RoleService roleService;
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam String name, @RequestParam String description, @RequestParam String resource) {
		try {
			RoleEntity role = roleService.findByName(name);
			if (role != null) {
				return new Output(null, ReturnStatus.EXISTED.status(), ReturnStatus.EXISTED.msg());
			}
			
			role = new RoleEntity(name, description, resource);
			roleService.save(role);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long roleId, @RequestParam String name, @RequestParam String description, @RequestParam String resource) {
		try {
			RoleEntity role = roleService.findOne(roleId);
			roleService.update(role, name, description, resource);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String roleIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr: StringUtils.split(roleIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			roleService.delete(list);
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
			List<RoleEntity> list = roleService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public Output detail(@RequestParam Long roleId) {
		try {
			RoleEntity role = roleService.findOne(roleId);
			return new Output(role, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}