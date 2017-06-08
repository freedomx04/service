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
<style>
.productType-list {
	min-height: 500px;
	background-color: #fff;
}
.productType-list ol {
	width: 50%;
	float: left;
	padding: 15px 30px;
}
.productType-list ol li:not(:first-child) a {
	color: #666;
} 
.productType-list ol li a:hover {
	color: #fd5f39;
}
.productType-list ol li:not(:first-child) {
	float: left;
	font-size: 12px;
}
.productType-list ol li span {
	margin-right: 10px;
	margin-left: 10px;
	color: #ddd;
}
.productType-list ol li.title {
	font-size: 16px;
	font-weight: bold;
    margin-bottom: 10px;
    text-indent: 1em;
}
.productType-list ol li.title a {
	color: #000;
}
</style>

<title></title>

<%@ include file="/WEB-INF/include/html_head_preload.jsp"%>
<%@ include file="/WEB-INF/template/top.jsp"%>
<%@ include file="/WEB-INF/template/footer.jsp"%>
<%@ include file="/WEB-INF/template/menu.jsp"%>
<%@ include file="/WEB-INF/template/manufacture/manufacture_top.jsp"%>
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>

</head>
<body>
	<div id="page">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
			<div class="banner"><img alt="智能制造" src="./img/banner-manufacture.jpg"></div>
		
			<div class="nav-wraper"></div>
			<div class="content">
				<div class="weizhi">
					<ul style="margin-bottom: 10px;">
					    <li><a href="bulletin" target="_blank">智能制造</a></li>
					    <li class="active">智能产品</li>
					</ul>
				</div>
				<div class="list">
					<div class="template-wraper">
					</div>
					<div class="pager_container">
						<ul></ul>
					</div>
				</div>
			</div>
		</div>
		
		<div id="footer"></div>
	</div>
</body>

<script class="template ProductTypeList" type="text/x-jquery-tmpl">
<div class="productType-list">
	<ul class="row">
		{{~it.data: clazz: index}}
		<ol class="col-xs-12">
			<li class="title"><a href="{{="productList?clazz=" + clazz.value}}">{{=clazz.name}}</a></li>
			{{~clazz.subClazz: subClazz:i}}
				{{? clazz.subClazz.length != i + 1 }}
				<li><a href="{{="productList?clazz="+ clazz.value +"&subClazz=" + subClazz.value}}">{{=subClazz.name}}</a><span>|</span></li>
				{{??}}
				<li><a>{{=subClazz.name}}</a></li>
				{{?}}
			{{~}}
		</ol>
		{{~}}
	</ul>
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
	
	
	$content.find(".template-wraper").html($(".template.ProductTypeList").doT({
		data: $k.constant.clazz
	}));
	
})();
</script>
</html>