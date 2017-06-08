package com.hongmeng.service.application.config;

import javax.servlet.Filter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.embedded.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.hongmeng.service.application.filter.FilterAuth;

/**
 * 网页端配置类
 */
@Configuration
public class WebAppConfig extends WebMvcConfigurerAdapter {

	static Logger log = LoggerFactory.getLogger(WebAppConfig.class);

	@Value("${customize.path.upload}")
	private String uploadPath;

	/**
	 * 除了登录注册外，拦截所有请求
	 */
//	@Override
//	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(new UserSecurityInterceptor())	
//			.addPathPatterns("/**")
//			.excludePathPatterns("/account/**")
//	}

	@Bean
	public FilterRegistrationBean filterRegistration() {
		FilterRegistrationBean registration = new FilterRegistrationBean();
		registration.setFilter(authFilter());
		registration.addUrlPatterns("/manager");
		registration.addUrlPatterns("/in");
		registration.setName("authFilter");
		return registration;
	}

	@Bean(name = "authFilter")
	public Filter authFilter() {
		return new FilterAuth();
	}

	/**
	 * 添加静态资源映射
	 */
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/image/**").addResourceLocations("file:" + uploadPath + "/image/");
		registry.addResourceHandler("/html/**").addResourceLocations("file:" + uploadPath + "/html/");
		registry.addResourceHandler("/file/**").addResourceLocations("file:" + uploadPath + "/file/");
		super.addResourceHandlers(registry);
	}
}
