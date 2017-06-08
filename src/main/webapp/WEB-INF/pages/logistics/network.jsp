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
<style>
.network .filter-wraper .row {
	width: 900px;
	margin: 0 auto;
}
.network .filter-wraper {
	padding: 10px 0;
}
</style>
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>
</head>
<body>
	<div id="page" class="network">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
			<div class="banner"><img alt="物流服务" src="./img/banner-logistics.jpg"></div>
		
			<div class="nav-wraper"></div>
			<div class="network-container">
				<div class="weizhi">
					<ul>
					    <li><a href="" target="_blank">物流服务</a></li>
					    <li class="active">物流网点</li>
					</ul>
				</div>
				<div class="network-content">
					<div class="filter-wraper">
						<div class="row">
							<label for="" class="col-md-1 col-xs-3 control-label" style="line-height: 34px;">地区：</label>
							<div class="col-md-6 col-xs-8" style="padding-left: 0;">
							<div class="input-group" style="width:100%;">
			                    <input type="text" id="searchStr" class="form-control">
			                    <span class="input-group-btn">
			                        <button id="network-search" class="btn btn-hm" type="button" style="width: 60px;">查询</button>
			                    </span>
			                </div>
			                </div>
						</div>
					</div>
					<div class="network-list">
						<div class="row">
							<div class="col-md-2 col-xs-2">网点名称</div>
							<div class="col-md-3 col-xs-3">业务内容</div>
							<div class="col-md-4 col-xs-4">联系信息</div>
							<div class="col-md-3 col-xs-3">所属公司</div>
						</div>
						<ul></ul>
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

<script class="template NetworkList" type="text/x-jquery-tmpl">
{{~it.data: network}}
<li>
	<div class="row">
		<div class="col-md-2 col-xs-2 ellipsis" title="{{=network.name}}" style="line-height: 60px;">{{=network.name}}</div>
		<div class="col-md-3 col-xs-3 ellipsis" title="{{=network.business}}" style="line-height: 60px;">{{=network.business}}</div>
		<div class="col-md-4 col-xs-4">
			<div>地址：{{=network.address}}</div>
			<div>联系电话：{{=network.contact}}</div>
		</div>
		<div class="col-md-3 col-xs-3 ellipsis font-16" title="{{=network.company != null ? network.company.name : ""}}" style="line-height: 60px;">
			<a class="hm-a" href="{{="logisticsCompany?id=" + (network.company != null ? network.company.id : "")}}" target="_blank">
				{{=$k.util.cutString(network.company != null ? network.company.name : "", 20)}}
			</a>
			<i class="company_mark" title="该企业已上传营业执照并通过资质验证审核"></i>
		</div>
	</div>
</li>
{{~}}
</script>

<script>
;(function() {
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(5);
	$content.find(".nav-wraper").html($(".template.NavBar").doT({
		subnv: 3
	}));
	
	document.onkeydown = function(e){
		var ev = document.all ? window.event : e;
		if(ev.keyCode==13) {
			$content.find("#network-search").trigger("click");
		}
	}
	
	getList("logistics/network/listPaging", {});
	
	$content.on("click", "#network-search", function() {
		getList("logistics/network/search", {searchStr: $content.find("#searchStr").val()});
	});
})();

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
				$content.find(".network-list ul").html($(".template.NetworkList").doT({
					data: data.data.content
				}));
				
				$(".pager_container ul").html("");
				if(data.data.content.length == 0) {
					return;
				}
				var options = $k.config.paginator.options;
				options.totalPages = data.data.totalPages;
				options.onPageClicked = function (event, originalEvent, type, page) { //异步换页
					param.page = page - 1;
		        	$.ajax({
		        		url: url,
		        		type: "POST",
		        		data: param,
		        		cache: false,
		        		success: function(data) {
		        			if(data.status == 0) {
		        				$content.find(".network-list ul").html($(".template.NetworkList").doT({
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