package com.hongmeng.service.controller.authority;

import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hongmeng.service.common.ReturnStatus;
import com.hongmeng.service.common.utils.CiphersUtils;
import com.hongmeng.service.common.utils.CurrentUserUtils;
import com.hongmeng.service.entity.Output;
import com.hongmeng.service.entity.OutputList;
import com.hongmeng.service.entity.authority.BaseUserEntity;
import com.hongmeng.service.entity.authority.RoleEntity;
import com.hongmeng.service.entity.authority.UserEntity;
import com.hongmeng.service.entity.authority.UserEntity.UserStatus;
import com.hongmeng.service.service.authority.RoleService;
import com.hongmeng.service.service.authority.UserService;

@RestController
@RequestMapping("user")
public class UserController {

	static Logger log = LoggerFactory.getLogger(UserController.class);

	@Autowired
	UserService userService;

	@Autowired
	RoleService roleService;

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public Output login(@RequestParam String username, @RequestParam String password) {
		try {
			BaseUserEntity user = userService.findByUsernameBase(username);

			if (user == null) { // 用户不存在
				return new Output(null, ReturnStatus.NULL.status(), ReturnStatus.NULL.msg());
			}

			if (user.getStatus() == UserStatus.STATUS_NO_VALID) { // 用户被禁用
				return new Output(null, ReturnStatus.USER_STATUS_NO_VALID.status(),
						ReturnStatus.USER_STATUS_NO_VALID.msg());
			}

			if (!StringUtils.equals(CiphersUtils.getInstance().MD5Password(password), user.getPassword())) { // 密码错误
				return new Output(null, ReturnStatus.USER_PWD_ERROR.status(), ReturnStatus.USER_PWD_ERROR.msg());
			}

			CurrentUserUtils.getInstance().serUser(user);
			return new Output(user, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public Output register(@RequestParam String username, @RequestParam String password, @RequestParam String telephone) {
		try {
			BaseUserEntity user = userService.findByUsernameBase(username);
			if (user != null) {
				return new Output(null, ReturnStatus.USER_EXISTED.status(), ReturnStatus.USER_EXISTED.msg());
			}

			RoleEntity role = roleService.findByName("一般用户");
			user = new BaseUserEntity(username, CiphersUtils.getInstance().MD5Password(password), role, telephone);
			userService.saveBase(user);
			
			CurrentUserUtils.getInstance().serUser(user);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.USER_REGISTER_SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/loginDirect", method = RequestMethod.POST)
	public Output loginDirect(@RequestParam String username, @RequestParam String password, @RequestParam String telephone) {
		try {
			BaseUserEntity user = userService.findByUsernameBase(username);

			if (user == null) { // 用户不存在
				RoleEntity role = roleService.findByName("一般用户");
				user = new BaseUserEntity(username, password, role, telephone);
				userService.saveBase(user);
			}

			CurrentUserUtils.getInstance().serUser(user);
			return new Output(user, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public Output logout(@RequestParam Long userId) {
		try {
			BaseUserEntity user = userService.findOneBase(userId);
			if (user == null) {
				return new Output(null, ReturnStatus.NULL.status(), ReturnStatus.NULL.msg());
			}

			CurrentUserUtils.getInstance().removeUser();
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/exist", method = RequestMethod.POST)
	public @ResponseBody String exist(@RequestParam String username) {
		try {
			boolean result = true;

			BaseUserEntity user = userService.findByUsernameBase(username);
			if (user != null) {
				result = false;
			}

			Map<String, Boolean> map = new HashMap<>();
			map.put("valid", result);
			ObjectMapper mapper = new ObjectMapper();
			String resultString = mapper.writeValueAsString(map);

			return resultString;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return null;
		}
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add(@RequestParam String username, @RequestParam String password,
			@RequestParam(required = false) Long roleId, @RequestParam String telephone) {
		try {
			UserEntity user = userService.findByUsername(username);
			if (user != null) {
				return new Output(null, ReturnStatus.USER_EXISTED.status(), ReturnStatus.USER_EXISTED.msg());
			}

			RoleEntity role = null;
			if (roleId == null) {
				role = roleService.findByName("一般用户");
			} else {
				role = roleService.findOne(roleId);
			}
			
			user = new UserEntity(username, CiphersUtils.getInstance().MD5Password(password), role, telephone);
			userService.save(user);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.USER_REGISTER_SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "edit", method = RequestMethod.POST)
	public Output edit(@RequestParam Long userId, @RequestParam Long roleId, @RequestParam String telephone) {
		try {
			UserEntity user = userService.findOne(userId);
			RoleEntity role = roleService.findOne(roleId);
			userService.update(user, role, telephone);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.USER_REGISTER_SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "editInfo", method = RequestMethod.POST)
	public Output editInfo(@RequestParam Long userId, @RequestParam String telephone) {
		try {
			UserEntity user = userService.findOne(userId);
			userService.update(user, telephone);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.USER_REGISTER_SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public Output detail(@RequestParam Long userId) {
		try {
			UserEntity user = userService.findOne(userId);
			return new Output(user, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OutputList list() {
		try {
			List<UserEntity> list = userService.list();
			return new OutputList(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new OutputList(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Output delete(@RequestParam String userIds) {
		try {
			List<Long> list = new LinkedList<>();
			for (String idStr : StringUtils.split(userIds, ",")) {
				list.add(Long.parseLong(idStr));
			}
			userService.delete(list);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Output(null, ReturnStatus.CONSTRAINT.status(), e.getMessage());
			}
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

	@RequestMapping(value = "/status", method = RequestMethod.POST)
	public Output status(@RequestParam Long userId, @RequestParam Integer status) {
		try {
			UserEntity user = userService.findOne(userId);
			user.setStatus(status);
			user.setUpdateTime(new Date());
			userService.save(user);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public Output changePassword(@RequestParam Long userId, @RequestParam String password,
			@RequestParam String newPassword) {
		try {
			BaseUserEntity user = userService.findOneBase(userId);
			if (!StringUtils.equals(CiphersUtils.getInstance().MD5Password(password), user.getPassword())) {
				return new Output(null, ReturnStatus.USER_PWD_ERROR.status(), ReturnStatus.USER_PWD_ERROR.msg());
			}

			user.setPassword(CiphersUtils.getInstance().MD5Password(newPassword));
			userService.saveBase(user);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	/**
	 * 找回密码
	 */

	@RequestMapping(value = "/usernameExist", method = RequestMethod.POST)
	public Output usernameExist(@RequestParam String username) {
		try {
			BaseUserEntity user = userService.findByUsernameBase(username);
			if (user == null) {
				return new Output(null, ReturnStatus.USER_NO_EXIST.status(), ReturnStatus.USER_NO_EXIST.msg());
			}
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/verifyTelephone", method = RequestMethod.POST)
	public Output changePassword(@RequestParam String username, @RequestParam String telephone) {
		try {
			BaseUserEntity user = userService.findByUsernameBase(username);
			String userTelephone = user.getTelephone();
			
			if (!userTelephone.equals(telephone)) {
				return new Output(null, ReturnStatus.FAILED.status(), ReturnStatus.FAILED.msg());
			}
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/newPassword", method = RequestMethod.POST)
	public Output newPassword(@RequestParam String username, @RequestParam String password) {
		try {
			UserEntity user = userService.findByUsername(username);
			user.setPassword(CiphersUtils.getInstance().MD5Password(password));
			userService.updatePassword(user, password);
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}

}