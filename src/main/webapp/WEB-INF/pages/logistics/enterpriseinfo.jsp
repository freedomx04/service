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

<style>
#right .contact-info {
	margin-top: 20px;
	line-height: 50px;
}
#right .contact-info > div {
	padding: 20px 20px 100px 20px;
}
#right .dynamic-info > div:first-child {
	padding: 20px;
}
#right .contact-info > div > div:not(:last-child) {
	border-bottom: 1px dashed #ddd;
}
#right .dynamic-info li {
	border: 1px solid #eee;
	margin-bottom: 10px;
}
#right .dynamic-info li > div {
	padding: 10px;
}
</style>
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>
</head>
<body>
	<div id="page" class="enterpriseinfo">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
			<div class="weizhi">
				<ul style="margin-bottom: 10px;">
					<li><a href="supply">物流服务</a></li>
					<li class="active">企业详情</li>
				</ul>
			</div>
		
			<div class="top_info">
				<div class="top_info_wrap"></div>
			</div>
			
			<div id="company_navs" class="company_navs">
			    <div class="company_navs_wrap">
			        <ul>
			            <li class="enterprise-intro current">
			                <a>公司介绍</a>
			            </li>
			            <li class="enterprise-network">
			                <a>网点介绍</a>
			            </li>
			            <li class="enterprise-line">
			                <a>线路运价</a>
			            </li>
			            <li class="enterprise-evaluation">
			                <a>评分(<span></span>)</a>
			            </li>
			            <li class="enterprise-dynamic">
			                <a>动态(<span></span>)</a>
			            </li>
			            <li class="enterprise-contact">
			                <a>联系我们</a>
			            </li>
			        </ul>
			    </div>
			</div>
			
			<div id="enterpriseinfo_container">
				<div id="left"></div>
				<div id="right" class="line-break"></div>
			</div>
		</div>
		
		<div id="footer"></div>
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
			<div><span class="color-9">经营模式：</span><span>{{=it.data.property!=null ? $k.constant.property[it.data.property].name : ""}}</span></div>
			<div><span class="color-9">服务线路：</span><span>{{=it.data.lines.length}}条</span></div>
			<div><span class="color-9">服务网点：</span><span>{{=it.data.networks.length}}家</span></div>
		</div>
		<div>
			<div class="color-9">服务电话：</div>
			<div>{{=it.data.phone}} / {{=it.data.contact}}</div>
		</div>
	</div>
</div>
</script>

<script class="template EnterpriseBasiInfo" type="text/x-jquery-tmpl">
<div>
	<div class="company-name line-break">{{=it.data.name}}</div>
	<div class="company-simpleinfo">
		<div><span class="color-9">企业性质：</span><span>{{=it.data.property!=null ? $k.constant.property[it.data.property].name : ""}}</span></div>
		<div><span class="color-9">服务线路：</span><span>{{=it.data.lines.length}}条</span></div>
		<div><span class="color-9">服务网点：</span><span>{{=it.data.networks.length}}家</span></div>
	</div>
	<div>
		<div class="color-9">服务电话：</div>
		<div>{{=it.data.phone}} / {{=it.data.contact}}</div>
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

<script class="template EnterpriseNetwork" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">营业网点</div>
	<div>
		<table class="table table-hover table-bordered">
			<thead>
	    		<tr>
	      		<th>网点名称</th>
	      		<th>地址</th>
	      		<th>联系电话</th>
	      		<th>业务内容</th>
	    		</tr>
	  		</thead>
	  		<tbody>
	    	{{~it.data.content : data}}
				<tr>
	      			<td>{{=data.name}}</td>
	      			<td>{{=data.address}}</td>
	      			<td>{{=data.contact}}</td>
	      			<td>{{=data.business}}</td>
	    		</tr>
			{{~}}
	  		</tbody>
		</table>
		<div class="pager_container">
			<ul></ul>
		</div>
	</div>
</div>
</script>

<script class="template EnterpriseNetworkList" type="text/x-jquery-tmpl">
{{~it.data.content : data}}
<tr>
	<td>{{=data.name}}</td>
	<td>{{=data.address}}</td>
	<td>{{=data.contact}}</td>
	<td>{{=data.business}}</td>
</tr>
{{~}}
</script>

