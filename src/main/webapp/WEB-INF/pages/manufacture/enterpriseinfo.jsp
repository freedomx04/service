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

<style>
/* 企业动态 */
.dynamic-info li:not(.active){
    margin-top: 10px;
  	padding: 10px;
  	border: 1px solid #ddd;
}
.dynamic-info .title {
	font-size: 16px;
}
/* 产品中心 */
#enterpriseinfo_container .product-name {
	color: #3b8cff;
}
#enterpriseinfo_container .product-name, 
#enterpriseinfo_container .product-intro,
#enterpriseinfo_container .product-otherinfo {
	line-height: 30px;
}
#enterpriseinfo_container .product-otherinfo > span:not(:last-child) {
	margin-right: 30px;
}
#enterpriseinfo_container .product-list li {
	border: 1px solid #ddd;
	margin: 5px 0;
	padding: 5px;
}
#enterpriseinfo_container .product-list li > div {
	padding-left: 0;
}
/* 产品详情 */
#enterpriseinfo_container .productinfo .product-maininfo > div {
	line-height: 30px;
}
#enterpriseinfo_container .productinfo h3 {
	text-indent: 5em;
}
</style>

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
				    <li><a href="bulletin">智能制造</a></li>
				    <li><a href="">智能产品</a></li>
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
		                <a>企业档案</a>
		            </li>
		            <li class="enterprise-dynamic">
		                <a>企业动态(<span></span>)</a>
		            </li>
		            <li class="enterprise-product">
		                <a>产品中心</a>
		            </li>
		            <li class="enterprise-solution">
		                <a>解决方案</a>
		            </li>
		            <li class="enterprise-case">
		                <a>成功案例</a>
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
		    <a class="hm-a" href="" target="_blank" rel="nofollow" title="{{=it.data.name}}">
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
	<p class="item_ltitle">公司介绍</p>
	<p>{{=it.data.introduction}}</p>
</div>
</script>


<script class="template EnterpriseProduct" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">产品中心</div>
	<div class="product-list">
		<ul>
			{{~it.data.content: data}}
			<li class="row">
				<div class="img-wraper col-md-2 col-xs-3">
					<img alt="" src="{{="./" + data.imagePath}}" width="100%">
				</div>
				<div class="col-md-10 col-xs-9">
					<div class="product-name" id="{{=data.id}}"><a class="hm-a">{{=$k.util.cutString(data.name, 35)}}</a></div>
					<div class="product-intro">
						<span>{{=$k.util.cutString(data.introduction, 60)}}</span>
						<span class="pull-right">¥<span class="color-org">{{=data.price}}</span></span>
					</div>
					<div class="product-otherinfo">
						<span class="product-type"><span class="color-9">产品型号：</span>{{=data.model}}</span>
						<span class="product-address"><span class="color-9">所在地：</span>{{=data.location}}</span>
						<span class="product-time"><span class="color-9">更新时间：</span>{{=new Date(data.updateTime).format("yyyy-mm-dd")}}</span>
					</div>
				</div>
			</li>
			{{~}}
		</ul>
	</div>
</div>
<div class="pager_container">
	<ul></ul>
</div>
</script>

<script class="template EnterpriseProductInfo" type="text/x-jquery-tmpl">
<div class="productinfo item_container">
	<div class="item_ltitle">产品详情</div>
	<div class="row">
		<div class="col-md-4 col-xs-5"><img src="{{="./" + it.data.imagePath}}"></div>
		<div class="col-md-7 col-xs-7 product-maininfo" style='padding-left: 20px;'>
			<div><span class="color-9">产品名称：</span><span>{{=it.data.name}}</span></div>
			<div style="line-height: 20px;"><span class="color-9">产品型号：</span><span>{{=it.data.model}}</span></div>
			<div><span class="color-9">产品价格：</span>¥<span class="color-org">{{=it.data.price}}</span></div>
			<div><span class="color-9">所在地：</span><span>{{=it.data.location}}</span></div>
			<div><span class="color-9">更新时间：</span><span>{{=new Date(it.data.updateTime).format("yyyy-mm-dd")}}</span></div>
			<div><span class="color-9">厂商性质：</span><span>{{=$k.constant.manufactureProperty[it.data.property].name}}</span></div>
		</div>
	</div>
	<div class="panel panel-default" style="margin-top:30px;">
		<div class="panel-heading">
			<i class="fa fa-info-circle fa-fw"></i>产品简介
		</div>
		<div class="panel-body">
			{{=it.data.introduction}}
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<i class="fa fa-info-circle fa-fw"></i>详细信息
		</div>
		<div class="panel-body">
			{{=it.data.description}}
		</div>
	</div>
