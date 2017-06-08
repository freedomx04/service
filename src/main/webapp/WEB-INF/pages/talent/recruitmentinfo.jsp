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
.position-head .weizhi ul {
	list-style: outside none none;
    margin-bottom: 20px;
}
.position-head .position-content {
    position: relative;
    width: 1000px;
    height: 152px;
    margin: 0 auto;
    padding: 20px;
}
.position-head .position-content .position-content-l .job-name .company {
    margin: -2px 0 8px 0;
    font-size: 18px;
    color: #555;
    position: relative;
    left: 2px;
    max-width: 400px;
}
.position-head .position-content .position-content-l .job-name .name {
    position: relative;
    font-size: 36px;
    color: #333;
    line-height: 36px;
}
.position-head .position-content .position-content-l .job_request {
    margin-top: 2px;
    font-size: 18px;
    color: #555;
}
.position-head .position-content .position-content-l .job_request p {
    margin-bottom: 8px;
}
.position-head .position-content .position-content-l .job_request .publish_time {
    font-size: 14px;
    color: #999;
}
.position-head .position-content .position-content-r {
    position: absolute;
    right: 0;
    bottom: 66px;
}
.position-head .position-content .position-content-r .position-deal {
    position: relative;
}
.position-head .position-content .position-content-r .position-deal .jd_collection {
    float: right;
    display: inline-block;
    height: 44px;
    width: 104px;
    line-height: 44px;
    text-align: center;
    border: 1px solid #3b8cff;
    border-radius: 3px;
    background-color: #ebf0ef;
    cursor: pointer;
    font-size: 14px;
    color: #3b8cff;
}
.position-head .position-content .position-content-l .job-name {
    margin: 0 0 13px;
}
.position-head .position-content .position-content-r .position-deal .jd_collection i {
    display: inline-block;
    margin-right: 10px;
    vertical-align: -2px;
    font-size: 16px;
}
.content_l {
    width: 665px;
    background: url(/service/img/gradient_16fad00.png) repeat-y;
    background-position: right;
    padding-top: 26px;
}
.content_r {
    float: left;
    width: 233px;
    margin-left: 31px;
    margin-top: 45px;
}
.job_detail {
    padding-bottom: 30px;
}
.job_detail dd.job_bt {
    margin-bottom: 0;
    padding-bottom: 0;
}
.job_detail dd {
    padding: 15px 0 10px;
    color: #333;
    word-wrap: break-word;
}
.job_bt {
    font-size: 14px;
    line-height: 22px;
}
.job_bt h3.description {
    font-size: 16px;
    font-weight: 700;
    color: #333;
    line-height: 16px;
    margin-top: 5px;
}
.job_bt p {
    margin: 5px 0;
}
.job_detail .job-address {
    margin-top: -26px;
    margin-bottom: 10px;
}
.job_detail .job-address .address {
    font-size: 16px;
    color: #333;
    font-weight: 700;
}
.job_company>dt {
    position: relative;
    padding-bottom: 25px;
    margin-bottom: -10px;
}
.job_company dt a {
    color: #555;
}
.job_company>dd {
    padding: 10px 0;
}
.job_company dt div {
    position: absolute;
    left: 90px;
    bottom: 5px;
    padding: 20px 0;
    max-height: 150px;
    overflow: hidden;
}
.job_company dt h2 {
    margin-left: 21px;
    margin-bottom: 0;
    font-size: 18px;
    line-height: 18px;
    color: #555;
}
.job_company .c_feature li {
    position: relative;
    margin: 0 0 16px;
    color: #737373;
    line-height: 25px;
}
.job_company .c_feature i {
    display: inline-block;
    margin-right: 15px;
}
.recruitmentinfo-container {
	width: 1000px;
	margin: 0 auto;
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
		
		<div class="content"></div>
		
		<div id="footer">
		</div>
	</div>
</body>

<script class="template RecruitmentInfo" type="text/x-jquery-tmpl">
<div class="position-head">
	<div class="weizhi">
		<ul>
		    <li><a href="recruitment">人才服务</a></li>
		    <li><a href="recruitment">招聘信息</a></li>
		    <li class="active">职位详情</li>
		</ul>
	</div>
	<div class="position-content clearfix">
	    <div class="position-content-l pull-left">
	        <div class="job-name" title="{{=it.data.position}}">
	            <div class="company line-break"><a href="{{="talentCompany?id=" + (it.data.company != null ? it.data.company.id : "")}}" target="_blank">{{=it.data.company != null ? it.data.company.name : ""}}</a>招聘</div>
	            <span class="name">{{=it.data.position}}</span>
	        </div>
	        <dd class="job_request">
	            <p>
	                <span class="color-org">{{=$k.constant.salary[it.data.salary].name}} </span>
	                <span>/{{=it.data.area != null ? it.data.area.name : ""}} /</span>
	                <span>{{=$k.constant.workingYears[it.data.workingYears].name}} /</span>
	                <span>{{=$k.constant.education[it.data.education].name}} /</span>
	            </p>
	            <p class="publish_time">{{=new Date(it.data.createTime).format("yyyy-mm-dd")}}</p>
	        </dd>
	    </div>
	    <div class="position-content-r hidden">
	        <div class="position-deal">
	             <!-- 收藏按钮 -->
	             <a class="jd_collection passport_login_pop " id="login_position" rel="nofollow" href="javascript:;">
	             	<i class="glyphicon glyphicon-star-empty"> </i>收藏
	             </a>
	        </div>
	    </div>
	</div>
</div>
<div class="container recruitmentinfo-container" style="clear: both;">
	<div class="content_l pull-left">
		<dl class="job_detail" id="job_detail">
		    <dd class="job_bt">
		        <h3 class="description">职位描述：</h3>
		        <div>
			        <p>【岗位职责】</p>
					{{=it.data.responsibilities}}
					<p><br></p>
					<p>【任职要求】</p>
					{{=it.data.requirements}}
					<p><br></p>
		        </div>
		    </dd>
			<dd class="job-address">
	            <h3 class="address">工作地址</h3>
		        <div class="work_addr">{{=it.data.address}}</div>
			</dd>
			<dd class="job-address">
	            <h3 class="address">联系方式</h3>
		        <div class="work_addr">
		            {{=it.data.contact}}
		        </div>
			</dd>
		</dl>
	</div>
	<div class="content_r m-hidden">
		<dl class="job_company" id="job_company">
			<dt>
				<a href="{{="talentCompany?id="  + (it.data.company != null ? it.data.company.id : "")}}" target="_blank">
					<img class="b2" src="{{="./" + (it.data.company != null ? it.data.company.imagePath : "")}}" width="96" height="96">
		        	<div>
			            <h2 class="pull-left line-break">
				             {{=it.data.company != null ? it.data.company.name : ""}}
			            </h2>
		        	</div>
				</a>
			</dt>
			<dd>
		        <ul class="c_feature">
		            <li>
		                <i class="glyphicon glyphicon-th-large" title="领域"></i> {{=it.data.company != null && it.data.company.profession != null ? $k.constant.profession[it.data.company.profession].name : ""}}
		            </li>
		            <li>
		                <i class="fa fa-bookmark" title="公司性质"></i> {{=it.data.company != null ? $k.constant.property[it.data.company.property].name : ""}}
		            </li>
	                <li>
		                <i class="glyphicon glyphicon-user" title="规模"></i> {{=it.data.company != null ? $k.constant.scale[it.data.company.scale].name : ""}}
		            </li>
		            <li>
		                <i class="glyphicon glyphicon-link" title="公司网站"></i>
	                    <a class='hm-a' href="{{=it.data.company != null ? "http://" + it.data.company.website : ""}}" target="_blank" title="" rel="nofollow">{{=it.data.company != null ? it.data.company.website : ""}}</a>
	                </li>
		        </ul>
			</dd>
		</dl>
	</div>
</div>
</script>

<script>
;(function() {
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw(3);

	var $content = $(".content");
	var id = $k.util.getRequestParam("id");
	if(id == "" || id == null) {
		return;
	}
	$.ajax({
		url: "talent/recruitment/detail",
		type: "POST",
		data: {recruitmentId: id},
		success: function(data) {
			if(data.status == 0) {
				$content.html($(".template.RecruitmentInfo").doT({
					data: data.data
				}));
			}
		},
		error: function(e) {}
	});
	
})();
</script>
</html>