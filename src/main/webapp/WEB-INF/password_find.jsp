<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html>
<head>
<%@ include file="/WEB-INF/include/html_head_preload.jsp"%>
<%@ include file="/WEB-INF/template/footer.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>服务平台-找回密码</title>
<style type="text/css">
h1, h2 {
    font-size: 100%;
    font-weight: 600;
    margin: 0;
}
#header {
    width: 100%;
    height: 100px;
    border-bottom: 1px solid #e3e3e3;
    background-color: #f0f0f0;
}
.header-layout {
    width: 990px;
    margin: 0 auto;
    padding: 30px 0;
    overflow: hidden;
}
#logo {
    background: url("img/service-logo.png") no-repeat;
    background-position: 0 -8px;
}
.header-layout .logo {
    float: left;
    display: inline-block;
    height: 40px;
}
#logo a {
    float: left;
    display: inline-block;
    height: 40px;
    width: 178px;
    overflow: hidden;
    text-indent: -999em;
    font-size: 12px;
}
.header-layout .logo-title {
    float: left;
    display: inline-block;
    width: auto;
    height: 30px;
    padding: 5px 0 0 10px;
    line-height: 30px;
    font-size: 24px;
    color: #303030;
}
.header-nav {
    width: auto;
    height: 14px;
    float: right;
    line-height: 14px;
    margin-top: 12px;
}
.header-nav li.nav-first {
    border-left: 0;
}
.header-nav li {
    float: left;
    padding: 0 0 0 15px;
    margin-right: 15px;
    border-left: 1px solid #6c6c6c;
}
.header-nav li a {
    color: #6c6c6c;
}
#content {
    width: 100%;
    min-height: 500px;
    border-top: 1px solid #fff;
}
.content-layout {
    margin: 0 auto;
    padding: 30px 0;
    width: 990px;
    height: auto;
}
.maincenter {
    margin: 0 auto;
    width: 774px;
    height: auto;
}
.maincenter-box {
    padding: 20px 0;
    background-color: #fff;
}
.maincenter-box-tip {
    display: block;
    padding-bottom: 10px;
}
.ui-tiptext {
    margin: 0;
    color: #6c6c6c;
    position: relative;
    font-size: 14px;
    zoom: 1;
}
.ui-tiptext-icon {
	font-size: 20px;
    text-shadow: 0 1px 0 #fff;
    position: relative;
    top: 6px;
    margin-right: 2px;
    color: #68b5e2;
}
.maincenter .ui-form {
    margin-top: 30px;
    color: #6c6c6c;
}
.ui-formm {
    margin-top: 30px;
    color: #6c6c6c;
}
#valid-name-btn, #step1-submit-btn, #step2-submit-btn {
	padding: 6px 45px;
	margin-left: 15px;
}
.form-item {
    padding: 0 5px 20px 150px;
    zoom: 1;
}
.form-label {
	padding-right: 0!important;
	width: 12%;
}
.form-label-psw {
	width: 23%;
}
.process_mod .process_img {
    background: rgba(0, 0, 0, 0) url("img/process_bg.png") no-repeat scroll 0 0;
    height: 26px;
    margin-left: 240px;
    width: 355px;
}
.process_mod .process_font {
    margin-top: 10px;
    padding-left: 218px;
}
.process_mod .process_font span.center {
    margin: 0 119px 0 100px;
}
.valid-error {
	color: #FF5243;
}
.valid-error i {
	top: 3px;
}
.valid-error span {
	font-size: 12px;
}
</style>
</head>
<body>
	<!--头部 start-->
	<div id="header">
		<div class="header-layout">
			<h1 class="logo" id="logo"><a href="index">服务平台</a></h1>
			<h2 class="logo-title">找回密码</h2>
			<ul class="header-nav">
				<li class="nav-first"><a href="login" target="_blank">注册</a></li>
				<li><a href="login" target="_blank">登录</a></li>
				<li><a href="manager" target="_blank">个人中心</a></li>
				<li><a href="" target="_blank"></a></li>
			</ul>
		</div>
	</div>
	
	<div id="content">
        <div class="content-layout">
            <div class="maincenter">
            	
            	<div class="process_mod hidden">
            		<div class="process_img"></div>
		            <p class="process_font">
		                <span>验证手机号</span>
		                <span class="center">设置密码</span>
		                <span>完成</span>
		            </p>
            	</div>
                <div class="maincenter-box">
                    <div class="maincenter-box-tip">
                        <p class="ui-tiptext">
                            <i class="glyphicon glyphicon-info-sign ui-tiptext-icon" title="提示"></i>
                          	<span>请输入你需要找回登录密码的账户名</span>
                        </p>
                    </div>
                    <form class="form-horizontal ui-form">
						<div class="form-group form-item">
					        <label for="" class="col-sm-2 control-label form-label">登录名:</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" id="username" name="username">
								<div class="valid-error hidden"><i class="glyphicon glyphicon-remove-sign"></i><span>登录名不能为空</span></div>
							</div>
            			</div>

						<div class="form-item">
							<input type="button" value="确定" class="btn btn-hm" id="valid-name-btn">
						</div>
					</form>
 				</div>
			</div>
		</div>
	</div>
	<div id="footer"></div>
</body>

<script class="template Step1" type="text/x-jquery-t">
<div class="form-group form-item">
	<label for="" class="col-sm-2 control-label form-label">手机号:</label>
	<div class="col-sm-5 " style="width: 330px;">
		<input type="text" class="form-control" id="telephone" name="telephone">
		<div class="valid-error telephone-valid-error hidden"><i class="glyphicon glyphicon-remove-sign"></i><span>手机号不能为空</span></div>
	</div>
</div>

