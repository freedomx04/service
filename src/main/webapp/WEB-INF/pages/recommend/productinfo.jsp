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

</head>
<body>
	<div id="page">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
			<div class="nav-wraper">
			</div>
			<div class="content">
				<div class="weizhi">
					<ul style="margin-bottom: 10px;">
					    <li><a href="recommend" target="_blank">企业推介</a></li>
					    <li><a href="recommend?nav=3" target="_blank">产品中心</a></li>
					    <li class="active">产品详情</li>
					</ul>
				</div>
				<div class="product-info">
					<div class="productinfo-content">
					</div>
				</div>
			</div>
		</div>
		
		<div id="footer">
		</div>
	</div>
</body>

<script class="template ProductInfo" type="text/x-jquery-tmpl">
<div class="row" style="margin: 0; padding-bottom: 30px;">
	<div class="col-md-3 col-xs-4 img-wrapper"><img src="{{="./" + it.data.imagePath}}" style="width: 100%;"></div>
	<div class="col-md-9 col-xs-8">
		<div style="color: #3b8cff; font-size: 18px;">{{=it.data.name}}</div>
		<div style="margin-top: 10px;">
			<span class="color-9">产品型号：</span> 
			<span>{{=it.data.model}}</span>
		</div>
		<div style="margin-top: 10px;margin-bottom: 10px;">
			<span class="color-9">所在地：</span> 
			<span>{{=it.data.location}}</span>
		</div>
		<div>
			<span class="color-9">更新时间： </span> 
			<span>{{=new Date(it.data.updateTime).format("yyyy-mm-dd")}}</span>
		</div>
	</div>
</div>

<div class="productinfo-bottom">
	<div class="panel panel-default">
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
		url: "recommend/product/detail",
		type: "POST",
		data: {
			productId: id
		},
		success: function(data) {
			if(data.status == 0) {
				$content.find(".productinfo-content").html($(".template.ProductInfo").doT({
					data: data.data
				}));
			}
		},
		error: function(e) {}
	});
})();
</script>
</html>