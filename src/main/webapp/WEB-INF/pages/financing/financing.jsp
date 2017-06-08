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
<title>服务平台-Service Platform</title>

<%@ include file="/WEB-INF/include/html_head_preload.jsp"%>
<%@ include file="/WEB-INF/template/top.jsp"%>
<%@ include file="/WEB-INF/template/footer.jsp"%>
<%@ include file="/WEB-INF/template/menu.jsp"%>
<%@ include file="/WEB-INF/template/financing/financing_top.jsp"%>
<style>
.financing-list li > div {
    line-height: 30px;
}
</style>
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
		    <div class="main_container">
				<div class="filter-wraper">
				</div>
				<div class="list-wrapper">
					<div class="financing-list">
					</div>
					<div class="pager_container">
						<ul></ul>
					</div>
					<span class="no-result hidden">没有找到结果</span>
				</div>
		    </div>
		</div>
		
		<div id="footer"></div>
	</div>
</body>

<script class="template FinancingList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data: data}}
	<li>
		<div class="title ellipsis" title="{{=data.name}}"><a href="{{="financinginfo?id=" + data.id}}" target="_blank">{{=$k.util.cutString(data.name, 60)}}</a></div>
		<div><span title="{{=data.contactUser}}">{{=$k.util.cutString(data.contactUser, 40)}}</span><span title="{{=data.companyName}}" style="margin-left: 30px;">{{=$k.util.cutString(data.companyName, 40)}}</span></div>
		<div class="row">
			<div class="col-md-4 col-xs-4">
				<div><span class="color-9">所在地区：</span><span title="{{=data.location}}">{{=$k.util.cutString(data.location, 30)}}</span></div>
				<div><span class="color-9">融资方式：</span><span>{{=$k.constant.financingType[data.financingType].name}}</span></div>
			</div>
			<div class="col-md-4 col-xs-4">
				<div><span class="color-9">所属行业：</span><span>{{=$k.constant.profession[data.profession].name}}</span></div>
				<div><span class="color-9">融资用途：</span><span title="{{=data.purpose}}">{{=$k.util.cutString(data.purpose, 30)}}</span></div>
			</div>
			<div class="col-md-4 col-xs-4" style="line-height: 20px;"><div class="color-9">融资资金:<span class="amount font-16 color-org">{{=data.amount}}</span></div></div>
		</div>
		<div><i class=" glyphicon glyphicon-time"></i><span class="color-9">{{=new Date(data.createTime).format("yyyy-mm-dd")}}</span></div>
	</li>
	{{~}}
</ul>
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(4);
	new $k.proto.FilterArea().init($(".filter-wraper"), "financing").draw();
	
	$content.find(".nav-wraper").html($(".template.NavBar").doT({
		subnv: 1
	}));
	
	document.onkeydown = function(e) {
		var ev = document.all ? window.event : e;
		if(ev.keyCode==13) {
			$content.find("#financing-search").trigger("click");
		}
	}
	
	var pr = $k.util.getRequestParam('pr');
	var ft = $k.util.getRequestParam('ft');
	if (pr != '' || ft != '') {
		if (pr == '') {
			pr = $k.util.getAllValue($k.constant.profession);
		}
		if (ft == '') {
			ft = $k.util.getAllValue($k.constant.financingType);
		}
		getList("financing/financing/filter", {profession: pr, financingType: ft});
		return;
	}
	
	// load
	getList("financing/financing/listPaging", {});
	
	
	$content
	.on("click", "#financing-search", function() {
		var searchStr = $content.find("#searchStr").val();
		getList("financing/financing/search", {searchStr: searchStr});
	});
	
})( jQuery );

function getList(url, param) {
	var $content = $(".content-container");
	param.page = 0;
	param.size = $k.config.paginator.pageSize;
	
	$.ajax({
		url: url,
		type: "POST",
		data: param,
		cache: false,
		success: function(data) {
			if(data.status == 0) {
				$content.find(".financing-list").html($(".template.FinancingList").doT({
					data: data.data.content
				}));
				
				$(".pager_container ul").html("");
				if(data.data.content.length == 0) {
					$content.find(".no-result").removeClass("hidden");
					return;
				}
				
				var options = $k.config.paginator.options;
				options.onPageClicked = function (event, originalEvent, type, page) { //异步换页
					param.page = page - 1;
					$.ajax({
		        		url: url,
		        		type: "POST",
		        		data: param,
		        		cache: false,
		        		success: function(data) {
		        			if(data.status == 0) {
		        				$content.find(".financing-list").html($(".template.RecruitmentList").doT({
		        					data: data.data.content
		        				}));
		        			}
		        		}
		        	});
		        }
				options.totalPages = data.data.totalPages;
				 $content.find(".pager_container ul").bootstrapPaginator(options);
			}
		},
		error: function(err) {}
	});
}
</script>
</html>