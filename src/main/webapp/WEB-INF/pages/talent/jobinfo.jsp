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

<style>
.apply-head, .apply-detail {
	margin: 30px 10px 0;
}
.apply-head {
	display: table
}
.apply-head > div {
    display: table-cell;
    vertical-align: middle;
}
.apply-head .apply-description {
	width: 760px;
	padding-left: 20px;
}
.apply-head .userpic {
	width: 150px;
}
.apply-head .userpic img {
	width: 100%;
}
.apply-head .apply-description ul li {
	display: inline-block;
}
.apply-description > div {
	line-height: 2;
}
.apply-description .name {
	font-size: 18px;
	font-weight: 600;
}
.apply-detail .title {
	font-size: 16px;
    margin-left: 170px;
}
.apply-detail hr {
	margin-top: 5px;
	margin-bottom: 5px;
	border-top: 1px dashed #999;
}
.apply-detail > div {
	margin-bottom: 15px;
}
.apply-detail .content {
	color: #737373;
}
.tiny-jobinfo-table {
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
			<div class="weizhi">
				<ul>
				    <li><a href="recruitment" target="_blank">人才服务</a></li>
				    <li><a href="job" target="_blank">求职信息</a></li>
				    <li class="active">职位详情</li>
				</ul>
			</div>
			
			<div id="container"></div>
			
		</div>
		<div id="footer"></div>
	</div>
</body>

<script class="template JobInfo" type="text/x-jquery-tmpl">
<div class="apply-head">
	<div class="userpic"><img alt="暂无" src="{{=it.data.imagePath}}"></div>
	<div class="apply-description">
		<p>
			<span class="name  line-break">{{=it.data.name}}</span>
			<span class="sex">{{=it.data.sex == 0 ? "男" : "女"}} </span>|
			<span class="age">{{= new Date().getFullYear() - it.data.birthYear}}岁</span>
		</p>
		<table class="tiny-jobinfo-table">
			<tbody>
				<tr><td><span class="color-9">学历：</span></td><td><span>{{=$k.constant.education[it.data.education].name}}</span></td></tr>
				<tr><td><span class="color-9">期望月薪：</span></td><td><span>{{=$k.constant.salary[it.data.salary].name}}</span></td></tr>
				<tr><td><span class="color-9">工作年限：</span></td><td><span>{{=$k.constant.workingYears[it.data.workingYears].name}}</span></td></tr>
				<tr><td><span class="color-9">工作地点：</span></td><td><span>{{=it.data.area.name}}</span></td></tr>
				<tr><td><span class="color-9">求职意向：</span></td><td><span>{{=it.data.intention}}</span></td></tr>
			</tbody>
		</table>
		<div class="row m-hidden">
			<div class="col-md-6 col-xs-6">
				<div><span class="color-9">学历：</span><span>{{=$k.constant.education[it.data.education].name}}</span></div>
				<div><span class="color-9">期望月薪：</span><span>{{=$k.constant.salary[it.data.salary].name}}</span></div>
			</div>
			<div class="col-md-6 col-xs-6">
				<div><span class="color-9">工作年限：</span><span>{{=$k.constant.workingYears[it.data.workingYears].name}}</span></div>
				<div><span class="color-9">工作地点：</span><span>{{=it.data.area.name}}</span></div>
			</div>
		</div>
		<div><span class="color-9">求职意向：</span><span class="line-break">{{=it.data.intention}}</span></div>
	</div>
</div>
<!-- <div style="background-color: #ebf0ef; width: 1000px; height: 20px;margin-left: -15px;"></div> -->
<div class="apply-detail">
	<div class="self-introduction">
		<div class="title">自我介绍</div>
		<hr/>
		<div class="content">{{=it.data.introduction}}</div>
	</div>
	<div class="contact-way">
		<div class="title">联系方式</div>
		<hr/>
		<div class="content">{{=it.data.contact}}</div>
	</div>
	<div class="work-experience">
		<div class="title">工作经验</div>
		<hr/>
		<div class="content">{{=it.data.workExperience}}</div>
	</div>
	<div class="education">
		<div class="title">教育经历</div>
		<hr/>
		<div class="content">{{=it.data.educationExperience}}</div>
	</div>
</div>
</script>

<script>
;(function() {
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(3);

	var $content = $(".content-container");
	var id = $k.util.getRequestParam("id");
	if(id == "" || id == null) {
		return;
	}
	$.ajax({
		url: "talent/job/detail",
		type: "POST",
		data: {jobId: id},
		success: function(data) {
			if(data.status == 0) {
				$content.find("#container").html($(".template.JobInfo").doT({
					data: data.data
				}));
			}
		},
		error: function(e) {}
	});
	
})();
</script>
</html>