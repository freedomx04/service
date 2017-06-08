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
<%@ include file="/WEB-INF/template/financing/financing_top.jsp"%>

<style>
.financingInfo {
	padding: 15px;
	margin-bottom: 15px;
}
.financingInfo > div.row:not(:last-child) {
	margin-bottom: 10px;
}
.financingInfo > .title {
	font-size: 20px;
	color: #3b8cff;
	line-height: 20px;
}
.project-description div:not(.title),
.project-advantage div:not(.title), .contactUs div:not(.title){
	padding: 15px;
}
.project-description div.title,
.project-advantage div.title, .contactUs div.title {
	border-bottom: 2px solid #ddd;
}
.project-description span.title,
.project-advantage span.title, .contactUs span.title {
	border-bottom: 2px solid #fd5f39;
	font-size: 18px;
	padding: 0 20px;
}
</style>
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>
</head>
<body>
	<div id="page">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
			<div class="financingInfo-container">
				<div class="weizhi">
					<ul style="margin-bottom: 10px;">
					    <li><a href="invest" target="_blank">融资服务</a></li>
					    <li><a href="invest" target="_blank">投资信息</a></li>
					    <li class="active">投资信息详情</li>
					</ul>
				</div>
				<div class="financingInfo-content">
				</div>
			</div>
		</div>
		
		<div id="footer">
		</div>
	</div>
</body>

<script class="template InvestInfo" type="text/x-jquery-tmpl">
<div class="financingInfo">
	<div class="title">{{=it.data.name}}</div>
	<div style="margin-bottom: 15px;"><span class="color-9"><i class=" glyphicon glyphicon-time"></i>{{=new Date(it.data.createTime).format("yyyy-mm-dd")}}</span></div>
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
</script>

<script>
;(function() {
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(4);

	var id = $k.util.getRequestParam("id");
	if(id == "" || id == null) {
		return;
	}
	
	$.ajax({
		url: "financing/invest/detail",
		type: "POST",
		data: {
			investId: id
		},
		success: function(data) {
			if(data.status == 0) {
				$content.find(".financingInfo-content").html($(".template.InvestInfo").doT({
					data: data.data
				}));
			}
		},
		error: function(e) {}
	});
	
})();
</script>
</html>