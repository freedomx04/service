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
<%@ include file="/WEB-INF/template/evaluation.jsp"%>

<style>
#enterpriseinfo_container .position {
    float: left;
    width: 520px;
    margin-right: 20px;
}
#enterpriseinfo_container .time {
	float: right;
    width: 80px;
    margin-right: 15px;
    line-height: 50px;
}
#enterpriseinfo_container #container_left .item_content li {
    color: #555;
    border: 1px solid #ededed;
    margin-top: 18px;
    padding: 10px 15px 0;
    height: 78px;
    line-height: 58px;
}
#container_right .item_content ul {
	margin-left: 20px;
	margin-top: 10px;
}
#basic_container .item_content>ul>li {
    height: 15px;
    line-height: 15px;
}
#basic_container .item_content>ul li+li {
    margin-top: 30px;
}
#basic_container .item_content>ul>li>i {
    display: inline-block;
    width: 15px;
    height: 15px;
    margin-right: 20px;
    vertical-align: middle;
}
#basic_container .item_content>ul>li>span {
    position: relative;
    top: 2px;
}
#enterpriseinfo_container .p_top {
    height: 34px;
    line-height: 34px;
}
#enterpriseinfo_container .p_top h2 {
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
#enterpriseinfo_container .p_top h2 {
	line-height: 34px;
}
#enterpriseinfo_container .p_top span {
    float: left;
    margin: 0 3px;
    color: #999;
}
#enterpriseinfo_container .p_top span.add {
    font-size: 16px;
    color: #3b8cff;
}
#enterpriseinfo_container .p_bot {
	height: 24px;
    line-height: 24px;
}
#enterpriseinfo_container .p_bot .li_b_l {
    font-size: 14px;
    color: #555;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-wrap: normal;
}
#enterpriseinfo_container .p_bot .li_b_l span.money{
    margin-right: 1em;
    font-size: 16px;
    color: #fd5f39;
}
</style>
<link type="text/css" rel="stylesheet" media="screen and (max-device-width: 480px)" href="./vendor/local/css/tinyScreen.css"/>
</head>
<body>
	<div id=page>
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
			<div class="weizhi">
				<ul style="margin-bottom: 10px;">
					<li><a href="recruitment">人才服务</a></li>
				    <li><a href="recruitment">招聘信息</a></li>
				    <li class="active">企业详情</li>
				</ul>
			</div>
		
			<div class="top_info">
				<div class="top_info_wrap"></div>
			</div>
			
			<div id="company_navs" class="company_navs">
			    <div class="company_navs_wrap">
			        <ul>
			            <li class="enrerprise-home current">
			                <a>公司主页</a>
			            </li>
			            <li class="enterprise-recruitment">
			                <a>招聘职位（<span></span>）</a>
			            </li>
			            <li class="enterprise-evaluation">
			                <a>公司评价（<span></span>）</a>
			            </li>
			        </ul>
			    </div>
			</div>
			
			<div id="enterpriseinfo_container">
				<div id="left"></div>
				<div id="right" class="line-break"></div>
			</div>
		</div>
		
		<div id="footer">
		</div>
	</div>
</body>

<script class="template EnterpriseInfoTop" type="text/x-jquery-tmpl">
<img src="{{="./" + it.data.imagePath}}">
<div class="company_info">
	<div class="company_main">
		<h1>
		    <a class="hm-a"  href="{{="http://" + it.data.website}}" target="_blank" rel="nofollow" title="{{=it.data.name}}">
		   		{{=it.data.name}}
		    </a>
		</h1>
		<a href="{{="http://" + it.data.website}}" class="icon-wrap" target="_blank" rel="nofollow" title="{{="http://" + it.data.website}}">
           <i></i>
        </a>
		<a class="identification" title="已认证企业">
            <i></i>
        	<span>已认证</span>
        </a>
	</div>
	<div class="tiny-enterpriseinfo">
		<div class="company-simpleinfo">
			<div><span class="color-9">行业类别：</span><span>{{=it.data.profession!=null ? $k.constant.profession[it.data.profession].name : ""}}</span></div>
			<div><span class="color-9">所在区域：</span><span>{{=it.data.area != null ? it.data.area.name : ""}}</span></div>
			<div><span class="color-9">企业规模：</span><span>{{=$k.constant.scale[it.data.scale].name}}人</span></div>
			<div><span class="color-9">企业网站：</span><span>
				{{? it.data.website}}
	           	<span><a class='hm-a' href="{{="http://" + it.data.website}}" target="_blank">{{="http://" + it.data.website}}</a></span>
				{{?}}</span>
			</div>
		</div>
	</div>
</div>
</script>