</div>
</script>

<script class="template EnterpriseDynamic" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">{{=it.subType == "solution" ? "解决方案" : it.subType == "case" ? "成功案例" : "企业动态"}}</div>
	<div class="dynamic-info">
		<div>
			<ul>
				{{~it.data.content: dynamic}}
				<li>
					<div style="line-height: 30px;">
						<div class="title" title="{{=dynamic.title}}"><a id="{{=dynamic.id}}" class="dynamic-title hm-a" subType="{{=it.subType}}" >{{=$k.util.cutString(dynamic.title, 40)}}</a></div>
						<div class="color-9">{{=new Date(dynamic.createTime).format("yyyy-mm-dd HH:MM")}}</div>
					</div>
				</li>
				{{~}}
			</ul>
		</div>
		<div class="pager_container">
			<ul></ul>
		</div>
	</div>
</div>
</script>

<script  class="template EnterpriseDynamicInfo" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">{{=it.subType == "solution" ? "解决方案" : it.subType == "case" ? "成功案例" : "企业动态"}}</div>
	<div class="dynamicinfo-content" style="width: 100%;">
		<div class="top">
			<div class="title">{{=it.data.title}}</div>
			<div>
				<span class="time"><span class="info">发布时间：</span><span>{{=$k.util.getDateString(it.data.createTime)}}</span></span>
				<span><span class="info">来源：</span><span>{{=it.data.source}}</span></span>
			</div>
		</div>
		<div class="line-break">{{=it.data.content}}</div>
	</div>
</div>
</script>

<script>
;(function() {
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(2);
	
	var $container = $(".enterpriseinfo");
	var $nav = $("#company_navs");
	var averageScore = 0;
	var totalEvaluation = 0;
	var companyName = "";
	var id = $k.util.getRequestParam("id");
	if(id == "" || id == null) {
		return;
	}
	$.ajax({
		url: "manufacture/company/detail",
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
				
				companyName = data.data.name;
				$container.find(".enterprise-dynamic span").html(data.data.dynamics.length);
			}
		}
	});
	
	$container
	.on("click", ".enterprise-intro, .enterprise-product, .enterprise-solution, .enterprise-dynamic, .enterprise-case", function() {
		var $this = $(this);
		var $template = null;
		var url = "";
		var type = 2;
		var subType = "";
		
		$nav.find("li").removeClass("current");
		$(this).addClass("current");
		
		if($this.hasClass("enterprise-intro")) {
			$template = $(".template.EnterpriseIntro");
			url = "manufacture/company/detail";
		} else if($this.hasClass("enterprise-product")) {
			$template = $(".template.EnterpriseProduct");
			url = "manufacture/product/listByCompanyIdPaging";
		} else if($this.hasClass("enterprise-solution")) {
			$template = $(".template.EnterpriseDynamic");
			url = "manufacture/solution/listByCompanyIdPaging";
			subType = "solution";
		} else if($this.hasClass("enterprise-dynamic")) {
			$template = $(".template.EnterpriseDynamic");
			url = "manufacture/dynamic/listByCompanyIdPaging";
			subType = "dynamic";
		} else if($this.hasClass("enterprise-case")) {
			$template = $(".template.EnterpriseDynamic");
			url = "manufacture/case/listByCompanyIdPaging";
			subType = "case";
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
						data: data.data,
						companyName: companyName,
						type: type,
						subType: subType
					}));
					if(data.data.content != null && data.data.content.length == 0) {
						return;
					}
					
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
	.on("click", ".dynamic-title", function() {
		var dynamicId = $(this).attr("id");
		var subType = $(this).attr("subType");
		var data = {dynamicId: dynamicId};
		if(subType == "solution") {
			data = {solutionId: dynamicId};
		} else if(subType == "case") {
			data = {caseId: dynamicId};
		}
		$.ajax({
			url: "manufacture/"+ subType +"/detail",
			type: "POST",
			data: data,
			success: function(data) {
				if(data.status == 0) {
					$container.find("#right").html($(".template.EnterpriseDynamicInfo").doT({
						data: data.data,
						subType: subType
					}));
				}
			},
			error: function(err) {}								
		});
	})
	.on("click", ".product-name", function() {
		var productId = $(this).attr("id");
		$.ajax({
			url: "manufacture/product/detail",
			type: "POST",
			data: {
				productId: productId
			},
			success: function(data) {
				if(data.status == 0) {
					$container.find("#right").html($(".template.EnterpriseProductInfo").doT({
						data: data.data
					}));
				}
			},
			error: function(err) {}
		});
	})
})();
</script>
</html>