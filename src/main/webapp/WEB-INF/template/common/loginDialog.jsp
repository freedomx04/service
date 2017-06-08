<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<style type="text/css">
.loginDialog a.item-title {
	width: 50%;
	margin: 0 auto;
	padding: 0;
	color: #000;
	font-weight: bold;
	font-size: 18px;
}
.loginDialog a.item-title:HOVER {
	background: none;
}
.loginDialog .current {
    border-bottom: 2px solid #3b8cff
}
</style>

<script class="template LoginDialog" type="text/x-jquery-tmpl">

	<div class='modal-dialog loginDialog' style='width: 400px;'>
   		<div class='modal-content'>
      		<div class='modal-header' style='padding: 10px;'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h5 class='modal-title'>您尚未登录</h5>
      		</div>
      		<div class='modal-body' style='padding: 0 15px 15px 15px; height: 350px; color: #999;'>
				
				<div style="border-bottom: 1px solid #dedede; text-align: center;">
					<ul class="nav" style="height: 40px; line-height: 40px; font-size: 16px; margin-bottom: 0;">
						<li style="float: left; width: 50%;">
							<a class="login-item item-title current">登    录</a>
						</li>
						<li style="float: left; width: 50%;">
							<a class="register-item item-title">注    册</a>
						</li>
					</ul>
				</div>

				<div>
					<div class="login-content" style="padding: 15px 35px;">
						<form class="login-form" role="form">

							<div class="form-group">
								<div class="input-group">
									<div class="message" style="height: 24px; line-height: 24px;">请输入用户名密码：</div>
								</div>
							</div>

							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-user"></span></div>
									<input class="login-username form-control" type="text" placeholder="用户名">
								</div>
							</div>
						
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
									<input class="login-password form-control" type="password" placeholder="密码">
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
							
						</form>
					</div>
					
					<div class="register-content hidden" style="padding: 25px 35px;">
						<form class="register-form" role="form">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-user"></span></div>
									<input class="register-username form-control" type="text" placeholder="用户名" name="username">
								</div>
							</div>
						
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
									<input class="register-password form-control" type="password" placeholder="密码" name="password">
								</div>
							</div>
							
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
									<input class="register-confirm-password form-control" type="password" placeholder="确认密码" name="confirmPassword">
								</div>
							</div>
							
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-phone"></span></div>
									<input class="register-telephone form-control" type="text" placeholder="手机号码" name="telephone">
								</div>
							</div>
							
							<div class="form-group" style="padding-top: 15px;">
								<button class="submit-btn btn btn-hm" style="width: 100%;">注册</button>
							</div>
							
						</form>
					</div>
				</div>
			</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
	
</script>

<script type='text/javascript'>
;(function( $ ) {

	var fnName = 'LoginDialog';
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $('.template.' + fnName)
		},
		init: {
			value: function() {
				var self = this;
				return self;
			}
		},
		draw: {
			value: function() {
				var self = this;
				var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($('body'));
				$dialog.html(self.$tempTar.doT());
				
				var $drag = $dialog.find('#drag');
				$drag.drag();
				
				$dialog.modal({backdrop: 'static'});	
				self.registerValid($dialog.find('.register-content'));
				
				$dialog
				.on('hidden.bs.modal', function (e) {
					$dialog.remove();
				})
				.on('click', '.register-item, .login-item', function() {
					var $this = $(this);
					$dialog.find('.item-title').removeClass("current");
					$this.addClass('current');
					
					if($this.hasClass('login-item')) {
						$dialog.find('.login-content').removeClass('hidden');
						$dialog.find('.register-content').addClass('hidden');
					} else {
						$dialog.find('.login-content').addClass('hidden');
						$dialog.find('.register-content').removeClass('hidden');
					}
				})
				.submit(function(e) {
					e.stopPropagation();
					
					var $message = $dialog.find('.message');
					var username = 	$dialog.find(".login-username").val();
					var password = $dialog.find(".login-password").val();
					
					if (username == "" || password  == "") {
						$message.addClass("hm-error").text("请输入用户名密码");;
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
								location.reload(true);   								
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
				})
				.on('click', '.submit-btn', function() {
					var bootstrapValidator = $dialog.find('.register-form').data('bootstrapValidator');
					bootstrapValidator.validate();
					
					if (bootstrapValidator.isValid()) {
						$.ajax({
							url: 'user/register',
							type: "POST",
							data: {
								username: $dialog.find(".register-username").val(),
								password: $k.util.encrptByDES($dialog.find(".register-password").val()),
								telephone: $dialog.find(".register-telephone").val()
							},
							success: function(data) {
								if(data.status == 0) {
									location.reload(true); 
								}
							},
							error: function(err) {}
						});
					}
				});
				
				return self;
			}
		},
		registerValid: {
			value: function($dialog) {
				$dialog.find('form').bootstrapValidator({
					message: 'This value is not valid',
		            feedbackIcons: {
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
			}
		},
	});
	
})( jQuery );
</script>