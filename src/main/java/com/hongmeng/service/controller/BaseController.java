package com.hongmeng.service.controller;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hongmeng.service.common.utils.CiphersUtils;
import com.hongmeng.service.common.utils.CurrentUserUtils;
import com.hongmeng.service.entity.authority.BaseUserEntity;
import com.hongmeng.service.entity.authority.RoleEntity;
import com.hongmeng.service.service.authority.RoleService;
import com.hongmeng.service.service.authority.UserService;

@Controller
public class BaseController {

	static Logger log = LoggerFactory.getLogger(BaseController.class);
	
	@Autowired
	UserService userService;
	
	@Autowired
	RoleService roleService;
	
	@Value("${customize.initPassword}")
	String initPassword;
	
	/**
	 * top
	 */
	@RequestMapping(value = { "/", "/index" })
	String index(Long uid, String uname, String utel, String platform) {
		if (platform != null) {
			BaseUserEntity user = null;
			
			if (platform.equals("gc")) {
				user = userService.findByGcUsername(uname);
				
				if (user == null) {
					RoleEntity role = roleService.findByName("一般用户");
					String username = uname + "@gc";
					user = new BaseUserEntity(username, CiphersUtils.getInstance().string2MD5(initPassword), role, utel);
					user.setCreateTime(new Date());
					user.setGcUsername(uname);
					userService.saveBase(user);
				}
				
				CurrentUserUtils.getInstance().serUser(user);
			}
			
			if (platform.equals("nc")) {
				user = userService.findByNcUsername(uname);
				
				if (user == null) {
					RoleEntity role = roleService.findByName("一般用户");
					String username = uname + "@nc";
					user = new BaseUserEntity(username, CiphersUtils.getInstance().string2MD5(initPassword), role, utel);
					user.setCreateTime(new Date());
					user.setNcUsername(uname);
					userService.saveBase(user);
				}
			}
		}
		
		return "/pages/recommend/recommend";
	}

	@RequestMapping("/login")
	String login() {
		return "login";
	}
	
	@RequestMapping(value = "/init")
	String init() {
		return "init";
	}
	
	@RequestMapping("/register")
	String register() {
		return "register";
	}
	
	@RequestMapping("/manager")
	String manager() {
		return "manager";
	}
	
	@RequestMapping("/in")
	String suppliersIn() {
		return "/pages/suppliersIn";
	}
	
	/**
	 * talent
	 */
	@RequestMapping("/recruitment")
	String recruitment() {
		return "/pages/talent/recruitment";
	}

	@RequestMapping("/job")
	String job() {
		return "/pages/talent/job";
	}
	
	@RequestMapping("/recruitmentinfo")
	String recruitmentinfo() {
		return "/pages/talent/recruitmentinfo";
	}
	
	@RequestMapping("/jobinfo")
	String jobinfo() {
		return "/pages/talent/jobinfo";
	}
	
	@RequestMapping("/talentCompany")
	String enterpriseinfo() {
		return "/pages/talent/enterpriseinfo";
	}
	
	@RequestMapping("/addRecruitment")
	String addRecruitment() {
		return "/pages/talent/add_recruitment";
	}
	
	@RequestMapping("/addJob")
	String addJob() {
		return "/pages/talent/add_job";
	}
	
	@RequestMapping("/talentunit")
	String talentServ() {
		return "/pages/talent/talentunit";
	}
	
	
	/**
	 * logistics
	 */
	@RequestMapping("/supply") 
	String supply() {
		return "/pages/logistics/supply";
	}
	
	@RequestMapping("/addSupply")
	String addSupply() {
		return "/pages/logistics/add_supply";
	}
	
	@RequestMapping("/supplyinfo")
	String sourceinfo() {
		return "/pages/logistics/supplyinfo";
	}
	
	@RequestMapping("/line")
	String line() {
		return "/pages/logistics/line";
	}
	
	@RequestMapping("/network")
	String network() {
		return "/pages/logistics/network";
	}
	
	@RequestMapping("logisticsDynamic")
	String logisDynamic() {
		return "/pages/logistics/dynamic";
	}
	
	@RequestMapping("/logisticsCompany")
	String logisticsCompany() {
		return "/pages/logistics/enterpriseinfo";
	}
	
	@RequestMapping("/dynamicinfo")
	String dynamicinfo() {
		return "/pages/dynamicinfo";
	}
	
	/**
	 * manufacture
	 */
	@RequestMapping("/bulletin")
	String bulletin() {
		return "/pages/manufacture/bulletin";
	}
	
	@RequestMapping("/purchase")
	String purchase() {
		return "/pages/manufacture/purchase";
	}
	
	@RequestMapping("/product")
	String product() {
		return "/pages/manufacture/product";
	}
	
	@RequestMapping("/productList")
	String productList() {
		return "/pages/manufacture/productList";
	}
	
	@RequestMapping("/productinfo")
	String productinfo() {
		return "/pages/manufacture/productinfo";
	}
	
	@RequestMapping("/purchaseinfo")
	String purchaseinfo() {
		return "/pages/manufacture/purchaseinfo";
	}
	
	@RequestMapping("/offerinfo")
	String offerinfo() {
		return "/pages/manufacture/offerinfo";
	}
	
	@RequestMapping("/manufacCompany")
	String manufacComp() {
		return "/pages/manufacture/enterpriseinfo";
	}
	
	@RequestMapping("/successcase")
	String successcase() {
		return "/pages/manufacture/successcase";
	}
	
	
	/**
	 * finance
	 */
	@RequestMapping("/financing")
	String financing() {
		return "/pages/financing/financing";
	}
	
	@RequestMapping("/financinginfo")
	String financinginfo() {
		return "/pages/financing/financinginfo";
	}
	
	@RequestMapping("/invest")
	String invest() {
		return "/pages/financing/invest";
	}
	
	@RequestMapping("/investinfo")
	String investinfo() {
		return "/pages/financing/investinfo";
	}
	
	@RequestMapping("/policy")
	String policy() {
		return "/pages/financing/policy";
	}
	
	@RequestMapping("/financingUnit")
	String financingUnit() {
		return "/pages/financing/financingUnit";
	}
	
	@RequestMapping("/financingCompany")
	String financingComp() {
		return "/pages/financing/enterpriseinfo";
	}
	
	/**
	 * recommend
	 */
	@RequestMapping("/recommend")
	String recommend() {
		return "/pages/recommend/recommend";
	}
	
	@RequestMapping("/recommendinfo")
	String recommendinfo() {
		return "/pages/recommend/recommendinfo";
	}
	
	@RequestMapping("/recommProductInfo")
	String recommProductInfo() {
		return "/pages/recommend/productinfo";
	}
	
	/**
	 * 找回密码
	 */
	@RequestMapping("/password_find")
	String passwordFind() {
		return "password_find";
	}
}