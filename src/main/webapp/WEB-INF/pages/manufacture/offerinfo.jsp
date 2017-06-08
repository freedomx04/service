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
.productinfo-top{
	padding: 20px;
	border-bottom: 1px solid #ddd;
    margin-bottom: 10px;
}
.productinfo-top .product-price {
	font-size: 18px;
}
.productinfo-top .product-name {
	font-size: 20px;
	font-weight: bold;
}
.productinfo-bottom .right > div:not(:last-child) {
    margin-bottom: 15px;
}
.productinfo-bottom .right .enterprise-name {
	font-size: 18px;
}
.product-info .left {
    border-right: 1px solid #ddd;
}
.tiny-productinfo-table {
	display: none;
}
table tr {
	line-height: 30px;
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
					    <li><a href="purchase" target="_blank">供应信息</a></li>
					    <li class="active">供应信息详情</li>
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

<script class="template OfferInfo" type="text/x-jquery-tmpl">
<div class="productinfo-top offerinfo-top row" style="line-height: 20px;">
	<div class="col-md-3 col-xs-4"><img src="{{="./" + it.data.imagePath}}"></div>
	<div class="col-md-9 col-xs-8">
		<table class="tiny-productinfo-table">
			<tbody>
				<tr><td class="product-name">{{=it.data.name}}</td></tr>
				<tr><td class="color-9">产品价格：</td><td> ¥ <span class="product-price color-org">{{=it.data.price}} </span>元</td></tr>
				<tr><td class="color-9">产地：</td><td>{{=it.data.origin}}</td></tr>
				<tr><td class="color-9">所在地：</td><td>{{=it.data.location}}</td></tr>
				<tr><td class="color-9">起订量：</td><td>{{=it.data.lowest}}</td></tr>
				<tr><td class="color-9">供货总量：</td><td>{{=it.data.total}}</td></tr>
			</tbody>
		</table>
		<table class="m-hidden">
			<tbody>
				<tr><td class="product-name line-break">{{=it.data.name}}</td></tr>
				<tr>
					<td class="color-9">产品报价：</td><td> ¥ <span class="product-price color-org">{{=it.data.price}} </span>元</td>
					<td class="color-9" style="padding-left: 20px;">产地：</td><td> {{=it.data.origin}}</td>
				</tr>
				<tr>
					<td class="color-9">所在地：</td><td> {{=it.data.location}}</td>
					<td class="color-9" style="padding-left: 20px;">起订量：</td><td> {{=it.data.lowest}}</td>
				</tr>
				<tr>
					<td class="color-9">供货总量：</td><td>{{=it.data.total}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<div class="productinfo-bottom row">
	<div class="left pull-left col-md-8 col-xs-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-info-circle fa-fw"></i>产品详情
			</div>
			<div class="panel-body">
				{{=it.data.description}}
			</div>
		</div>
	</div>
	<div class="right pull-right col-md-4">
		<div class="enterprise-name">
			<a href="{{="manufacCompany?id=" + it.data.company.id}}" target="_blank">{{=it.data.company.name}}</a>
		</div>
		<div><span class="color-9">手   机：</span> {{=it.data.company.contact}}</div>
		<div><span class="color-9">联系人：</span> {{=it.data.company.contactUser}}</div>
		<div><span class="color-9">电    话： </span>{{=it.data.company.phone}}</div>
		<div><span class="color-9">传    真：</span>{{=it.data.company.fax}}</div>
		<div class="color-org">（联系我时，请说明是在广昌服务网上看到的，谢谢！）</div>
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
		url: "manufacture/offer/detail",
		type: "POST",
		data: {
			offerId: id
		},
		success: function(data) {
			if(data.status == 0) {
				$content.find(".productinfo-content").html($(".template.OfferInfo").doT({
					data: data.data
				}));
			}
		},
		error: function(e) {}
	});
})();
</script>
</html>