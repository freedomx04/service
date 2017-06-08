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
<title></title>

<%@ include file="/WEB-INF/include/html_head_preload.jsp"%>
<%@ include file="/WEB-INF/template/top.jsp"%>
<%@ include file="/WEB-INF/template/footer.jsp"%>
<%@ include file="/WEB-INF/template/menu.jsp"%>
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>

<style>
.img-wraper, .productinfo {
	display: inline-block;
}
.product-intro, .product-otherinfo {
    line-height: 30px;
}
.product-name {
	line-height: 30px;
	font-size: 16px;
}
.product-name a {
	color: #3b8cff;
}
.product-otherinfo > span:not(:last-child) {
    margin-right: 30px;
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
			<div class="banner"><img alt="企业推介" src="./img/banner-recommend.jpg"></div>
		
			<div class="nav-wraper">
				<div class="nav-bar">
					<ul class="nav nav-pills">
					  <li id="company" class="active"><a>企业推介</a></li>
					  <li id="dynamic"><a>企业动态</a></li>
					  <li id="product"><a>产品中心</a></li>
					</ul>
				</div>
			</div>
			
			<div class="recommend-container">
			
				<div class="weizhi">
					<ul style="margin-bottom: 10px;">
					    <li><a href="recommend" target="_blank">企业推介</a></li>
					    <li id="current" class="active">企业列表</li>
					</ul>
				</div>
				
				<div class="recommend-content">
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

<script class="template RecommendCompanyList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data: data}}
	<li class="row">
		<div class="col-md-3 col-xs-3 img-wraper">
			<a href="{{="recommendinfo?id=" + data.id}}" target="_blank"><img src="{{=data.imagePath}}"></a>
		</div>
		<div class="col-md-9 col-xs-9 item-right">
			<div title="{{=data.name}}">
				<a class="hm-a" href="{{="recommendinfo?id=" + data.id}}" target="_blank">
					{{=$k.util.cutString(data.name, 90)}}
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
	</li>
	{{~}}
</ul>
</script>

<script class="template RecommendDynamicList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data:data}}
	<li class="row">
		<div class="col-md-9 col-xs-9">
			<div class="title ellipsis" title="{{=data.title}}"><a href="{{="dynamicinfo?id=" + data.id + "&type=1"}}" target="_blank">{{=$k.util.cutString(data.title, 60)}}</a></div>
			<div class="content ellipsis">{{=$k.util.cutString(data.content.replace(/<[^>]+>/g,""), 150)}}</div>
			<div class="color-9 time">发布时间：{{=new Date(data.createTime).format("yyyy-mm-dd")}}</div>
		</div>
		<div class="col-md-3 col-xs-3 ellipsis company-name">
			<a class="hm-a" href="{{="recommendinfo?id=" + data.company.id}}" target="_blank">{{=$k.util.cutString(data.company.name, 25)}}</a>
			<i class="company_mark" title="该企业已上传营业执照并通过资质验证审核"></i>
		</div>
	</li>
	{{~}}
</ul>
</script>

<script class="template RecommendProductList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data: data}}
	<li class="row">
		<div class="img-wraper col-md-3 col-xs-3">
			<a href="{{="recommProductInfo?id=" + data.id}}" target="_blank"><img alt="" src="{{="./" + data.imagePath}}"></a>
		</div>
		<div class="productinfo col-md-9 col-xs-9 item-right">
			<div class="product-name" id="" title="{{=data.name}}"><a href="{{="recommProductInfo?id=" + data.id}}" target="_blank">{{=$k.util.cutString(data.name, 60)}}</a></div>
			<div class="product-intro ellipsis content">
				<span>{{=data.introduction}}</span>
			</div>
			<div class="product-otherinfo">
				<span class="product-type" title="{{=data.model}}"><span class="color-9">产品型号：</span><span>{{=$k.util.cutString(data.model, 30)}}</span></span>
				<span class="product-address" title=" {{=data.location}}"><span class="color-9">所在地：</span><span>{{=$k.util.cutString(data.location, 30)}}</span></span>
				<span class="product-time"><span class="color-9">更新时间：</span>{{=new Date(data.updateTime).format("yyyy-mm-dd")}}</span>
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
	new $k.proto.Menu().init($("#top .menu")).draw(1);
	
	var url = "";
	var $template = null;
	var nav = $k.util.getRequestParam("nav");
	if (nav == 2) {
		url = "recommend/dynamic/listPaging";
		$template = $(".template.RecommendDynamicList");
		$content.find(".weizhi #current").html("企业动态");
	} else if (nav == 3) {
		url = "recommend/product/listPaging";
		$template = $(".template.RecommendProductList");
		$content.find(".weizhi #current").html("产品中心");
	} else {
		url = "recommend/company/listPaging";
		$template = $(".template.RecommendCompanyList");
		$content.find(".weizhi #current").html("企业推介");
	}
	getList(url, $template)
	
	$content.on("click", ".nav li", function() {
		var $this = $(this);
		$this.closest("ul").find("li").removeClass("active");
		$this.addClass("active");
		var id = $this.attr("id");
		
		if(id == "company") {
			url = "recommend/company/listPaging";
			$template = $(".template.RecommendCompanyList");
			$content.find(".weizhi #current").html("企业推介");
		} else if(id == "dynamic") {
			url = "recommend/dynamic/listPaging";
			$template = $(".template.RecommendDynamicList");
			$content.find(".weizhi #current").html("企业动态");
		} else {
			url = "recommend/product/listPaging";
			$template = $(".template.RecommendProductList");
			$content.find(".weizhi #current").html("产品中心");
		}
		getList(url, $template);
	});
	
	// visit
	$.ajax({
		url: 'visit/add',
		type: 'POST',
		success: function(data) {},
		error: function(data) {}
	});
	
})();

function getList(url, $template) {
	var $recommList = $(".unit-list");
	$recommList.html("");
	$.ajax({
		url: url,
		type: "POST",
		data: {
			page: 0,
			size: $k.config.paginator.pageSize
		},
		success: function(data) {
			if(data.status == 0 && data.data.content.length != 0) {
				$recommList.html($template.doT({
					data: data.data.content
				}));
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
								$recommList.html($template.doT({
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