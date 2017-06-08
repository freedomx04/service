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
						<ul>
						</ul>
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

<script class="template InvestList" type="text/x-jquery-tmpl">
{{~it.data:data}}
<li>
	<div class="title" title="{{=data.name}}"><a href="{{="investinfo?id=" + data.id}}" target="_blank">{{=$k.util.cutString(data.name, 60)}}</a></div>
	<div class="row">
		<div class="col-md-4 col-xs-6 ellipsis">
			<span>{{=data.company.contactUser}}</span>
			<span style="margin-left: 30px;" title="{{=data.company.name}}">{{=data.company.name}}</span>
		</div>
		<div class="col-md-8 col-xs-6">
			<span class="color-9">投资资金：</span>
			<span class="amount font-16" style="color: #fd5f39;">{{=data.amount}}</span>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-xs-6">
			<span class="color-9">投资地区：</span>
			<span>
				{{~data.investArea.split(",") : investArea : i}}
					{{=$k.constant.investArea[investArea].name + (i != data.investArea.split(",").length - 1 ? "," : "")}}
				{{~}}
			</span>
		</div>
		<div class="col-md-8 col-xs-6">
			<span class="color-9">投资行业：</span>
				<span>
					{{~data.profession.split(",") : profession : i}}
						{{=$k.constant.profession[profession].name + (i != data.profession.split(",").length - 1 ? "," : "")}}
					{{~}}
				</span>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-xs-8">
			<span class="color-9">投资方式：</span><span>{{=$k.constant.investType[data.investType].name}}</span>
		</div>
		<div class="col-md-8 col-xs-8">
			<span class="color-9">资金类型：</span><span>{{=$k.constant.fundType[data.fundType].name}}</span>
		</div>
	</div>
	<div><i class=" glyphicon glyphicon-time"></i><span class="color-9">{{=new Date(data.createTime).format("yyyy-mm-dd")}}</span></div>
</li>
{{~}}
</script>

<script>
;(function() {
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(4);
	new $k.proto.FilterArea().init($(".filter-wraper"), "invest").draw();
	
	$content.find(".nav-wraper").html($(".template.NavBar").doT({
		subnv: 2
	}));
	
	document.onkeydown = function(e){
		var ev = document.all ? window.event : e;
		if(ev.keyCode==13) {
			$content.find("#invest-search").trigger("click");
		}
	}
	
	var ft = $k.util.getRequestParam('ft');
	var it = $k.util.getRequestParam('it');
	if (it != '' || ft != '') {
		if (it == '') {
			pr = $k.util.getAllValue($k.constant.investType);
		}
		if (ft == '') {
			ft = $k.util.getAllValue($k.constant.fundType);
		}
		getList("financing/invest/filter", {investType: it, fundType: ft});
		return;
	}
	
	getList("financing/invest/listPaging", {});
	
	$content.on("click", "#invest-search", function() {
		var searchStr = $content.find("#searchStr").val();
		getList("financing/invest/search", {searchStr: searchStr});
	});
})();

function getList(url, param) {
	var $ul = $(".financing-list ul");
	param.page = 0;
	param.size = $k.config.paginator.pageSize;
	
	$.ajax({
		url: url,
		type: "POST",
		data: param,
		success: function(data) {
			if(data.status == 0) {
				$ul.html($(".template.InvestList").doT({
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
		        		success: function(data) {
		        			if(data.status == 0) {
		        				$ul.html($(".template.InvestList").doT({
		        					data: data.data.content
		        				}));
		        			}
		        		}
		        	});
		        }
				options.totalPages = data.data.totalPages;
				$(".pager_container ul").bootstrapPaginator(options);
			}
		},
		error: function(e) {}
	});
}
</script>
</html>