<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<!--[if lt IE 9]>
  <script src="/vendor/html5shiv/r29/html5.min.js"></script>
  <script src="/vendor/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<title></title>

<%@ include file="/WEB-INF/include/html_head_preload.jsp"%>
<%@ include file="/WEB-INF/template/top.jsp"%>
<%@ include file="/WEB-INF/template/footer.jsp"%>
<%@ include file="/WEB-INF/template/menu.jsp"%>
<%@ include file="/WEB-INF/template/evaluation.jsp"%>
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>
</head>
<body>
	<div id="page" class="enterpriseinfo">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="top_info">
			<div class="weizhi">
				<ul style="margin-bottom: 10px;">
				    <li><a href="financing">融资服务</a></li>
				    <li><a href="financingUnit">服务单位</a></li>
				    <li class="active">企业详情</li>
				</ul>
			</div>
			<div class="top_info_wrap">
			</div>
		</div>
		<div id="company_navs" class="company_navs">
		    <div class="company_navs_wrap">
		        <ul>
		            <li class="enterprise-intro current">
		                <a>公司介绍</a>
		            </li>
		            <li class="enterprise-invest">
		                <a>投资信息</a>
		            </li>
		            <li class="enterprise-evaluation">
		                <a>评分(<span></span>)</a>
		            </li>
		        </ul>
		    </div>
		</div>
		<div id="enterpriseinfo_container">
			<div id="left">
			</div>
			<div id="right" class="line-break">
			</div>
		</div>
		<div id="footer">
		</div>
	</div>
</body>

<script class="template EnterpriseInfoTop" type="text/x-jquery-tmpl">
<img src="{{="./" + it.data.imagePath}}">
<div class="company_info">
	<div class="company_main">
		<h1>
		    <a class="hm-a"  href="{{="http://" + it.data.website}}" target="_blank" rel="nofollow" title="{{=it.data.name}}">
		   		{{=it.data.name}}
		    </a>
		</h1>
		<a href="{{="http://" + it.data.website}}" class="icon-wrap" target="_blank" rel="nofollow" title="{{="http://" + it.data.website}}">
           <i></i>
        </a>
		<a class="identification" title="已认证企业">
            <i></i>
        	<span>已认证</span>
        </a>
	</div>
	<div class="tiny-enterpriseinfo">
		<div class="company-simpleinfo">
			<div><span class="color-9">手机：</span>{{=it.data.contact}}<span></span></div>
			<div><span class="color-9">联系人：</span><span>{{=it.data.contactUser}}</span></div>
			<div><span class="color-9">电话：</span><span>{{=it.data.phone}}</span></div>
			<div><span class="color-9">传真：</span><span>{{=it.data.fax}}</span></div>
			<div><span class="color-9">地址：</span><span>{{=it.data.address}}</span></div>
			<div><span class="color-9">企业网站：</span><span>{{=it.data.website}}</span></div>
		</div>
	</div>
</div>
</script>

<script class="template EnterpriseBasiInfo" type="text/x-jquery-tmpl">
<div>
	<div class="company-name line-break">{{=it.data.name}}</div>
	<div class="company-simpleinfo">
		<div><span class="color-9">手机：</span>{{=it.data.contact}}<span></span></div>
		<div><span class="color-9">联系人：</span><span>{{=it.data.contactUser}}</span></div>
		<div><span class="color-9">电话：</span><span>{{=it.data.phone}}</span></div>
		<div><span class="color-9">传真：</span><span>{{=it.data.fax}}</span></div>
		<div><span class="color-9">地址：</span><span>{{=it.data.address}}</span></div>
		<div><span class="color-9">企业网站：</span><span>{{=it.data.website}}</span></div>
	</div>
</div>
</script>

<script class="template EnterpriseIntro" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">公司介绍</div>
	<p>
		{{=it.data.introduction}}
	</p>
</div>
</script>

<script class="template EnterpriseInvestInfo" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">投资信息</div>
	<div class="financingInfo">
		<div class="title">{{=it.data.name}}</div>
		<div style="margin-bottom: 30px;"><span class="color-9"><i class=" glyphicon glyphicon-time"></i>{{=new Date(it.data.createTime).format("yyyy-mm-dd")}}</span></div>
		<div class="row">
			<div class="col-md-6"><span class="color-9">项目类型：</span><span>{{=$k.constant.investType[it.data.investType].name}}</span></div>
			<div class="col-md-6"><span class="color-9">资金类型：</span><span>{{=$k.constant.fundType[it.data.fundType].name}}</span></div>
		</div>
		<div class="row">
			<div class="col-md-6"><span class="color-9">所在地区：</span><span>{{=it.data.location}}</span></div>
			<div class="col-md-6">
				<span class="color-9">投资行业：</span>
				<span>
					{{~it.data.profession.split(",") : profession : i}}
						{{=$k.constant.profession[profession].name + (i != it.data.profession.split(",").length - 1 ? "," : "")}}
					{{~}}
				</span>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<span class="color-9">投资地区：</span>
				<span>
					{{~it.data.investArea.split(",") : investArea : i}}
						{{=$k.constant.investArea[investArea].name + (i != it.data.investArea.split(",").length - 1 ? "," : "")}}
					{{~}}
				</span>
			</div>
			<div class="col-md-6"><span class="color-9">投资金额：</span><span>{{=it.data.amount}}</span></div>
		</div>
	</div>
	<div class="project-description">
		<div class="title"><span class="title">投资要求概述</span></div>
		<div>{{=it.data.description}}</div>
	</div>
	<div class="project-description">
		<div class="title"><span class="title">其他备注</span></div>
		<div>{{=it.data.remark}}</div>
	</div>
	<div class="contactUs">
		<div class="title"><span class="title">联系我们</span></div>
		<div>
			<p>公司名称：{{=it.data.company.name}}</p>
			<p>联系人：{{=it.data.company.contactUser}}</p>
			<p>联系方式：{{=it.data.company.contact}}</p>
			<p>联系地址：{{=it.data.company.address}}</p>
		</div>
	</div>
