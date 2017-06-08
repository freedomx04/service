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
.dynamicinfo-content .top {
    text-align: center;
    line-height: 30px;
    padding-bottom: 10px;
    border-bottom: 1px solid #ddd;
    margin-bottom: 20px;
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
					    <li><a href="recommend" target="_blank">企业推介</a></li>
					    <li class="active">企业详情</li>
					</ul>
				</div>
				<div class="dynamicinfo-content">
				</div>
			</div>
		</div>
		
		<div id="footer">
		</div>
	</div>
</body>

<script class='template RecommendInfo' type='text/x-jquery-tmpl'>
<div class="top">
	<div class="line-break" style="font-size: 20px;">{{=it.data.name}}</div>
	<div>
		<span><span class="color-9">发布时间：</span><span>{{=$k.util.getDateString(it.data.createTime)}}</span></span>
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
				$content.find(".dynamicinfo-content").html($(".template.RecommendInfo").doT({
					data: data.data
				}));
			}
		},
		error: function(e) {}
	});
	
})();
</script>
</html>