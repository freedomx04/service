<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html>
<head>
<%@ include file="/WEB-INF/include/html_head_preload.jsp"%>
<%@ include file="/WEB-INF/template/footer.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>服务平台-欢迎登录</title>
<style type="text/css">
.loginPage a.item-title {
	width: 50%;
	margin: 0 auto;
	padding: 0;
	color: #000;
	font-weight: bold;
	font-size: 18px;
}
.loginPage a.item-title:HOVER {
	background: none;
}
.loginPage .current {
    border-bottom: 2px solid #3b8cff;
}
</style>
</head>
<body>
	<div style="width: 1024px; margin: 0 auto;">
		<div class="header" style="height: 100px; padding-top: 30px;">
			<a class="logo-bg" href="index"></a>
		</div>
		
		<div class="loginPage" style="width:1024px; height: 475px; background-image: url('img/login.png'); position: relative;">
			<div style="width: 350px; height: 400px; float: right; background: white; margin: 40px 40px 0 0; color: #999;">
			
				<div style="border-bottom: 1px solid #dedede; text-align: center;">
					<ul class="nav" style="height: 50px; line-height: 50px; font-size: 16px; margin-bottom: 0">
						<li style="float: left; width: 50%;">
							<a class="login-item item-title current">登    录</a>
						</li>
						<li style="float: left; width: 50%;">
							<a class="register-item item-title">注    册</a>
						</li>
					</ul>
				</div>
				
				<div>
					<div class="login-content" style="padding: 15px 25px;">
						<form class="login-form" role="form">
							<div class="form-group">
								<div class="input-group">
									<div class="message" style="height: 24px; line-height: 24px;">请输入用户名密码：</div>
								</div>
							</div>
						
						
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-user"></span></div>
									<input class="form-username form-control" type="text" placeholder="用户名">
								</div>
							</div>
						
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
									<input class="form-password form-control" type="password" placeholder="密码">
								</div>
							</div>
							
							<div class="form-group">
								<div class="input-group">
									<div id="drag"></div>
								</div>
							</div>
							
							<div class="form-group text-right">
								<a class="hm-a" href="password_find" target="_blank">忘记密码</a>
							</div>
						
							<div class="form-group">
								<button type="submit" class="submit-btn btn btn-hm" style="width: 100%">登      录</button>
							</div>
							
							<div class="form-group">
								<label style="font-weight: normal;">其他登录方式：</label>
								<a class="hm-a other-login" data-web="guangchang">广昌工业平台</a>
								<!-- <a class="hm-a other-login" data-web="nancheng" style="padding-left: 10px;">南城工业平台</a> -->
							</div>
							
						</form>
					</div>
					
					<div class="register-content hidden" style="padding: 25px;">
						
						<form class="register-form" role="form">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-user"></span></div>
									<input class="form-username form-control" type="text" placeholder="用户名" name="username">
								</div>
							</div>
						
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
									<input class="form-password form-control" type="password" placeholder="密码" name="password">
								</div>
							</div>
							
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
									<input class="form-confirm-password form-control" type="password" placeholder="确认密码" name="confirmPassword">
								</div>
							</div>
							
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-phone"></span></div>
									<input class="form-telephone form-control" type="text" placeholder="手机号码" name="telephone">
								</div>
							</div>
							
							<div class="form-group">
								<button class="submit-btn btn btn-hm" style="width: 100%;">注册</button>
							</div>
							
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<div id="footer"></div>
	</div>
	
	<script type="text/javascript">
		
		var $page = $(".loginPage");
		var $loginForm = $(".login-form");
		var $registerForm = $(".register-form");
		
		new $k.proto.Footer().init($("#footer")).draw();
		
		var $drag = $page.find('#drag');
		$drag.drag();
		
		$loginForm.submit(function(e) {
			var $message = $loginForm.find('.message');
			var username = 	$loginForm.find(".form-username").val();
			var password = $loginForm.find(".form-password").val();
			
			if (username == "" || password == "") {
				$message.addClass("hm-error").text("请输入用户名密码");
				return false;
			}
			
			if ($drag.find('.drag_text').text() != '验证通过') {
				$message.addClass("hm-error").text("请拖动滑块验证");
				return false;
			}
			
			$.ajax({
				url: 'user/login',
				type: "POST",
				data:{
					username: username,
					password: $k.util.encrptByDES(password)
				},
				success: function(data) {
					switch (data.status) {
					case 0:		
						window.location.href = "./index";						
						break;
					case 2:		
						$message.addClass("hm-error").text("您输入的用户不存在");	
						$drag.html("").drag();
						break;
					case 11:	
						$message.addClass("hm-error").text("您输入的密码错误");
						$drag.html("").drag();
						break;
					case 13:	
						$message.addClass("hm-error").text("该用户已被禁用");	
						$drag.html("").drag();
						break;
					default:	
						break;
					}
				},
				error: function(err) {}
			});
			
			return false;
		});
	
		$registerForm.on("click", ".submit-btn" ,function(e) {
			var bootstrapValidator = $registerForm.data('bootstrapValidator');
			bootstrapValidator.validate();
			
			if(bootstrapValidator.isValid()) {
				$.ajax({
					url: 'user/register',
					type: "POST",
					data: {
						username: $registerForm.find(".form-username").val(),
						password: $k.util.encrptByDES($registerForm.find(".form-password").val()),
						telephone: $registerForm.find(".form-telephone").val()
					},
					success: function(data) {
						if(data.status == 0) {
							window.location.href = "./index";
						}
					},
					error: function(err) {}
				});
			}
			return false;
		});
		
		$registerForm.bootstrapValidator({
			message: 'This value is not valid',
	        feedbackIcons: {/*input状态样式图片*/
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	        	username: {
	                 validators: {
	                     notEmpty: {
	                         message: '姓名不能为空'
	                     },
	                     stringLength: {
	                         min: 6,
	                         max: 20,
	                         message: '用户名长度必须在6到20之间'
	                    },
	                    threshold: 6,
	                    remote: {
	                    	url: 'user/exist',
	                    	message: '用户已存在',
	                    	delay: 1000,
	                    	type: 'POST',
	                    }
	                 }
	        	},
	        	telephone: {
	                validators: {
	                    notEmpty: {
	                        message: '手机号码不能为空'
	                    },
	                    regexp: {
	                        regexp: /^1[3|5|8]{1}[0-9]{9}$/,
	                        message: '请输入正确的手机号码'
	                    }
	                }
	       		},
	       		password: {
					validators: {
						notEmpty: {
							message: '密码不能为空'
						},
						identical: {
							field: 'confirmPassword',
							message: '输入的两次密码不一致'
						},
						stringLength: {
	                         min: 6,
	                         max: 20,
	                         message: '密码长度必须在6到20之间'
	                    },
					}
				},
	       		confirmPassword: {
					validators: {
						notEmpty: {
							message: '确认密码不能为空'
						},
						identical: {
							field: 'password',
							message: '输入的两次密码不一致'
						},
						stringLength: {
	                         min: 6,
	                         max: 20,
	                         message: '密码长度必须在6到20之间'
	                    },
					}
				}
	        }
		});
		
		$page
		.on("click", ".register-item, .login-item", function() {
			var $this = $(this);
			$page.find('.item-title').removeClass("current");
			$this.addClass('current');
			
			if($this.hasClass('login-item')) {
				$page.find('.login-content').removeClass('hidden');
				$page.find('.register-content').addClass('hidden');
			} else {
				$page.find('.login-content').addClass('hidden');
				$page.find('.register-content').removeClass('hidden');
			}
		})
		.on('click', '.other-login', function() {
			var web = $(this).data('web');
			var redirect = window.location.href.replace('login', 'index');
			
			switch (web) {
			case 'guangchang':
				window.location = $k.config.guangchangLogin + '?redirect=' + redirect;
				break;
			case 'nancheng':
				break;
			default: 
				break;
			}
		});
		
	</script>
	
</body>
</html>