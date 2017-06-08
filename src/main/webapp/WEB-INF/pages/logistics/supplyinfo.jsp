<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
.supplyinfo-content {
    padding: 15px;
}
.supplyinfo-content .line {
	color: #3b8cff;
	font-size: 18px;
}
.supplyinfo-content .line i {
	margin-left: 20px;
	margin-right: 20px;
}
.supplyinfo-top p {
	margin-top: 10px;
    text-indent: 1rem;
}
.supply-intro > div {
	padding: 10px 0;
}
.supply-intro > div:not(:last-child) {
	border-bottom: 1px dashed #ddd;
}
</style>
</head>
<body>
	<div id="page" class="supplyinfo">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
			<div>
				<div class="weizhi">
					<ul>
					    <li><a href="supply" target="_blank">物流服务</a></li>
					    <li><a href="supply" target="_blank">货源信息</a></li>
					    <li class="active">货源详情</li>
					</ul>
				</div>
				<div class="supplyinfo-content">
				</div>
			</div>
		</div>
		
		<div id="footer">
		</div>
	</div>
</body>

<script class="template SupplyInfo" type="text/x-jquery-tmpl">
<div class="supplyinfo-top">
	<div class="line">
		{{=it.data.origin}}<i class="glyphicon glyphicon-arrow-right"></i>{{=it.data.destination}}
	</div>
	<p class="info-title"><span>发布者：</span><span>{{=it.data.user.username}}</span></p>
	<div class="supply-intro">
		<div><span class="info-title">货源描述：</span><span>{{=it.data.description}}</span></div>
		<div><span class="info-title">货物类型：</span><span>{{=it.data.supplyType == 0 ? "重货" : "轻货"}}</span></div>
		<div class="row">
			<div class="col-md-6"><span class="info-title">信息有效期：</span><span>{{=new Date(it.data.validDate).format("yyyy-mm-dd")}}</span></div>
			<div class="col-md-6"><span class="info-title">发布时间：</span><span>{{=new Date(it.data.updateTime).format("yyyy-mm-dd")}}</span></div>
		</div>
		<div class="row">
			<div class="col-md-6"><span class="info-title">联系人：</span><span>{{=it.data.contactUser}}</span></div>
			<div class="col-md-6"><span class="info-title">联系方式：</span><span>{{=it.data.contact}}</span></div>
		</div>
		<div><span class="info-title">说明：</span><span>{{=it.data.remark}}</span></div>
		<div><span class="info-title">接货地点：</span><span>{{=it.data.address}}</span></div>
	</div>
</div>
</script>

<script>
;(function() {
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(5);
	
	var id = $k.util.getRequestParam("id");
	if(id == "" || id == null) {
		return;
	}
	
	$.ajax({
		url: "logistics/supply/detail",
		type: "POST",
		data: {supplyId: id},
		success: function(data) {
			if(data.status == 0) {
				$content.find(".supplyinfo-content").html($(".template.SupplyInfo").doT({
					data: data.data
				}));
			}
		},
		error: function(e) {}
	});
	
})();
</script>
</html>