<script class="template EnterpriseLine" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">线路运价</div>
	<div>
		<table class="table table-hover table-bordered">
	  	<thead>
	   		<tr>
	     	 <th>线路</th>
	      	<th>运输模式</th>
	      	<th>参考时效</th>
	      	<th>单价（重货）</th>
	      	<th>单价（轻货）</th>
	      	<th>最低-票</th>
	    	</tr>
	  	</thead>
	  	<tbody>
			{{~it.data.content: data}}
	    	<tr>
	      	<td>{{=data.origin}} - {{=data.destination}}</td>
	      	<td>{{=$k.constant.transportMode[data.transportMode].name}}</td>
	      	<td>{{=data.aging}}天</td>
	      	<td>{{=data.heavyPrice}} 元/公斤</td>
	      	<td>{{=data.lightPrice}} 元/立方</td>
	     	<td>{{=data.lowest}}元</td>
	    	</tr>
			{{~}}
	  	</tbody>
		</table>
		<div class="pager_container">
			<ul></ul>
		</div>
	</div>
</div>
</script>

<script class="template EnterpriseLineList" type="text/x-jquery-tmpl">
{{~it.data.content: data}}
<tr>
  <td>{{=data.origin}} - {{=data.destination}}</td>
  <td>{{=$k.constant.transportMode[data.transportMode].name}}</td>
  <td>{{=data.aging}}天</td>
  <td>{{=data.heavyPrice}} 元/公斤</td>
  <td>{{=data.lightPrice}} 元/立方</td>
  <td>{{=data.lowest}}元</td>
</tr>
{{~}}
</script>

<script class="template EnterpriseContactUs" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">联系我们</div>
	<div class="contact-info">
		<div>
			<div><span class="color-9">发布公司：</span><span>{{=it.data.name}}</span></div>
			<div><span class="color-9">联系方式：</span><span>{{=it.data.contact}}</span></div>
			<div><span class="color-9">公司地址：</span><span>{{=it.data.address}}</span></div>
			<div><span class="color-9">公司网站：</span><a href="{{="http://" + it.data.website}}" target="_blank">{{="http://" + it.data.website}}</a></div>
		</div>
	</div>
</div>
</script>

<script class="template EnterpriseDynamic" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">服务动态</div>
	<div class="dynamic-info">
		<div>
			<ul>
				{{~it.data.content: dynamic}}
				<li class="row">
					<div class="col-md-8 col-xs-8" style="line-height: 30px;">
						<div class="font-16"><a id="{{=dynamic.id}}" class="dynamic-title">{{=dynamic.title}}</a></div>
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
		url: "logistics/company/detail",
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
				$container.find(".enterprise-dynamic span").html(data.data.dynamics.length);
			}
		}
	});
	
	$container
	.on("click", ".enterprise-intro, .enterprise-network, .enterprise-line, .enterprise-dynamic, .enterprise-contact, .enterprise-evaluation", function() {
		var $this = $(this);
		var $template = null;
		var url = "";
		$nav.find("li").removeClass("current");
		$(this).addClass("current");
		
		if($this.hasClass("enterprise-intro")) {
			
			$template = $(".template.EnterpriseIntro");
			url = "logistics/company/detail";
		} else if($this.hasClass("enterprise-network")) {
			
			$template = $(".template.EnterpriseNetwork");
			url = "logistics/network/listByCompanyIdPaging";
		} else if($this.hasClass("enterprise-line")) {
			
			$template = $(".template.EnterpriseLine");
			url = "logistics/line/listByCompanyIdPaging";
		} else if($this.hasClass("enterprise-dynamic")) {
			
			$template = $(".template.EnterpriseDynamic");
			url = "logistics/dynamic/listByCompanyIdPaging";
		} else if($this.hasClass("enterprise-contact")) {
			
			$template = $(".template.EnterpriseContactUs");
			url = "logistics/company/detail";
		} else {
			new $k.proto.Evaluation().init($("#right"), "logistics", id).draw(averageScore, totalEvaluation).load(0);
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
					
					$container.find('.citypicker').citypicker();
					
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
		$.ajax({
			url: "logistics/dynamic/detail",
			type: "POST",
			data: {dynamicId: dynamicId},
			success: function(data) {
				if(data.status == 0) {
					$container.find("#right").html($(".template.EnterpriseDynamicInfo").doT({
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