<div class="form-group form-item">
	<label for="" class="col-sm-2 control-label form-label">验证:</label>
	<div class="input-group col-sm-5" style="padding-left: 15px;">
		<div id="drag"></div>
		<div class="valid-error drag-valid-error hidden"><i class="glyphicon glyphicon-remove-sign"></i><span>请拖动滑块验证</span></div>
	</div>
</div>

<div class="form-item">
	<input type="button" value="确定" class="btn btn-hm" id="step1-submit-btn">
</div>
</script>

<script class="template Step2" type="text/x-jquery-t">
<div class="form-group form-item">
	<label for="" class="col-sm-5 control-label form-label form-label-psw">新的登录密码:</label>
	<div class="col-sm-5">
		<input type="password" class="form-control" id="password" name="password">
		<div class="valid-error password-valid-error hidden"><i class="glyphicon glyphicon-remove-sign"></i><span>登录密码不能为空</span></div>
	</div>
</div>

<div class="form-group form-item">
	<label for="" class="col-sm-5 control-label form-label form-label-psw">确认新的登录密码:</label>
	<div class="col-sm-5">
		<input type="password" class="form-control" id="confirm-password" name="confirm-password">
		<div class="valid-error confirm-password-valid-error hidden"><i class="glyphicon glyphicon-remove-sign"></i><span>两次输入密码不一致</span></div>
	</div>
</div>

<div class="form-item">
	<input type="button" value="确定" class="btn btn-hm" id="step2-submit-btn">
</div>
</script>

<script class="template Step3" type="text/x-jquery-t">
<div style="width: 774px; margin: 0 auto; text-align: center;">
	<div>密码修改成功
		<a class="hm-a" style="margin-left: 10px;" href="login">点此登录</a>
	</div>
</div>
</script>

<script>
var $content = $("#content");
var $form = $content.find("form");
var loginname = "";

new $k.proto.Footer().init($("#footer")).draw();

$form.on("click", "#valid-name-btn" ,function(e) {
	var username = $form.find("#username").val();
	if(username != "") {
		$content.find(".valid-error").addClass("hidden");
		$.ajax({
			url: 'user/usernameExist',
			type: "POST",
			data: {
				username: username,
			},
			success: function(data) {
				if(data.status == 14) {
					$content.find(".valid-error").removeClass("hidden");
					$content.find(".valid-error span").html("用户不存在");
				} else if(data.status == 0) {
					loginname = username;
					$content.find(".process_mod").removeClass("hidden");
					$form.html($(".template.Step1").doT());
					$content.find("#drag").drag();
					$content.find(".ui-tiptext-icon").next().html("您正在使用	手机验号码 验证身份，请完成以下操作");
				}
			},
			error: function(err) {}
		});
	} else {
		$content.find(".valid-error").removeClass("hidden");
		setTimeout(function() {
			$content.find(".valid-error").addClass("hidden");
		}, 1500);
	}
});

$form.on("click", "#step1-submit-btn" ,function(e) {
	var $telephone = $content.find("#telephone");
	
	if($telephone.val() == "") {
		$content.find(".telephone-valid-error").removeClass("hidden");
		setTimeout(function() {
			$content.find(".telephone-valid-error").addClass("hidden");
		}, 1500);
	} else if ($content.find('.drag_text').text() != '验证通过') {
		$content.find(".drag-valid-error").removeClass("hidden");
		setTimeout(function() {
			$content.find(".drag-valid-error").addClass("hidden");
		}, 1500);
	} else {
		$.ajax({
			url: 'user/verifyTelephone',
			type: "POST",
			data: {
				username: loginname,
				telephone: $telephone.val(),
			},
			success: function(data) {
				if(data.status == 0) {
					$content.find(".process_img").css("background-position", "0 -31px");
					$form.html($(".template.Step2").doT());
					$content.find(".ui-tiptext-icon").next().html("您正在修改密码，请完成以下操作");
				} else {
					$content.find(".telephone-valid-error").removeClass("hidden");
					$content.find(".telephone-valid-error span").html("手机号验证失败");
					setTimeout(function() {
						$content.find(".telephone-valid-error").addClass("hidden");
					}, 1500);
					$content.find("#drag").html("").drag();
				}
			},
			error: function(err) {}
		});
	}
});

$form.on("click", "#step2-submit-btn" ,function(e) {
	var $password = $content.find("#password");
	var $confirm_password = $content.find("#confirm-password");
	if($password.val() == "") {
		$content.find(".password-valid-error").removeClass("hidden");
		$content.find(".password-valid-error span").html("登录密码不能为空");
		setTimeout(function() {
			$content.find(".password-valid-error").addClass("hidden");
		}, 1500);
	} else if($password.val().length > 12 || $password.val().length < 6) {
		$content.find(".password-valid-error").removeClass("hidden");
		$content.find(".password-valid-error span").html("登录密码长度必须在6到20之间");
		setTimeout(function() {
			$content.find(".password-valid-error").addClass("hidden");
		}, 1500);
	} else if($confirm_password.val() != $password.val()) {
		$content.find(".confirm-password-valid-error").removeClass("hidden");
		setTimeout(function() {
			$content.find(".confirm-password-valid-error").addClass("hidden");
		}, 1500);
	} else {
		$.ajax({
			url: 'user/newPassword',
			type: "POST",
			data: {
				username: loginname,
				password: $k.util.encrptByDES($password.val()),
			},
			success: function(data) {
				if(data.status == 0) {
					$content.find(".process_img").css("background-position", "0 -62px");
					$content.find(".maincenter-box-tip").addClass("hidden");
					$form.html($(".template.Step3").doT());
				}
			},
			error: function(err) {}
		});
	}
});
</script>

</html>