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
<%@ include file="/WEB-INF/template/logistics/logistics_top.jsp"%>
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>

<style>
.dynamicinfo-content {
	padding: 10px;
}
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

<script class='template DynamicInfo' type='text/x-jquery-tmpl'>
<div class="top">
	<div class="line-break" style="font-size: 20px;">{{=it.data.title}}</div>
	<div>
		<span style="margin-right: 30px;"><span class="color-9">发布时间：</span><span>{{=$k.util.getDateString(it.data.createTime)}}</span></span>
		<span><span class="color-9">来源：</span><span class="line-break">{{=it.data.source}}</span></span>
	</div>
</div>
<div class="line-break">{{=it.data.content}}</div>
</script>

<script>
;(function() {
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	
	var id = $k.util.getRequestParam("id");
	if(id == "" || id == null) {
		return;
	}
	
	var type = $k.util.getRequestParam("type");
	var subType = $k.util.getRequestParam("subType");
	var url = "";
	var data = {dynamicId: id};
	
	new $k.proto.Menu().init($("#top .menu")).draw(type);
	
	if(type == 5) {
		$content.find(".weizhi ul").html('<li><a href="supply" target="_blank">物流服务</a></li>'+
	    '<li><a href="logisticsDynamic" target="_blank">服务动态</a></li>'+
	    '<li class="active">动态详情</li>');
		url = "logistics/dynamic/detail";
		data.dynamicId = id;
	} else if(type == 2) {
		if(subType != "" && subType != null) {
			var subTypeString = "";
			var url = "";
			switch(subType) {
				case "bulletin":
					subTypeString = "智能快讯";
					data = {bulletinId: id};
					url = "bulletin";
					break;
				case "solution":
					subTypeString = "解决方案";
					data = {solutionId: id};
					url = "successcase";
					break;
				case "case":
					subTypeString = "成功案例";
					data = {caseId: id};
					url = "successcase?nav=2";
					break;
			}
			$content.find(".weizhi ul").html('<li><a href="bulletin" target="_blank">智能制造</a></li>'+
		    '<li><a href="'+ url +'" target="_blank">'+ subTypeString +'</a></li>'+
		    '<li class="active">新闻详情</li>');
			url = "manufacture/"+ subType +"/detail";
		}
	} else if(type == 1) {
		$content.find(".weizhi ul").html('<li><a href="recommend?nav=1" target="_blank">企业推介</a></li>'+
			    '<li><a href="recommend?nav=2" target="_blank">企业动态</a></li>'+
			    '<li class="active">动态详情</li>');
				url = "recommend/dynamic/detail";
				data.dynamicId = id;
	} else if(type == 4) {
		$content.find(".weizhi ul").html('<li><a href="financing" target="_blank">融资服务</a></li>'+
			    '<li><a href="policy" target="_blank">国家政策</a></li>'+
			    '<li class="active">政策详情</li>');
				url = "financing/policy/detail";
				data.policyId = id;
	}
	
	$.ajax({
		url: url,
		type: "POST",
		data: data,
		success: function(data) {
			if(data.status == 0) {
				$content.find(".dynamicinfo-content").html($(".template.DynamicInfo").doT({
					data: data.data
				}));
			}
		},
		error: function(e) {}
	});
	
})();
</script>
</html>