<script class="template EnterpriseBasiInfo" type="text/x-jquery-tmpl">
<div>
	<div class="company-name line-break">{{=it.data.name}}</div>
	<div class="company-simpleinfo">
		<div><span class="color-9">行业类别：</span><span>{{=it.data.profession!=null ? $k.constant.profession[it.data.profession].name : ""}}</span></div>
		<div><span class="color-9">所在区域：</span><span>{{=it.data.area != null ? it.data.area.name : ""}}</span></span></div>
		<div><span class="color-9">企业规模：</span><span>{{=$k.constant.scale[it.data.scale].name}}人</span></div>
		<div><span class="color-9">企业网站：</span><span>
			{{? it.data.website}}
	           	<span><a class='hm-a' href="{{="http://" + it.data.website}}" target="_blank">{{="http://" + it.data.website}}</a></span>
			{{?}}	
		</span></div>
	</div>
</div>
</script>

<script class="template EnterpriseRecruitment" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">招聘职位</div>
	<div class="list-container">
	</div>
	<div class="pager_container">
		<ul></ul>
	</div>
</div>
</script>

<script class="template RecruitmentList" type="text/x-jquery-tmpl">
<ul class="item_content">
	{{~ it.data : recruitment}}
	<li>
		<div class="position">
	        <div class="p_top">
	            <a href="{{="recruitmentinfo?id=" + recruitment.id}}" target="_blank">
	                <h2>{{=recruitment.position}}</h2>
	                <span class="add">[<em>{{=recruitment.area != null ? recruitment.area.name : ""}}</em>]</span>
	            </a>
	        </div>
	        <div class="p_bot">
	            <div class="li_b_l">
	                <span class="money">{{=$k.constant.salary[recruitment.salary].name}}</span>
	                	{{=$k.constant.workingYears[recruitment.workingYears].name}} / {{=$k.constant.education[recruitment.education].name}}
	            </div>
	        </div>
	    </div>
	    <div class="time">
	    	<span>{{=new Date(recruitment.createTime).format("yyyy-mm-dd")}}</span>
	    </div>
	 </li>
	{{~}}
</ul>
</script>

<script class="template EnterpriseHome" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">企业简介</div>
	<div class="item_content line-break">
		{{=it.data.introduction}}
	</div>
</div>
<div class="item_container">
	<div class="item_ltitle">企业位置</div>
	<div class="item_content">
		{{=it.data.address}}
	</div>
</div>
</script>

<script>
;(function() {
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(3);
	
	var $container = $("#enterpriseinfo_container");
	var $nav = $("#company_navs");
	var id = $k.util.getRequestParam("id");
	if(id == "" || id == null) {
		return;
	}
	
	var averageScore = 0;
	var totalEvaluation = 0;
	
	$.ajax({
		url: "talent/company/detail",
		type: "POST",
		data: {companyId: id},
		success: function(data) {
			if(data.status == 0) {
				$nav.find(".enterprise-recruitment span").html(data.data.recruitments.length);
				
				$(".top_info_wrap").html($(".template.EnterpriseInfoTop").doT({
					data: data.data
				}));
				$container.find("#right").html($(".template.EnterpriseHome").doT({
					data: data.data
				}));
				$container.find("#left").html($(".template.EnterpriseBasiInfo").doT({
					data: data.data
				}));
				
				$nav.on("click", ".enrerprise-home", function() {
					$container.find("#right").html($(".template.EnterpriseHome").doT({
						data: data.data
					}));
					$nav.find("li").removeClass("current");
					$(this).addClass("current");
				});
				
				totalEvaluation = data.data.evaluations.length ;
				averageScore = data.data.score;
				$nav.find(".enterprise-evaluation span").html(totalEvaluation);
			}
		},
		error: function(e) {}
	});
	
	$nav
	.on("click", ".enterprise-recruitment", function() {
		var $this = $(this);
		$.ajax({
			url: "talent/recruitment/listByCompanyIdPaging",
			type: "POST",
			data: {
				companyId: id,
				page: 0,
				size: $k.config.paginator.pageSize
			},
			success: function(data) {
				if(data.status == 0) {
					$container.find("#right").html($(".template.EnterpriseRecruitment").doT({
						data: data.data.content
					}));
					$nav.find("li").removeClass("current");
					$this.addClass("current");
					
					$container.find(".list-container").html($(".template.RecruitmentList").doT({
						data: data.data.content,
					}));
					
					var options = $k.config.paginator.options;
					options.totalPages = data.data.totalPages;
					options.onPageClicked = function (event, originalEvent, type, page) { //异步换页
			        	$.ajax({
			        		url: "talent/recruitment/listPagingByCompanyId",
			        		type: "POST",
			        		data: {
			        			companyId: id,
			        			page: parseInt(page) - 1,
			        			size: $k.config.paginator.pageSize
			        		},
			        		success: function(data) {
			        			if(data.status == 0) {
			        				$container.find(".list-container").html($(".template.RecruitmentList").doT({
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
	})
	.on("click", ".enterprise-evaluation", function() {
		var $this = $(this);
		$nav.find("li").removeClass("current");
		$this.addClass("current");
		new $k.proto.Evaluation().init($("#right"), "talent", id).draw(averageScore, totalEvaluation).load(0);
	});
})();
</script>
</html>