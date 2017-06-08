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

<style>
.recruitmentinfo-list-item {
   	color: #555;
    border: 1px solid #ededed;
    margin-top: 18px;
}
.recruitmentinfo-list-item .list-item{
    padding: 10px 20px;
}
.recruitmentinfo-list-item .list-item .position {
    float: left;
    width: 450px;
    margin-right: 20px;
}
.recruitmentinfo-list-item .list-item .position .p_top {
    height: 40px;
    line-height: 40px;
}
.recruitmentinfo-list-item .list-item .position .p_top h2 {
    float: left;
    max-width: 280px;
    margin: 0;
    font-size: 16px;
    color: #3b8cff;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-wrap: normal;
    line-height: 40px;
}
.recruitmentinfo-list-item .list-item .position .p_top span {
    float: left;
    margin: 0 3px;
    color: #999;
}
.recruitmentinfo-list-item .list-item .position .p_top span.add {
    font-size: 16px;
    color: #3b8cff;
}
.recruitmentinfo-list-item .list-item .position .p_bot {
    height: 60px;
    line-height: 60px;
}
.recruitmentinfo-list-item .list-item .position .p_bot .li_b_l {
    font-size: 14px;
    color: #555;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-wrap: normal;
}
.recruitmentinfo-list-item .list-item .position .p_bot .li_b_l span.money {
    margin-right: 1em;
    font-size: 16px;
    color: #fd5f39;
}
.recruitmentinfo-list-item .list-item .company {
    float: left;
    width: 250px;
    margin-right: 15px;
}
.recruitmentinfo-list-item .list-item .company .company_name {
    height: 60px;
    line-height: 60px;
}
.recruitmentinfo-list-item .list-item .company .company_name a {
    display: inline-block;
    max-width: 270px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-wrap: normal;
    color: #3b8cff;
    font-size: 16px;
    vertical-align: middle;
}
.recruitmentinfo-list-item .list-item .company .industry {
    height: 60px;
    line-height: 60px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-wrap: normal;
}
.recruitmentinfo-list-item .list-item .com_logo {
    float: right;
    width: 160px;
    margin-right: 20px;
}
.recruitmentinfo-list-item .list-item .com_logo img {
	width: 100%;
	height: 120px;
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
			<div class="banner"><img alt="人才服务" src="./img/banner-talent.jpg"></div>
		
			<div class="nav-wraper"></div>
			
		    <div class="main_container">
				<div class="filter-wraper"></div>
				<div class="list-wrapper">
					<div class="recruitmentinfo-list"></div>
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

<script class="template RecruitmentList" type="text/x-jquery-tmpl">
<ul>
	{{~it.data : recruitment}}
	<li class="recruitmentinfo-list-item">
		<div class="list-item">
	        <div class="position">
	            <div class="p_top ellipsis">
	                <a class="position_link" href="{{="recruitmentinfo?id=" + recruitment.id}}" target="_blank">
	                    <h2>{{=recruitment.position}}</h2>
	                    <span class="add">[<em>{{=recruitment.area != null ? recruitment.area.name : ""}}</em>]</span>
	                </a>
	                <span class="format-time">{{=new Date(recruitment.createTime).format("yyyy-mm-dd")}}</span>
	            </div>
				<div title="{{=recruitment.requirements}}">{{=$k.util.cutString(recruitment.requirements, 50)}}</div>
	            <div class="p_bot ellipsis">
	                <div class="li_b_l">
	                    <span class="money">{{=$k.constant.salary[recruitment.salary].name}}</span>
	                    	{{=recruitment.workingYears!=null ? $k.constant.workingYears[recruitment.workingYears].name : ""}}/{{=$k.constant.education[recruitment.education].name}}
	                </div>
	            </div>
	        </div>
	        <div class="company">
	            <div class="company_name ellipsis">
	                <a href="{{="talentCompany?id=" + (recruitment.company != null ? recruitment.company.id : "")}}" target="_blank">
						{{=$k.util.cutString(recruitment.company != null ? recruitment.company.name : "", 25)}}
					</a>
					<i class="company_mark" title="该企业已上传营业执照并通过资质验证审核"></i>
	            </div>
	            <div class="industry">
	                	{{=recruitment.company != null && recruitment.company.profession != null ? $k.constant.profession[recruitment.company.profession].name : ""}} / {{=recruitment.company != null ? $k.constant.property[recruitment.company.property].name : ""}} / {{=recruitment.company != null ? $k.constant.scale[recruitment.company.scale].name : ""}}
	            </div>
	        </div>
	        <div class="com_logo">
	            <a href="{{="talentCompany?id=" + (recruitment.company != null ? recruitment.company.id : "")}}" target="_blank"><img src="{{=recruitment.company != null ? recruitment.company.imagePath : ""}}"></a>
	        </div>
	    </div>
	</li>
	{{~}}
</ul>
</script>

<script type='text/javascript'>
	
;(function() {
	var $content = $(".content-container");
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(3);
	var filterArea = new $k.proto.FilterArea().init($(".filter-wraper")).draw();
	
	$content.find(".nav-wraper").html($(".template.SearchBar").doT({
		subnv: 1
	}));
	
	document.onkeydown = function(e){
		var ev = document.all ? window.event : e;
		if(ev.keyCode==13) {
			$content.find("#recruitment-search").trigger("click");
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
					
					getList("talent/recruitment/filter", {area: ar, profession: pr, education: ed, workingYears: wy, salary: sa});
				}
			});
		} else {
			getList("talent/recruitment/filter", {area: ar, profession: pr, education: ed, workingYears: wy, salary: sa});
		}
		return;
	}
	
	getList("talent/recruitment/listPaging", {});

	$content.on("click", "#recruitment-search", function() {
		var searchStr = $content.find("#searchStr").val();
		getList("talent/recruitment/search", {searchStr: searchStr});
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
					$content.find(".recruitmentinfo-list").html($(".template.RecruitmentList").doT({
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
			        				$content.find(".recruitmentinfo-list").html($(".template.RecruitmentList").doT({
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