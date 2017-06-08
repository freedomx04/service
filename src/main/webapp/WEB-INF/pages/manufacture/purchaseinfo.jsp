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
<%@ include file="/WEB-INF/template/manufacture/manufacture_top.jsp"%>
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>
<style>
.purchaseinfo-content {
	padding: 30px;
}
.purchaseinfo-content .product-name {
	font-size: 20px;
	font-weight: bold;
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
			<div class="content">
				<div class="weizhi">
					<ul style="margin-bottom: 10px;">
					    <li><a href="bulletin" target="_blank">智能制造</a></li>
					    <li><a href="purchase" target="_blank">供求商机</a></li>
					    <li><a href="purchase?nav=2" target="_blank">求购信息</a></li>
					    <li class="active">求购信息详情</li>
					</ul>
				</div>
				<div class="purchase-info">
					<div class="purchaseinfo-content">
					</div>
				</div>
			</div>
		</div>
		
		<div id="footer">
		</div>
	</div>
</body>

<script class="template PurchaseInfo" type="text/x-jquery-tmpl">
<div class="product-name line-break">{{=it.data.name}}</div>
<div class="panel panel-default" style="margin-top: 30px;">
	<div class="panel-heading">
		<i class="fa fa-info-circle fa-fw"></i>主要信息
	</div>
	<div class="panel-body" style="line-height: 30px; font-size: 16px;">
		<div>
			<span class="title">发布时间：</span>
			{{=new Date(it.data.createTime).format("yyyy-mm-dd")}}
		</div>
		<div>
			<span class="title">备注说明：</span>
			{{=it.data.description}}
		</div>
	</div>
</div>

<div class="panel panel-default" style="margin-top: 30px;">
	<div class="panel-heading">
		<i class="fa fa-info-circle fa-fw"></i>其他信息
	</div>
	<div class="panel-body" style="line-height: 30px; font-size: 16px;">
		<div>
			<span class="title">采购数量：</span>
			{{=it.data.num}}
		</div>
		<div>
			<span class="title">所在地：</span>
			{{=it.data.location}}
		</div>
	</div>
</div>

<div class="panel panel-default" style="margin-top: 30px;">
	<div class="panel-heading">
		<i class="fa fa-info-circle fa-fw"></i>联系人
	</div>
	<div class="panel-body" style="line-height: 30px; font-size: 16px;">
		<div>
			<span class="title">联系人：</span>
			{{=it.data.contactUser}}
		</div>
		<div>
			<span class="title">联系电话：</span>
			{{=it.data.contact}}
		</div>
	</div>
</div>
</script>

<script>
;(function() {
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(2);
	
	var id = $k.util.getRequestParam("id");
	if(id == "" || id == null) {
		return;
	}
	
	$.ajax({
		url: "manufacture/purchase/detail",
		type: "POST",
		data: {
			purchaseId: id
		},
		success: function(data) {
			if(data.status == 0) {
				$content.find(".purchaseinfo-content").html($(".template.PurchaseInfo").doT({
					data: data.data
				}));
			}
		},
		error: function(e) {}
	});
})();
</script>
</html>