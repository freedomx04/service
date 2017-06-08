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
.productinfo-top {
	margin-bottom: 20px;
}
.productinfo-top table tr{
	line-height: 30px;
}
.product-name {
	font-size:2.5rem;
}
.product-price {
	font-size: 2rem;
	color:#fd5f39;
}
.tiny-productinfo-table {
	display: none;
}
</style>
</head>
<body>
	<div id="page">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="manufacture-productinfo content-container">
			<div class="nav-wraper">
			</div>
			<div class="content">
				<div class="weizhi">
					<ul style="margin-bottom: 10px;">
					    <li><a href="bulletin" target="_blank">智能制造</a></li>
					    <li><a href="product" target="_blank">智能产品</a></li>
					    <li class="active" id="clazz"></li>
					    <li class="active" id="subClazz"></li>
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
<div class="productinfo-top row">
	<div class="col-md-3 col-xs-4 img-wrapper"><img src="{{="./" + it.data.imagePath}}"></div>
	<div class="col-md-9 col-xs-8">
		<table class="tiny-productinfo-table">
			<tbody>
				<tr><td class="product-name">{{=it.data.name}}</td></tr>
				<tr><td class="color-9">产品报价：</td><td> ¥ <span class="product-price color-org">{{=it.data.price}} </span>元</td></tr>
				<tr><td class="color-9">更新时间：</td><td> {{=new Date(it.data.updateTime).format("yyyy-mm-dd")}}</td></tr>
				<tr><td class="color-9">产品类别：</td><td> {{=$k.constant.clazz[it.data.clazz - 1].name + "--" + (it.data.subClazz != null ? $k.constant.clazz[it.data.clazz].subClazz[parseInt(it.data.subClazz.toString().substring(1)) - 1].name : "")}}</td></tr>
				<tr><td class="color-9">型号：</td><td> {{=it.data.model}}</td></tr>
				<tr><td class="color-9">厂商性质：</td><td>{{=$k.constant.manufactureProperty[it.data.property].name}}</td></tr>
				<tr><td class="color-9">所在地：</td><td> {{=it.data.location}}</td></tr>
				<tr><td class="color-9">产地：</td><td> {{=it.data.origin}}</td></tr>
			</tbody>
		</table>
		<table class="m-hidden">
			<tbody>
				<tr><td class="product-name">{{=it.data.name}}</td></tr>
				<tr>
					<td class="color-9">产品报价：</td><td> ¥ <span class="product-price">{{=it.data.price}} </span>元</td>
					<td class="color-9" style="padding-left: 20px;">更新时间：</td><td> {{=new Date(it.data.updateTime).format("yyyy-mm-dd")}}</td>
				</tr>
				<tr>
					<td class="color-9">产品类别：</td><td> {{=$k.constant.clazz[it.data.clazz - 1].name + "　　" + (it.data.subClazz != null ? $k.constant.clazz[it.data.clazz].subClazz[parseInt(it.data.subClazz.toString().substring(1)) - 1].name : "")}}</td>
					<td class="color-9" style="padding-left: 20px;">型号：</td><td> {{=it.data.model}}</td>
				</tr>
				<tr>
					<td class="color-9">厂商性质：</td><td>{{=$k.constant.manufactureProperty[it.data.property].name}}</td>
					<td class="color-9" style="padding-left: 20px;">所在地：</td><td> {{=it.data.location}}</td>
				</tr>
				<tr><td class="color-9">产地：</td><td> {{=it.data.origin}}</td></tr>
			</tbody>
		</table>
	</div>
</div>

<div class="productinfo-bottom row">
	<div class="left pull-left col-md-8 col-xs-12">
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
	$content.find(".nav-wraper").html($(".template.NavBar").doT({
		subnv: 3
	}));
	
	var clazzVlaue = $k.util.getRequestParam("clazz");
	var clazz = (clazzVlaue != "" ? $k.constant.clazz[parseInt(clazzVlaue) - 1].name : "");
	var subClazzValue = $k.util.getRequestParam("subClazz");
	var subClazz = subClazzValue != "" ? $k.constant.clazz[parseInt(clazzVlaue)].subClazz[parseInt(subClazzValue.substring(1)) - 1].name : ""
	$content.find("#clazz").html(clazz);
	$content.find("#subClazz").html(subClazz);
			
	var id = $k.util.getRequestParam("id");
	if(id == "" || id == null) {
		return;
	}
	$.ajax({
		url: "manufacture/product/detail",
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