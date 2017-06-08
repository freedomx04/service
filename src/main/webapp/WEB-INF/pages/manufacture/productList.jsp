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
.productList li {
	padding: 10px;
	margin-top: 10px;
	border: 1px solid #ededed;
}
.productList .img-wrapper {
	width: 190px;
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
					    <li><a href="product" target="_blank">智能产品</a></li>
					    <li class="active" id="clazz"></li>
					    <li class="active" id="subClazz"></li>
					</ul>
				</div>
				<div class="list">
					<div class="template-wraper">
						<div class="productList">
						</div>
					</div>
					<div class="pager_container">
						<ul></ul>
					</div>
				</div>
			</div>
		</div>
		
		<div id="footer">
		</div>
	</div>
</body>

<script class="template ProductList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data: data}}
	<li style="padding: 0;">
		<div class="row" style="padding: 10px;">
			<div class="col-md-3 col-xs-3 img-wrapper"><img src="{{="./" + data.imagePath}}" style="width: 100%;"></div>
			<div class="col-md-9 col-xs-9">
				<div class="ellipsis" style="font-size: 16px; padding: 10px 0;"><a href="{{="productinfo?id=" + data.id + "&clazz=" + data.clazz + "&subClazz=" + data.subClazz}}" target="_blank" style="color: #3b8cff;" title="{{=data.name}}">{{=data.name}}</a></div>
				<div>{{=data.introduction}}</div>
			</div>
		</div>
		<div class="row" style="margin: 20px 0 0 0; text-align: center; border-top: 1px solid #ddd; line-height: 30px;">
			<div class="col-md-4 col-xs-4" style="border-right: 1px solid #ddd; padding: 5px;">
				<div>报价</div>
				<div style="color: #fd5f39;">¥{{=data.price}}</div>
			</div>
			<div class="col-md-4 col-xs-4" style="border-right: 1px solid #ddd; padding: 5px;">
				<div>产地</div>
				<div>{{=data.location}}</div>
			</div>
			<div class="col-md-4 col-xs-4" style="border-right: 1px solid #ddd; padding: 5px;">
				<div>公司名称</div>
				<div class="ellipsis"><a class="hm-a" href="{{="manufacCompany?id=" + data.company.id}}" target="_blank">{{=data.company.name}}</a></div>
			</div>
		</div>
	</li>
	{{~}}
</ul>
</script>

<script>
;(function() {
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(2);
	
	var clazzVlaue = $k.util.getRequestParam("clazz");
	var subClazzValue = $k.util.getRequestParam("subClazz");
	var url = "";
	var param = {
		page: 0,
		size: $k.config.paginator.pageSize
	};
	
	if(clazzVlaue != "") {
		url = "manufacture/product/listByClazzPaging";
		param.clazz = clazzVlaue;
		var clazz = $k.constant.clazz.where('o.value == "' + clazzVlaue + '"')[0].name;
		$content.find("#clazz").html(clazz);
	}
	if(subClazzValue != "") {
		url = "manufacture/product/listBySubClazzPaging";
		param.subClazz = subClazzValue;
		var subClazz = $k.constant.clazz.where('o.value == "' + clazzVlaue + '"')[0].subClazz.where('o.value == "' + subClazzValue + '"')[0].name;
		$content.find("#subClazz").html(subClazz);
	}
	
	$.ajax({
		url: url,
		type: "POST",
		data: param,
		success: function(data) {
			if(data.status == 0) {
				$content.find(".productList").html($(".template.ProductList").doT({
					data: data.data.content
				}));
				if(data.data.content.length == 0) {
					return;
				}
				var options = $k.config.paginator.options;
				options.totalPages = data.data.totalPages;
				options.onPageClicked = function (event, originalEvent, type, page) { //异步换页
					param.page = page - 1;
					$.ajax({
						url: url,
						type: "POST",
						data: param,
						success: function(data) {
							if(data.status == 0) {
								$content.find(".productList").html($(".template.ProductList").doT({
									data: data.data.content
								}));
							}
						},
						error: function(err) {}
					});
				};
				$(".pager_container ul").bootstrapPaginator(options);
			}
		},
		error: function(err) {}
	});
	
})();
</script>
</html>