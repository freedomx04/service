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
.supply-item .title i, .line-item .title i {
	margin-right: 20px;
	margin-left: 20px;
}
.supply-item .info {
	line-height: 30px;
}
.select {
	border: none;
	padding-left: 10px;
}
.weizhi ol.add-btn {
	position: absolute;
	bottom: 5px;
	right: 0;
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
		
			<div class="nav-wraper">
			</div>
			<div class="supply-container">
				<div class="weizhi">
					<ul>
					    <li><a href="" target="_blank">物流服务</a></li>
					    <li class="active">货源信息</li>
					    <ol class="pull-right add-btn"><button class="btn btn-default add-supply-btn">发布货源信息</button></ol>
					</ul>
				</div>
				<div class="supply">
					<div class="filter-wraper">
						<ul class="select m-hidden" style="height: 50px;">
							<li class="select-list">
								<dt class="select-dt">线路：</dt>
								<dl class="select-dl">
									<dd class='select-dd select-all selected' style="width: 40px;" id="search-all">
										<a class="select-a">不限</a>
									</dd>
									<dd class="select-dd" style="width: 320px;">
										<div class='form-group'>
					    					<label for='origin' class='col-sm-3 control-label'>发货地:</label>
					    					<div class='col-sm-9'>
					      						<input type='text' id='origin' class='form-control citypicker' name='origin'>
					    					</div>
					  					</div>
									</dd>
									<dd class="select-dd" style="width: 320px;">
										<div class='form-group'>
					   						<label for='destination' class='col-sm-3 control-label'>收货地:</label>
					    					<div class='col-sm-9'>
					      						<input type='text' id='destination' class='form-control citypicker' name='destination'>
					    					</div>
					      				</div>
									</dd>
									<dd style="display: inline-block;">
										<button id="supply-search" class="btn btn-hm">查询</button>
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
		                            <button id="supply-reset" class="btn btn-hm" style="width: 60px;">重置</button>
		                            <button id="supply-search" class="btn btn-hm" style="width: 60px;">查询</button>
		                        </div>
	                        </div>
	                     </div>
					</div>
					<div class="supply-list">
						
					</div>
					<div class="pager_container">
						<ul>
							
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div id="footer">
		</div>
	</div>
</body>

<script class="template SupplyList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data: supply}}
	<li>
		<div class="supply-item">
			<div class="title">
				<a href="{{="supplyinfo?id=" + supply.id}}" target="_blank"><span class="start-line">{{=supply.origin}}</span><i class="glyphicon glyphicon-arrow-right"></i>
				{{=supply.destination}}</a>
			</div>
			<div class="color-org">{{=supply.user.username}}</div>
			<div>
				<span class="caption"><span class="color-9">货源描述：</span><span>{{=$k.util.cutString(supply.description, 40)}}</span></span>
				<span class="caption"><span class="color-9">货物类型：</span><span>{{=supply.supplyType == 0 ? "重货" : "轻货"}}</span></span>
				<span class="caption"><span class="color-9">信息有效期：</span><span>{{=new Date(supply.validDate).format("yyyy-mm-dd")}}</span></span>
				<span class="caption"><span class="color-9">发布时间：</span><span>{{=new Date(supply.updateTime).format("yyyy-mm-dd")}}</span></span>
			</div>
			<div>
				<span><span class="color-9 caption">说明：</span><span>{{=$k.util.cutString(supply.remark, 100)}}</span></span>
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
	new $k.proto.NavBar().init($(".nav-wraper")).draw(1);
	
	$content.find('.citypicker').citypicker();
	
	document.onkeydown = function(e){
		var ev = document.all ? window.event : e;
		if(ev.keyCode==13) {
			$content.find("#supply-search").trigger("click");
		}
	}
	
	getList("logistics/supply/listPaging", {});
	
	$content
	.on("click", "#supply-search", function() {
		var origin = $content.find("#origin").val();
		var destination = $content.find("#destination").val();
		if($(".select").css("display") == "none") {
			origin = $content.find(".tiny-logistics-filter #origin").val();
			destination = $content.find(".tiny-logistics-filter #destination").val();
		}
		getList("logistics/supply/search", {origin: origin, destination: destination});
	})
	.on("click", ".add-supply-btn", function() {
		var user = $k.session.get();
		if(user == undefined) {
			new $k.proto.LoginDialog().init().draw();
		}  else {
			 window.open("addSupply");
		}
	});
	
	$("#page").on("click", "#search-all, #supply-reset", function() {
		$content.find('.citypicker').citypicker('reset');
		getList("logistics/supply/search", {origin: "", destination: ""});
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
		success: function(data) {
			if(data.status == 0) {
				$content.find(".supply-list").html($(".template.SupplyList").doT({
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
		        		success: function(data) {
		        			if(data.status == 0) {
		        				$content.find(".supply-list").html($(".template.SupplyList").doT({
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