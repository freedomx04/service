<%@page import="com.google.gson.Gson"%>
<%@page import="com.hongmeng.service.entity.authority.BaseUserEntity"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>后台管理</title>
	<%@ include file="/WEB-INF/include/html_head_preload.jsp"%> 
	
	<!-- template -->
	<%@ include file="/WEB-INF/template/common/dialog.jsp"%>
	<%@ include file="/WEB-INF/template/common/alert.jsp"%>
	<%@ include file="/WEB-INF/template/common/editor.jsp"%>
	<%@ include file="/WEB-INF/template/common/unCertification.jsp"%> 
	
	<!-- admin -->
	<jsp:include flush="true" page="/WEB-INF/manager/admin/user.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/admin/company.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/admin/role.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/admin/area.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/admin/visit.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/admin/manufactureManager.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/admin/financingManager.jsp"/>
	
	<!-- personal -->
	<jsp:include flush="true" page="/WEB-INF/manager/personal/companyInfo.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/personal/personalInfo.jsp"/>
	
	<!-- recommend -->
	<jsp:include flush="true" page="/WEB-INF/manager/recommend/recommendCompany.jsp"/>
	
	<!-- talent -->
	<jsp:include flush="true" page="/WEB-INF/manager/talent/job.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/talent/talentCompany.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/talent/recruitment.jsp"/>
	
	<!-- manufacture -->
	<jsp:include flush="true" page="/WEB-INF/manager/manufacture/purchase.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/manufacture/manufactureCompany.jsp"/>
	
	<!-- financing -->
	<jsp:include flush="true" page="/WEB-INF/manager/financing/financing.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/financing/financingCompany.jsp"/>
	
	<!-- logistics -->
	<jsp:include flush="true" page="/WEB-INF/manager/logistics/supply.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/manager/logistics/logisticsCompany.jsp"/>
	
	<!-- js/css -->
	<script type="text/javascript" src="vendor/metisMenu/metisMenu.min.js"></script>
	<link rel="stylesheet" type="text/css" href="vendor/metisMenu/metisMenu.min.css"/>
	
	<script type="text/javascript" src="vendor/sb-admin/js/sb-admin-2.js"></script>
	<link rel="stylesheet" type="text/css" href="vendor/sb-admin/css/sb-admin-2.css"/>
	
	<style type="text/css">
	.sidebar .nav > li > a {
		padding: 13px 15px 13px 35px;
	}
	.sidebar .nav-second-level > li > a {
		padding-left: 55px;
	}
	.user-menu:HOVER {
		background-color: #77afff!important;
	}
	.user-menu:ACTIVE {
		background-color: #77afff!important;
	}
	.user-menu:FOCUS {
		background-color: #77afff!important;
	}
	</style>