</div>
</script>

<script class="template EnterpriseInvest" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">投资信息</div>
	<div>
		<ul>
		  {{~it.data.content:data}}
			<li style="border: 1px solid #ddd; padding: 10px;margin-bottom: 5px;">
				<div class="title" title="{{=data.name}}"><a id="enterprise-invest" investId="{{=data.id}}">{{=$k.util.cutString(data.name, 60)}}</a></div>
				<div class="row" style="padding: 5px 0;">
					<div class="col-md-4 ellipsis">
						<span>{{=data.company.contactUser}}</span>
						<span style="margin-left: 30px;" title="{{=data.company.name}}">{{=data.company.name}}</span>
					</div>
					<div class="col-md-8">
						<span class="color-9">投资资金：</span>
						<span class="amount" style="color: #fd5f39">{{=data.amount}}</span>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<span class="color-9">投资地区：</span>
						<span>
							{{~data.investArea.split(",") : investArea : i}}
								{{=$k.constant.investArea[investArea].name + (i != data.investArea.split(",").length - 1 ? "," : "")}}
							{{~}}
						</span>
					</div>
					<div class="col-md-8">
						<span class="color-9">投资行业：</span>
							<span>
								{{~data.profession.split(",") : profession : i}}
									{{=$k.constant.profession[profession].name + (i != data.profession.split(",").length - 1 ? "," : "")}}
								{{~}}
							</span>
					</div>
				</div>
				<div class="row" style="padding: 5px 0;">
					<div class="col-md-4">
						<span class="color-9">投资方式：</span><span>{{=$k.constant.investType[data.investType].name}}</span>
					</div>
					<div class="col-md-8">
						<span class="color-9">资金类型：</span><span>{{=$k.constant.fundType[data.fundType].name}}</span>
					</div>
				</div>
				<div><i class=" glyphicon glyphicon-time"></i><span class="color-9">{{=new Date(data.createTime).format("yyyy-mm-dd")}}</span></div>
			</li>
			{{~}}
		</ul>
		<div class="pager_container">
			<ul></ul>
		</div>
	</div>
</div>
</script>

<script>
;(function() {
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(5);
	
	var $container = $(".enterpriseinfo");
	var $nav = $("#company_navs");
	var averageScore = 0;
	var totalEvaluation = 0;
	var id = $k.util.getRequestParam("id");
	if(id == "" || id == null) {
		return;
	}
	$.ajax({
		url: "financing/company/detail",
		type: "POST",
		data: {
			companyId: id
		},
		success: function(data) {
			if(data.status == 0) {
				$container.find(".top_info_wrap").html($(".template.EnterpriseInfoTop").doT({
					data: data.data
				}));
				$container.find("#left").html($(".template.EnterpriseBasiInfo").doT({
					data: data.data
				}));
				$container.find("#right").html($(".template.EnterpriseIntro").doT({
					data: data.data
				}));
				
				totalEvaluation = data.data.evaluations.length ;
				averageScore = data.data.score;
				
				$container.find(".enterprise-evaluation span").html(totalEvaluation);
			}
		}
	});
	
	$container
	.on("click", ".enterprise-intro, .enterprise-invest, .enterprise-evaluation", function() {
		var $this = $(this);
		var $template = null;
		var url = "";
		$nav.find("li").removeClass("current");
		$(this).addClass("current");
		
		if($this.hasClass("enterprise-intro")) {
			
			$template = $(".template.EnterpriseIntro");
			url = "financing/company/detail";
		} else if($this.hasClass("enterprise-invest")) {
			
			$template = $(".template.EnterpriseInvest");
			url = "financing/invest/listByCompanyIdPaging";
		} else {
			new $k.proto.Evaluation().init($("#right"), "financing", id).draw(averageScore, totalEvaluation).load(0);
		}
		$.ajax({
			url: url,
			type: "POST",
			data: {
				companyId: id,
				page: 0,
				size: $k.config.paginator.pageSize
			},
			success: function(data) {
				if(data.status == 0) {
					$container.find("#right").html($template.doT({
						data: data.data
					}));
					
					var options = $k.config.paginator.options;
					options.totalPages = data.data.totalPages;
					options.onPageClicked = function (event, originalEvent, type, page) { //异步换页
			        	$.ajax({
			        		url: url,
			        		type: "POST",
			        		data: {
			        			companyId: id,
			        			page: page - 1,
			        			size: $k.config.paginator.pageSize
			        		},
			        		success: function(data) {
			        			if(data.status == 0) {
			        				$container.find("#right").html($template.doT({
			    						data: data.data
			    					}));
			        			}
			        		}
			        	});
					};
					$(".pager_container ul").bootstrapPaginator(options);
				}
			}
		});
	})
	.on("click", "#enterprise-invest", function() {
		var investId = $(this).attr("investId");
		$.ajax({
			url: "financing/invest/detail",
			type: "POST",
			data: {investId: investId},
			success: function(data) {
				if(data.status == 0) {
					$container.find("#right").html($(".template.EnterpriseInvestInfo").doT({
						data: data.data
					}));
				}
			},
			error: function() {}
		});
	});
})();
</script>
</html>