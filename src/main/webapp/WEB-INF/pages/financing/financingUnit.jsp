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
			<div class="main_container financingUnit-container">
				<div class="weizhi">
					<ul style="margin-bottom: 10px;">
					    <li><a href="" target="_blank">融资服务</a></li>
					    <li class="active">服务单位</li>
					</ul>
				</div>
				<div class="financingUnit-content">
					<div class="unit-list">
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

<script class="template UnitList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data: data}}
	<li class="row">
		<div class="col-md-3 col-xs-2 img-wraper">
			<a href="{{="financingCompany?id=" + data.id}}" target="_blank"><img src="{{=data.imagePath}}" width="160" height="120"></a>
		</div>
		<div class="col-md-7 col-xs-6">
			<div title="{{=data.name}}">
				<a class="hm-a" href="{{="financingCompany?id=" + data.id}}" target="_blank">
					{{=$k.util.cutString(data.name, 65)}}
					<i class="company_mark" title="该企业已上传营业执照并通过资质验证审核"></i>
				</a>
			</div>
			<div titile="{{=data.introduction}}" class="ellipsis content"><span>{{=data.introduction}}</span></div>
			<div>
				<span><span class="color-9 caption">企业规模：</span>{{=$k.constant.scale[data.scale].name}}</span>
				<span><span class="color-9 caption">企业性质：</span>{{=$k.constant.property[data.property].name}}</span>
				<span><span class="color-9 caption">企业地址：</span>{{=data.address}}</span>
			</div>
		</div>
		<div class="col-md-2 col-xs-3 evaluation">
			<span class="text">评分：</span>
			<span class="stars">
				{{for(var i = 0; i<data.score; i++) { }}
					<span class="glyphicon glyphicon-star"></span>
				{{ } }}
				{{for(var i = 0; i<5-data.score; i++) { }}
					<span class="glyphicon glyphicon-star-empty"></span>
				{{ } }}
			</span>
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
	new $k.proto.Menu().init($("#top .menu")).draw(4);
	$content.find(".nav-wraper").html($(".template.NavBar").doT({
		subnv: 4
	}));
	
	
	$.ajax({
		url: "financing/company/listPaging",
		type: "POST",
		data: {
			page: 0,
			size: $k.config.paginator.pageSize
		},
		success: function(data) {
			if(data.status == 0) {
				$content.find(".unit-list").html($(".template.UnitList").doT({
					data: data.data.content
				}));
				
				var options = $k.config.paginator.options;
				options.totalPages = data.data.totalPages;
				options.onPageClicked = function (event, originalEvent, type, page) { //异步换页
		        	$.ajax({
		        		url: "financing/company/listPaging",
		        		type: "POST",
		        		data: {
		        			page: page - 1,
		        			size: $k.config.paginator.pageSize
		        		},
		        		success: function(data) {
		        			if(data.status == 0) {
		        				$content.find(".unit-list").html($(".template.UnitList").doT({
		        					data: data.data.content,
		        				}));
		        			}
		        		}
		        	})
		        };
				$(".pager_container ul").bootstrapPaginator(options);
			}
		},
		error: function(e) {}
	});
	
})();
</script>
</html>