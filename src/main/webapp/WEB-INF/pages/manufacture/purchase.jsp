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
/* 供应信息 */
.offer-list {
	min-height: 450px;
}
.offer-list li {
	min-height: 120px;
	padding: 5px;
	margin: 5px 5px 10px 5px;
	border: 1px solid #ededed;
}
.offer-list li > div {
	padding-right: 0;
}
.offer-list li:not(:first-child) {
	margin-top: 5px;
}
.offer-list .product-list {
	line-height: 2rem;
}
.offer-list .company, .purchase-list .time {
	line-height: 60px;
}
.purchase-list ul li {
    line-height: 30px;
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
			<div class="banner"><img alt="智能制造" src="./img/banner-manufacture.jpg"></div>
		
			<div class="nav-wraper"></div>
			<div class="content">
				<div class="weizhi">
					<ul>
					    <li><a href="bulletin" target="_blank">智能制造</a></li>
					    <li class="active">供求商机</li>
					</ul>
				</div>
				<div class="list">
					<div class="subnav">
						<ul>
							<li><a id="nav1" class="active">供应信息</a></li>
							<li><a id="nav2">求购信息</a></li>
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

<script class="template OfferList" type="text/x-jquery-tmpl">
<div class="offer-list">
	<ul>
		{{~it.data: data}}
		<li class="row">
			<div class="col-md-3 col-xs-3 img-wraper">
				<img alt="" src="{{="./" + data.imagePath || ""}}">
			</div>
			<div class="col-md-6 col-xs-6 product-list">
				<div class="product-name" title="{{=data.name}}"><a class='hm-a' href="{{="offerinfo?id=" + data.id}}" target="_blank">{{=$k.util.cutString(data.name, 60)}}</a></div>
				<div class="product-price"><span class="color-9">价格：</span><span class="color-org">{{=data.price}}</span></div>
				<div class="product-address ellipsis" title="{{=data.location}}"><span class="color-9">所在地：</span><span>{{=data.location}}</span></div>
				<div class="product-quantity"><span class="color-9">起订量：</span><span>{{=data.lowest}}</span></div>
				<div class="product-total"><span class="color-9">供货总量：</span><span>{{=data.total}}</span></div>
			</div>
			<div class="col-md-3 col-xs-3" style="text-align: center; padding-right: 0;">
				<div class="company ellipsis">
					<a class='hm-a' href="{{="manufacCompany?id=" + data.company.id}}" target="_blank">
						{{=$k.util.cutString(data.company != null ? data.company.name : "", 25)}}
					</a>
					<i class="company_mark" title="该企业已上传营业执照并通过资质验证审核"></i>
				</div>
				<div class="time">{{=new Date(data.createTime).format("yyyy-mm-dd")}}</div>
			</div>
		</li>
		{{~}}
	</ul>
</div>
</script>

<script class="template PurchaseList" type="text/x-jquery-tmpl">
<div class="purchase-list">
	<div class="row">
		<div class="col-md-3 col-xs-3">采购信息</div> 
		<div class="col-md-3 col-xs-3">采购数量</div> 
		<div class="col-md-3 col-xs-3">所在地</div> 
		<div class="col-md-3 col-xs-3">发布时间</div>
	</div>
	<ul> 
		{{~it.data: data}}
		<li class="row"> 
			<ol class="col-md-3 col-xs-3 ellipsis" title="{{=data.name}}"><a class='hm-a' href="purchaseinfo?id={{=data.id}}" target="_blank">{{=data.name}}</a></ol> 
			<ol class="col-md-3 col-xs-3 ellipsis" title="{{=data.num}}">{{=data.num}}</ol> 
			<ol class="col-md-3 col-xs-3 ellipsis" title="{{=data.location}}">{{=data.location}}</ol>
			<ol class="col-md-3 col-xs-3">{{=new Date(data.createTime).format("yyyy-mm-dd")}}</ol> 
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
		subnv: 2
	}));
	
	var nav = $k.util.getRequestParam("nav");
	var url = "manufacture/offer/listPaging";
	var $template = $(".template.OfferList");
	
	if(nav == "2") {
		url = "manufacture/purchase/listPaging";
		$template = $(".template.PurchaseList");
		$content.find(".subnav li a").removeClass("active");
		$content.find("#nav2").addClass("active");
	}
	getList(url, $template);
	
	$content.on("click", ".subnav li a", function() {
		var $this = $(this);
		var id= $this.attr("id");
		
		$this.closest("ul").find("li a").removeClass("active");
		$this.addClass("active");
		
		if(id == "nav1") {
			url = "manufacture/offer/listPaging";
			$template = $(".template.OfferList");
		} else if(id == "nav2") {
			url = "manufacture/purchase/listPaging";
			$template = $(".template.PurchaseList");
		}
		getList(url, $template);
	});
})();
function getList(url, $template) {
	$(".template-wraper").html("");
	$.ajax({
		url: url,
		type: "POST",
		data: {
			page: 0,
			size: $k.config.paginator.pageSize
		},
		success: function(data) {
			if(data.status == 0) {
				$(".template-wraper").html($template.doT({
					data: data.data.content
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
								$(".template-wraper").html($template.doT({
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