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
					<ul>
					    <li><a href="" target="_blank">智能制造</a></li>
					    <li class="active">智能快报</li>
					</ul>
				</div>
				<div class="list bulletin-list">
					<div class="subnav">
						<ul>
						</ul>
					</div>
					<div class="list-content">
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

<script class="template BulletinList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data:data}}
	<li class="row">
		<div class="col-md-3 col-xs-3 img-wraper">
			<a href="{{="dynamicinfo?id=" + data.id + "&type=2&subType=bulletin"}}" target="_blank"><img alt="" src="{{="./" + data.imagePath}}"></a>
		</div>
		<div class="col-md-9 col-xs-9 item-right">
			<div class="title ellipsis" title="{{=data.title}}"><a href="{{="dynamicinfo?id=" + data.id + "&type=2&subType=bulletin"}}" target="_blank">{{=$k.util.cutString(data.title, 60)}}</a></div>
			<div class="content ellipsis">{{=$k.util.cutString(data.content.replace(/<[^>]+>/g,""), 150)}}</div>
			<div class="color-9">发布时间：{{=new Date(data.createTime).format("yyyy-mm-dd")}}</div>
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
	$content.find(".nav-wraper").html($(".template.NavBar").doT({
		subnv: 1
	}));
	
	var bulletinType = $k.constant.bulletinType;
	$.each(bulletinType, function(ky, vl) {
		var html = "";
		if(ky == 0) {
			html = '<li><a id="'+ vl.value +'" class="active">'+ vl.name +'</a></li>'
		} else {
			html = '<li><a id="'+ vl.value +'">'+ vl.name +'</a></li>'
		}
		$(html).appendTo($content.find(".subnav ul"));
	});
	
	getList(0);
	
	$content.on("click", ".subnav li a", function() {
		var $this = $(this);
		$this.closest("ul").find("li a").removeClass("active");
		$this.addClass("active");
		var type = $this.attr("id");
		
		getList(type);
	});
})();

function getList(type) {
	$.ajax({
		url: "manufacture/bulletin/listByTypePaging",
		type: "POST",
		data: {
			type: type,
			page: 0,
			size: $k.config.paginator.pageSize
		},
		success: function(data) {
			if(data.status == 0) {
				$(".list-content").html($(".template.BulletinList").doT({
					data: data.data.content
				}));
				if(data.data.content.length == 0) {
					return;
				}
				var options = $k.config.paginator.options;
				options.totalPages = data.data.totalPages;
				options.onPageClicked = function (event, originalEvent, type, page) { //异步换页
					$.ajax({
						url: "manufacture/bulletin/listByTypePaging",
						type: "POST",
						data: {
							type: type,
							page: page - 1,
							size: $k.config.paginator.pageSize
						},
						success: function(data) {
							if(data.status == 0) {
								$(".list-content").html($(".template.BulletinList").doT({
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
}
</script>
</html>