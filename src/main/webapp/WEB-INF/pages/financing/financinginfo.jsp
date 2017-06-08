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
	padding: 20px;
	margin-bottom: 30px;
}
.financingInfo-content {
	width: 1000px;
	margin: 0 auto;
	padding: 20px;
}
.financingInfo > div.row:not(:last-child) {
	margin-bottom: 10px;
}
.financingInfo > .title {
	font-size: 20px;
	color: #3b8cff;
	line-height: 20px;
	margin-bottom: 5px;
}
.project-description div:not(.title),
.project-advantage div:not(.title), 
.contactUs div:not(.title){
	padding: 20px;
}
.project-description div.title,
.project-advantage div.title, 
.contactUs div.title {
	border-bottom: 2px solid #ddd;
}
.project-description span.title,
.project-advantage span.title, 
.contactUs span.title {
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
					    <li><a href="financing" target="_blank">融资服务</a></li>
					    <li><a href="financing" target="_blank">资金需求</a></li>
					    <li class="active">资金需求详情</li>
					</ul>
				</div>
				<div class="financingInfo-content"></div>
			</div>
		</div>
		
		<div id="footer"></div>
	</div>
</body>

<script class="template FinancingInfo" type="text/x-jquery-tmpl">
<div class="financingInfo">
	<div class="title line-break">{{=it.data.name}}</div>
	<div style="margin-bottom: 30px;"><span class="color-9"><i class=" glyphicon glyphicon-time"></i>{{=new Date(it.data.createTime).format("yyyy-mm-dd")}}</span></div>
	<div class="row">
		<div class="col-md-6"><span class="color-9">融资类型：</span><span>{{=$k.constant.financingType[it.data.financingType].name}}</span></div>
		<div class="col-md-6"><span class="color-9">所在地区：</span><span>{{=it.data.location}}</span></div>
	</div>
	<div class="row">
		<div class="col-md-6"><span class="color-9">所属行业：</span><span>{{=$k.constant.profession[it.data.profession].name}}</span></div>
		<div class="col-md-6"><span class="color-9">融资用途：</span><span>{{=it.data.purpose}}</span></div>
	</div>
	<div class="row">
		<div class="col-md-6"><span class="color-9">融资金额：</span><span>{{=it.data.amount}}</span></div>
	</div>
</div>
<div class="project-description">
	<div class="title"><span class="title">项目描述</span></div>
	<div>{{=it.data.description}}</div>
</div>
<div class="project-advantage">
	<div class="title"><span class="title">项目优势</span></div>
	<div>{{=it.data.advantage}}</div>
</div>
<div class="contactUs">
	<div class="title"><span class="title">联系我们</span></div>
	<div>
		<p>公司名称：{{=it.data.companyName}}</p>
		<p>联系人：{{=it.data.contactUser}}</p>
		<p>联系方式：{{=it.data.contact}}</p>
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
		url: "financing/financing/detail",
		type: "POST",
		data: {
			financingId: id
		},
		success: function(data) {
			if(data.status == 0) {
				$content.find(".financingInfo-content").html($(".template.FinancingInfo").doT({
					data: data.data
				}));
			}
		},
		error: function(e) {}
	});
	
})();
</script>
</html>