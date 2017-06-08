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
					<ul style="margin-bottom: 10px;">
					    <li><a href="bulletin" target="_blank">智能制造</a></li>
					    <li class="active">成功案例</li>
					</ul>
				</div>
				<div class="list">
					<div class="subnav">
						<ul>
							<li><a id="nav1" class="active">解决方案</a></li>
							<li><a id="nav2">成功案例</a></li>
						</ul>
					</div>
					<div class="template-wraper">
					</div>
					<div class="pager_container">
						<ul>
							
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div id="footer"></div>
	</div>
</body>

<script class="template CaseList" type="text/x-jquery-tmpl">
<div class="successcase-list">
	<ul>
		{{~it.data:data}}
		<li class="row">
			<div class="col-md-9 col-xs-9">
				<div class="title" title="{{=data.title}}"><a href="{{="dynamicinfo?id=" + data.id + "&type=2&subType=" + it.subType}}" target="_blank">{{=$k.util.cutString(data.title, 70)}}</a></div>
				<div class="content">{{=$k.util.cutString(data.content.replace(/<[^>]+>/g,""), 150)}}</div>
				<div class="color-9 time">发布时间：{{=new Date(data.createTime).format("yyyy-mm-dd")}}</div>
			</div>
			<div class="col-md-3 col-xs-3 ellipsis company-name">
				<a class="hm-a" href="{{="manufacCompany?id=" + data.company.id}}" target="_blank">{{=$k.util.cutString(data.company.name, 25)}}</a>
				<i class="company_mark" title="该企业已上传营业执照并通过资质验证审核"></i>
			</div>
		</li>
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
		subnv: 4
	}));
	
	var url = "";
	var subType = "";
	var nav = $k.util.getRequestParam("nav");
	if(nav == "2") {
		url = "manufacture/case/listPaging";
		var subType = "case";
		$content.find(".subnav li a").removeClass("active");
		$content.find("#nav2").addClass("active");
	} else {
		url = "manufacture/solution/listPaging";
		var subType = "solution";
		$content.find(".subnav li a").removeClass("active");
		$content.find("#nav1").addClass("active");
	}
	
	getList(url, subType);
	
	$content.on("click", ".subnav li a", function() {
		var $this = $(this);
		var id= $this.attr("id");
		
		$this.closest("ul").find("li a").removeClass("active");
		$this.addClass("active");
		
		if(id == "nav1") {
			url = "manufacture/solution/listPaging";
			subType = "solution";
		} else if(id == "nav2") {
			url = "manufacture/case/listPaging";
			subType = "case";
		}
		
		getList(url, subType);
	});
})();
function getList(url, subType) {
	$.ajax({
		url: url,
		type: "POST",
		data: {
			page: 0,
			size: $k.config.paginator.pageSize
		},
		success: function(data) {
			if(data.status == 0) {
				$(".template-wraper").html($(".template.CaseList").doT({
					data: data.data.content,
					subType: subType
				}));
				if(data.data.content.length == 0) {
					return;
				}
				var options = $k.config.paginator.options;
				options.totalPages = data.data.totalPages;
				options.onPageClicked = function (event, originalEvent, type, page) { //异步换页
					$.ajax({
						url: url,
						type: "POST",
						data: {
							page: page - 1,
							size: $k.config.paginator.pageSize
						},
						success: function(data) {
							if(data.status == 0) {
								$(".template-wraper").html($(".template.CaseList").doT({
									data: data.data.content,
									subType: subType
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