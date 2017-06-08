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
<%@ include file="/WEB-INF/template/talent/talent_top.jsp"%>
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>

</head>
<body>
	<div id="page">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
			<div class="banner"><img alt="人才服务" src="./img/banner-talent.jpg"></div>
		
			<div class="nav-wraper"></div>
			
		    <div class="main_container">
				<div class="filter-wraper"></div>
				<div class="list-wrapper">
					<div class="job-list"></div>
					<div class="pager_container">
						<ul>
						</ul>
					</div>
					<span class="no-result hidden">没有找到结果</span>
				</div>
		    </div>
		</div>
		
		<div id="footer"></div>
	</div>
</body>

<script class="template JobList" type="text/x-jquery-tmpl">
<div class="row">
	<div class="col-md-3 col-xs-3">求职职位</div>
	<div class="col-md-2 col-xs-2">姓名</div>
	<div class="col-md-1 col-xs-1">性别</div>
	<div class="col-md-2 col-xs-2">工作年限</div>
	<div class="col-md-2 col-xs-2">学历</div>
	<div class="col-md-2 col-xs-2">时间</div>
</div>
<ul>
	{{~it.data:job : index}}
	<li class="row">
		<ol class="col-md-3 col-xs-3 ellipsis"><a class="hm-a" href="{{="jobinfo?id=" + job.id}}" target="_blank">{{=job.intention}}</a></ol>
		<ol class="col-md-2 col-xs-2">{{=job.name}}</ol>
		<ol class="col-md-1 col-xs-1">{{=job.sex == 0 ? "男" : "女"}}</ol>
		<ol class="col-md-2 col-xs-2">{{=$k.constant.workingYears[job.workingYears].name}}</ol>
		<ol class="col-md-2 col-xs-2">{{=$k.constant.education[job.education].name}}</ol>
		<ol class="col-md-2 col-xs-2">{{=new Date(job.createTime).format("yyyy-mm-dd")}}</ol>
	</li>
	{{~}}
</ul>
</script>

<script>
;(function() {
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(3);
	new $k.proto.FilterArea().init($(".filter-wraper")).draw();
	
	$content.find(".nav-wraper").html($(".template.SearchBar").doT({
		subnv: 2
	}));
	
	document.onkeydown = function(e){
		var ev = document.all ? window.event : e;
		if(ev.keyCode==13) {
			$content.find("#job-search").trigger("click");
		}
	}
	
	var ar = $k.util.getRequestParam('ar');
	var pr = $k.util.getRequestParam('pr');
	var ed = $k.util.getRequestParam('ed');
	var wy = $k.util.getRequestParam('wy');
	var sa = $k.util.getRequestParam('sa');
	if (ar != '' || pr != '' || ed != '' || wy != '' || sa != '') {
		if (pr == '') {
			pr = $k.util.getAllValue($k.constant.profession);
		}
		if (ed == '') {
			ed = $k.util.getAllValue($k.constant.education);
		}
		if (wy == '') {
			wy = $k.util.getAllValue($k.constant.workingYears);
		}
		if (sa == '') {
			sa = $k.util.getAllValue($k.constant.salary);
		}
		if (ar == '') {
			var arList = [];
			$k.util.getAreaList({
				success: function(data) {
					$.each(data.data, function(key, val) {
						arList.push(val.id);
					});
					ar = arList.join('-');
					
					getList("talent/job/filter", {area: ar, profession: pr, education: ed, workingYears: wy, salary: sa});
				}
			});
		} else {
			getList("talent/job/filter", {area: ar, profession: pr, education: ed, workingYears: wy, salary: sa});
		}
		return;
	}
	
	getList("talent/job/listPaging", {});
	
	$content.on("click", "#job-search", function() {
		var searchStr = $content.find("#searchStr").val();
		getList("talent/job/search", {searchStr: searchStr});
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
				$content.find(".job-list").html($(".template.JobList").doT({
					data: data.data.content
				}));
				
				$(".pager_container ul").html("");
				if(data.data.content.length == 0) {
					$content.find(".no-result").removeClass("hidden");
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
		        				$content.find(".job-list").html($(".template.JobList").doT({
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