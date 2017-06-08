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

</head>
<body>
	<div id="page">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
			<div class="banner"><img alt="物流服务" src="./img/banner-logistics.jpg"></div>
		
			<div class="nav-wraper"></div>
			<div class="dynamic-container">
				<div class="weizhi">
					<ul>
					    <li><a href="" target="_blank">物流服务</a></li>
					    <li class="active">服务动态</li>
					</ul>
				</div>
				<div class="dynamic-content">
					<div class="dynamic-list">
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

<script class="template DynamicList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data:data}}
	<li class="row">
		<div class="col-md-9 col-xs-9">
			<div class="title" title="{{=data.title}}"><a href="{{="dynamicinfo?id=" + data.id + "&type=5"}}" target="_blank">{{=$k.util.cutString(data.title, 70)}}</a></div>
			<div class="content">/*{{=$k.util.cutString(data.content.replace(/<[^>]+>/g,""), 150)}}*/</div>
			<div class="color-9">发布时间：{{=new Date(data.createTime).format("yyyy-mm-dd")}}</div>
		</div>
		<div class="col-md-3 col-xs-3 ellipsis company-name">
			<a class="hm-a" href="{{="logisticsCompany?id=" + data.company.id}}" target="_blank">{{=$k.util.cutString(data.company.name, 25)}}</a>
			<i class="company_mark" title="该企业已上传营业执照并通过资质验证审核"></i>
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
	new $k.proto.Menu().init($("#top .menu")).draw(5);
	$content.find(".nav-wraper").html($(".template.NavBar").doT({
		subnv: 4
	}));
	
	$.ajax({
		url: "logistics/dynamic/listPaging",
		type: "POST",
		data: {
			page: 0,
			size: $k.config.paginator.pageSize
		},
		success: function(data) {
			if(data.status == 0 && data.data.content.length != 0) {
				$content.find(".dynamic-list").html($(".template.DynamicList").doT({
					data: data.data.content
				}));
				var options = $k.config.paginator.options;
				options.totalPages = data.data.totalPages;
				options.onPageClicked = function (event, originalEvent, type, page) { //异步换页
		        	$.ajax({
		        		url: "logistics/dynamic/listPaging",
		        		type: "POST",
		        		data: {
		        			page: page - 1,
		        			size: $k.config.paginator.pageSize
		        		},
		        		success: function(data) {
		        			if(data.status == 0) {
		        				$content.find(".dynamic-list").html($(".template.DynamicList").doT({
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