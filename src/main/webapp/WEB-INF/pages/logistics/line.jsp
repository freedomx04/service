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
.line-item .logistics-company a{
	line-height: 60px;
    font-size: 16px;
}
.select {
	border: none;
	padding-left: 10px;
}
.tiny-logistics-filter {
	display: none;
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
			<div class="banner"><img alt="物流服务" src="./img/banner-logistics.jpg"></div>
		
			<div class="nav-wraper"></div>
			<div class="line-container">
			
				<div class="weizhi">
					<ul>
					    <li><a href="" target="_blank">物流服务</a></li>
					    <li class="active">物流线路</li>
					</ul>
				</div>
				
				<div class="lines">
					<div class="filter-wraper">
						<ul class="select m-hidden" style="height: 50px;">
							<li class="select-list">
								<dt class="select-dt">线路：</dt>
								<dl class="select-dl" style="max-width: 100%;">
									<dd class='select-dd select-all selected' style="width: 40px;" id="search-all">
										<a class="select-a">不限</a>
									</dd>
									<dd class="select-dd select-all" style="width: 320px;">
										<div class='form-group'>
					    					<label for='origin' class='col-sm-3 control-label'>发货地:</label>
					    					<div class='col-sm-9'>
					      						<input type='text' id='origin' class='form-control citypicker' name='origin'>
					    					</div>
					  					</div>
									</dd>
									<dd class="select-dd select-all" style="width: 320px;">
										<div class='form-group'>
					   						<label for='destination' class='col-sm-3 control-label'>收货地:</label>
					    					<div class='col-sm-9'>
					      						<input type='text' id='destination' class='form-control ' name='destination'>
					    					</div>
					      				</div>
									</dd>
									<dd style="display: inline-block;">
										<button id="line-search" class="btn btn-hm" style="width: 60px;">查询</button>
									</dd>
								</dl>
							</li>
						</ul>
						<div class="tiny-logistics-filter">
							<div class="form-group">
								<label for='origin' class='col-sm-3 control-label'>发货地:</label>
	                            <div class='col-sm-9'>
	                                <input id="origin" class="form-control citypicker" type="text" value="">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                        	<label for='destination' class='col-sm-3 control-label'>收货地:</label>
	                            <div class='col-sm-9'>
	                                <input id="destination" class="form-control citypicker" type="text" value="">
	                            </div>
	                        </div>
	                        <div class="form-group">
	                        	<div class='col-sm-12'>
		                            <button id="line-reset" class="btn btn-hm" style="width: 60px;">重置</button>
		                            <button id="line-search" class="btn btn-hm" style="width: 60px;">查询</button>
		                        </div>
	                        </div>
	                     </div>
					</div>
					
					<div class="line-list"></div>
					
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

<script class="template LineList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data: line}}
	<li>
		<div class="line-item row">
			<div class="col-md-9 col-xs-9">
				<div class="font-16">
					<span class="start-line">{{=line.origin}}</span><i class="glyphicon glyphicon-arrow-right"></i>
					{{=line.destination}}
				</div>
				<div>
					<span class="caption">
						<span class="color-9">运价：</span>
						<span>{{=line.heavyPrice}}元/公斤</span>
						<span>{{=line.lightPrice}}元/立方米</span>
					</span>
					<span class="caption"><span class="color-9">时效：</span><span>{{=line.aging}}天</span></span>
					<span class="caption"><span class="color-9">最低一票：</span><span>{{=line.lowest}}元</span></span>
					<span class="caption"><span class="color-9">运输方式：</span><span>{{=$k.constant.transportMode[line.transportMode].name}}</span></span>
				</div>
			</div>
			<div class="col-md-3 col-xs-3 ellipsis logistics-company">
				<a href="{{="logisticsCompany?id=" + (line.company != null ? line.company.id : "")}}" target="_blank" class="hm-a" title="{{=line.company != null ? line.company.name : ""}}">
					{{=$k.util.cutString(line.company != null ? line.company.name : "", 20)}}
				</a>
				<i class="company_mark" title="该企业已上传营业执照并通过资质验证审核"></i>
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
	new $k.proto.Menu().init($("#top .menu")).draw(5);
	$content.find(".nav-wraper").html($(".template.NavBar").doT({
		subnv: 2
	}));
	
	document.onkeydown = function(e){
		var ev = document.all ? window.event : e;
		if(ev.keyCode==13) {
			$content.find("#line-search").trigger("click");
		}
	}
	
	$content.find('.citypicker').citypicker();
	
	getList("logistics/line/listPaging", {});
	
	$content.on("click", "#line-search", function() {
		var origin = $content.find("#origin").val();
		var destination = $content.find("#destination").val();
		if($(".select").css("display") == "none") {
			origin = $content.find(".tiny-logistics-filter #origin").val();
			destination = $content.find(".tiny-logistics-filter #destination").val();
		}
		getList("logistics/line/search", {origin: origin, destination: destination});
	});
	
	$("#page").on("click", "#search-all, #line-reset", function() {
		$content.find('.citypicker').citypicker('reset');
		getList("logistics/line/search", {origin: "", destination: ""});
	})
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
				$content.find(".line-list").html($(".template.LineList").doT({
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
		        				$content.find(".line-list").html($(".template.LineList").doT({
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