</head>
<body class="hm">
	
	<div id="wrapper" style="background-color: #e9eef1;">
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0; height: 62px; background-color: #3b8cff; color: #fff;">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="manager" style="color: #fff; line-height: 62px; font-size: 22px; padding: 0 0 0 30px;"><strong>服务平台后台管理</strong></a>
            </div>
            
            <ul class="nav navbar-top-links navbar-right">
            	<li>
            		<a class='user-menu' href="index" style="color: white;"><i class="fa fa-home fa-fw"></i>服务平台首页</a>
            	</li>
            	<li class="dropdown">
                    <a class="dropdown-toggle user-menu" data-toggle="dropdown" href="#" style="color: white;">
                        <i class="fa fa-user fa-fw"></i> 
                        <span class="user-username"></span>
                        <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user" style="min-width: 100px;">
                        <li>
                        	<a class="user-logout">
                        		<i class="fa fa-sign-out fa-fw"></i> 登出
                        	</a>
                        </li>
                    </ul>
                </li>
            </ul>
            
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu"></ul>
                </div>
            </div>
		</nav>
		
		<!-- content -->
		<div id="page-wrapper"></div>
	
	</div>
	
	<script class='template Sidebar' type='text/x-jquery-tmpl'>
		{{~ $k.constant.resource: authority}}		
			{{? it.resource.indexOf('{{=authority.value}}') > -1}}
			<li>
				<a href="#"><i class="fa {{=authority.fa}} fa-fw"></i>  {{=authority.name}}<span class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
				{{~ authority.list: sub}}
					{{? it.resource.indexOf('{{=sub.value}}') > -1}}
					<li class="module" module="{{=sub.module}}"><a href='\#{{=sub.module}}'>{{=sub.name}}</a></li>
					{{?}}
				{{~}}
				</ul>
			</li>
			{{?}}
		{{~}}
	</script>
	
	<script type="text/javascript">
	;(function($) {
	
		var $page = $("#wrapper");
		var $content = $page.find("#page-wrapper");
		
		// set session
		<% 
			Gson gson = new Gson();
			BaseUserEntity user = (BaseUserEntity) session.getAttribute("cur_user");
			String str = gson.toJson(user);
		%>
		var user = JSON.parse('<%=str%>');
		$k.user.set(user);
		$page.find('.user-username').text(user.username);
		
 		$page.find('#side-menu').html(
			$('.template.Sidebar').doT({
				resource: user.role.resource
			})
		); 
		
		init();
		
		$page
		.on('click', '.sidebar .module', function() {
			var moduleName = $(this).attr("module");
			$k.page[moduleName].draw().load();
			
			$content.find(".modulePage").hide();
			$content.find('.' + moduleName + 'Page').show();
		})
		.on('click', '.user-logout', function() {
			$.ajax({
				url: 'user/logout',
				type: 'POST',
				data: { 
					userId: $k.user.get().id 
				},
				success: function(data) {
					if (data.status == 0) {
						window.location.href = "./login";
						$k.user.logout();
					}
				},
				error: function(err) {}
			});
		});
		
		// init
		$('.sidebar .module[module="personalInfo"]').trigger("click");
		
		function init() {
			// admin
			$('<div class="userPage modulePage"></div>').appendTo($content);
			$k.page.user = new $k.proto.User().init($content.find(".userPage"));
			
			$('<div class="companyPage modulePage"></div>').appendTo($content);
			$k.page.company = new $k.proto.Company().init($content.find(".companyPage"));
			
			$('<div class="rolePage modulePage"></div>').appendTo($content);
			$k.page.role = new $k.proto.Role().init($content.find(".rolePage"));
			
			$('<div class="areaPage modulePage"></div>').appendTo($content);
			$k.page.area = new $k.proto.Area().init($content.find(".areaPage"));
			
			$('<div class="visitPage modulePage"></div>').appendTo($content);
			$k.page.visit = new $k.proto.Visit().init($content.find(".visitPage"));
			
			$('<div class="manufactureManagerPage modulePage"></div>').appendTo($content);
			$k.page.manufactureManager = new $k.proto.ManufactureManager().init($content.find(".manufactureManagerPage"));
			
			$('<div class="financingManagerPage modulePage"></div>').appendTo($content);
			$k.page.financingManager = new $k.proto.FinancingManager().init($content.find(".financingManagerPage"));
			
			// recommend
			$('<div class="recommendCompanyPage modulePage"></div>').appendTo($content);
			$k.page.recommendCompany = new $k.proto.RecommendCompany().init($content.find(".recommendCompanyPage"));
			
			// talent
			$('<div class="jobPage modulePage"></div>').appendTo($content);
			$k.page.job = new $k.proto.Job().init($content.find(".jobPage"));
			$('<div class="talentCompanyPage modulePage"></div>').appendTo($content);
			$k.page.talentCompany = new $k.proto.TalentCompany().init($content.find(".talentCompanyPage"));
			
			// manufacture
			$('<div class="purchasePage modulePage"></div>').appendTo($content);
			$k.page.purchase = new $k.proto.Purchase().init($content.find(".purchasePage"));
			$('<div class="manufactureCompanyPage modulePage"></div>').appendTo($content);
			$k.page.manufactureCompany = new $k.proto.ManufactureCompany().init($content.find(".manufactureCompanyPage"));
			
			// financing
			$('<div class="financingPage modulePage"></div>').appendTo($content);
			$k.page.financing = new $k.proto.Financing().init($content.find(".financingPage"));
			$('<div class="financingCompanyPage modulePage"></div>').appendTo($content);
			$k.page.financingCompany = new $k.proto.FinancingCompany().init($content.find(".financingCompanyPage"));
			
			// logistics
			$('<div class="logisticsSupplyPage modulePage"></div>').appendTo($content);
			$k.page.logisticsSupply = new $k.proto.LogisticsSupply().init($content.find(".logisticsSupplyPage"));
			$('<div class="logisticsCompanyPage modulePage"></div>').appendTo($content);
			$k.page.logisticsCompany = new $k.proto.LogisticsCompany().init($content.find(".logisticsCompanyPage"));
			
			//personal
			$('<div class="personalInfoPage modulePage"></div>').appendTo($content);
			$k.page.personalInfo = new $k.proto.PersonalInfo().init($content.find(".personalInfoPage"));
			$('<div class="companyInfoPage modulePage"></div>').appendTo($content);
			$k.page.companyInfo = new $k.proto.CompanyInfo().init($content.find(".companyInfoPage"));
		}
		
	})(jQuery);
		
	</script>
         

</body>
</html>