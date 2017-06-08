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
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>

<style>
.recommendinfo .hm-label {
    width: 90px;
}
</style>

</head>
<body>
	<div id="page">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
			<div>
				<div class="weizhi">
					<ul style="margin-bottom: 10px;">
					    <li><a href="recommend" target="_blank">企业推介</a></li>
					    <li class="active">企业详情</li>
					</ul>
				</div>
				<div class="recommendinfo">
				</div>
			</div>
		</div>
		
		<div id="footer">
		</div>
	</div>
</body>

<script class='template RecommendInfo' type='text/x-jquery-tmpl'>
<div class="top">
	<div class="line-break" style="font-size: 20px;text-align: center">{{=it.data.name}}</div>
	<div class="module-list" style="line-height: 25px; word-break: break-all;">
		<div style="max-width: 300px; max-height: 300px; float: right">
			{{? it.data.imagePath}}
	    		<img class='am-u-sm-3 am-radius' src='{{="./"+it.data.imagePath}}' style='width:100%;'>
			{{??}}
				<img src='img/enterprise_default.jpg'>
			{{?}}
		</div>

		<p>
			<span class="hm-label">认证状态:</span>
			<span class="hm-content" style="color: #3b8cff; font-weight: bold;">{{=$k.constant.certification[it.data.status].name}}</span>
		</p>
		<p>
			<span class="hm-label">公司名称:</span>
			<span class="hm-content">{{=it.data.name}}</span>
		</p>
		<p>
			<span class="hm-label">行业类别:</span>
			<span class="hm-content">{{=$k.constant.profession[it.data.profession].name}}</span>
		</p>
		<p>
			<span class="hm-label">公司性质:</span>
			<span class="hm-content">{{=$k.constant.property[it.data.property].name}}</span>
		</p>
		<p>
			<span class="hm-label">公司规模:</span>
			<span class="hm-content">{{=$k.constant.scale[it.data.scale].name}}</span>
		</p>
		<p>
			<span class="hm-label">公司地点:</span>
			<span class="hm-content">{{=it.data.area != null ? it.data.area.name : ""}}</span>
		</p>
		<p>
			<span class="hm-label">公司地址:</span>
			<span class="hm-content">{{=it.data.address || ""}}</span>
		</p>
		<p>
			<span class="hm-label">座机号码:</span>
			<span class="hm-content">{{=it.data.phone || ""}}</span>
		</p>
		<p>
			<span class="hm-label">传真号:</span>
			<span class="hm-content">{{=it.data.fax || ""}}</span>
		</p>
		<p>
			<span class="hm-label">联系人:</span>
			<span class="hm-content">{{=it.data.contactUser || ""}}</span>
		</p>
		<p>
			<span class="hm-label">联系方式:</span>
			<span class="hm-content">{{=it.data.contact || ""}}</span>
		</p>
		<p>
			<span class="hm-label">公司网站:</span>
			<span class="hm-content">{{=it.data.website || ""}}</span>
		</p>
		<p>
			<span class="hm-label">公司简介:</span>
			<span class="hm-content">{{=it.data.introduction || ""}}</span>
		</p>
		<p>
			<span class="hm-label">已入驻服务:</span>
			<span class="hm-content">
				{{? it.data.statusRecommend == 0}}企业推介
				{{?? it.data.statusManufacture == 0}}智能制造
				{{?? it.data.statusTalent == 0}}人才服务
				{{?? it.data.statusFinancing == 0}}融资服务
				{{?? it.data.statusLogistics == 0}}物流服务
				{{??}}暂未入驻服务{{?}}
			</span>
		</p>
	</div>
</div>
<div class="line-break">{{=it.data.content}}</div>
</script>

<script>
;(function() {
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(1);
	
	var id = $k.util.getRequestParam("id");
	if(id == "" || id == null) {
		return;
	}
	
	$.ajax({
		url: "recommend/company/detail",
		type: "POST",
		data: {companyId: id},
		success: function(data) {
			if(data.status == 0) {
				$content.find(".recommendinfo").html($(".template.RecommendInfo").doT({
					data: data.data
				}));
			}
		},
		error: function(e) {}
	});
	
})();
</script>
</html>