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
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>

</head>
<body>
	<div id="page">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
			<div class="banner"><img alt="融资服务" src="./img/banner-financing.jpg"></div>
		
			<div class="nav-wraper"></div>
			<div class="policy-container">
				<div class="weizhi">
					<ul style="margin-bottom: 10px;">
					    <li><a href="" target="_blank">融资服务</a></li>
					    <li class="active">国家政策</li>
					</ul>
				</div>
				<div class="policy-content">
					<div class="policy-list">
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

<script class="template PolicyList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data: data}}
	<li>
		<div class="title ellipsis" title="{{=data.title}}"><a href="{{="dynamicinfo?id=" + data.id + "&type=4"}}" target="_blank">{{=$k.util.cutString(data.title, 60)}}</a></div>
		<div class="content ellipsis">{{=$k.util.cutString(data.content.replace(/<[^>]+>/g,""), 100)}}</div>
		<div class="color-9 time">发布时间：{{=new Date(data.createTime).format("yyyy-mm-dd")}}</div>
	</li>
	{{~}}
</ul>
</script>

<script>
;(function() {
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(4);
	$content.find(".nav-wraper").html($(".template.NavBar").doT({
		subnv: 3
	}));
	$.ajax({
		url: "financing/policy/listPaging",
		type: "POST",
		data: {
			page: 0,
			size: $k.config.paginator.pageSize
		},
		success: function(data) {
			if(data.status == 0 && data.data.content.length != 0) {
				$content.find(".policy-list").html($(".template.PolicyList").doT({
					data: data.data.content
				}));
				var options = $k.config.paginator.options;
				options.totalPages = data.data.totalPages;
				options.onPageClicked = function (event, originalEvent, type, page) { //异步换页
		        	$.ajax({
		        		url: "financing/policy/listPaging",
		        		type: "POST",
		        		data: {
		        			page: page - 1,
		        			size: $k.config.paginator.pageSize
		        		},
		        		success: function(data) {
		        			if(data.status == 0) {
		        				$content.find(".policy-list").html($(".template.PolicyList").doT({
		        					data: data.data.content
		        				}));
		        			}
		        		}
		        	});
				};
				$(".pager_container ul").bootstrapPaginator(options);
			}
		},
		error: function(e) {}
	});
	
})();
</script>
</html>