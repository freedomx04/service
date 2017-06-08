package com.hongmeng.service.controller.authority;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hongmeng.service.common.ReturnStatus;
import com.hongmeng.service.entity.Output;
import com.hongmeng.service.entity.authority.VisitEntity;
import com.hongmeng.service.service.authority.VisitService;

@RestController
@RequestMapping("visit")
public class VisitController {
	
	static Logger log = LoggerFactory.getLogger(VisitController.class);
	
	@Autowired
	VisitService visitService;
	
	@Autowired
	HttpServletRequest request;
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Output add() {
		try {
			String ip = request.getRemoteAddr();
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			VisitEntity visit = new VisitEntity(ip, sdf.format(now));
			visitService.save(visit);
			
			return new Output(null, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public Output list() {
		try {
			List<?> list = visitService.listByDate();
			return new Output(list, ReturnStatus.SUCCESS.status(), ReturnStatus.SUCCESS.msg());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Output(null, ReturnStatus.FAILED.status(), e.getMessage());
		}
	}
	
}