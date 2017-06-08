package com.hongmeng.service.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hongmeng.service.common.ReturnStatus;
import com.hongmeng.service.common.utils.CiphersUtils;
import com.hongmeng.service.entity.Output;
import com.hongmeng.service.entity.authority.BaseUserEntity;
import com.hongmeng.service.entity.authority.RoleEntity;
import com.hongmeng.service.service.authority.RoleService;
import com.hongmeng.service.service.authority.UserService;

@RestController
@RequestMapping("init")
public class InitController {

	static Logger log = LoggerFactory.getLogger(InitController.class);

	@Autowired
	RoleService roleService;
	
	@Autowired
	UserService userService;

	@RequestMapping(value = "/role", method = RequestMethod.POST)
	public Output role() {
		try {
			// admin
			RoleEntity adminRole = roleService.findByName("管理员");
			if (adminRole == null) {
				adminRole = new RoleEntity("管理员", "管理员",
						"authority_user,authority_company,authority_role,authority_area,authority_visit,authority_bulletin,authority_policy,"
						+ "personal_personalInfo,personal_companyInfo,"
						+ "recommend_company,"
						+ "talent_job,talent_company,"
						+ "manufacture_purchase,manufacture_company,"
						+ "financing_financing,financing_company,"
						+ "logistics_supply,logistics_company");
				roleService.save(adminRole);
			}

			// user
			RoleEntity userRole = roleService.findByName("一般用户");
			if (userRole == null) {
				userRole = new RoleEntity("一般用户", "一般用户", "personal_personalInfo,personal_companyInfo,"
						+ "recommend_company,"
						+ "talent_job,talent_company,"
						+ "manufacture_purchase,manufacture_company,"
						+ "financing_financing,financing_company,"
						+ "logistics_supply,logistics_company");
				roleService.save(userRole);
			}

			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/admin", method = RequestMethod.POST)
	public Output admin() {
		try {
			BaseUserEntity user = userService.findByUsernameBase("admin");
			if (user == null) {
				RoleEntity role = roleService.findByName("管理员");
				user = new BaseUserEntity("admin", CiphersUtils.getInstance().string2MD5("admin123456"), role, "");
				userService.saveBase(user);
			}
			
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}