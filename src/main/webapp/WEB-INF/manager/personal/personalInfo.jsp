<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script class="template PersonalInfo" type="text/x-jquery-tmpl">

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm personalInfo-edit'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm personalInfo-changePsw'><span class='fa fa-edit fa-fw'></span>修改密码</button>
				</div>
			</div>	
		<div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>
			<div class='main-information'></div>
		</div>
	</div>	
</script>

<script class="template PersonalInfoMain" type="text/x-jquery-tmpl">
	<div class="module-list">
		<p>
			<span class="hm-label">用户名:</span>
			<span class="hm-content">{{=it.data.username}}</span>
		</p>
		<p>
			<span class="hm-label">手机号码:</span>
			<span class="hm-content">{{=it.data.telephone || ""}}</span>
		</p>
		<p>
			<span class="hm-label">角色:</span>
			<span class="hm-content">{{=it.data.role != null ? it.data.role.name: ""}}</span>
		</p>
	</div>
</script>

<script class='template PersonalInfoDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 600px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>编辑个人信息</strong></h4>
      		</div>
      		<div class='modal-body' style='max-height: 560px; overflow: auto;'>
      			<form class='personalInfo-form form-horizontal' role='form'>

					<div class="form-group">
						<label for="" class="col-sm-3 control-label"><i class="form-required">*</i>姓名:</label>
						<div class="col-sm-7">
							<input type="text" class="form-control" name="username" disabled="disabled">
						</div>
					</div>

					<!-- <div class="form-group">
						<label for="" class="col-sm-3 control-label"><i class="form-required">*</i>性别:</label>
						<div class="col-sm-7">
							<select class="form-control" id="sex" name="sex">
						        <option value="">请选择</option>
							    <option value="1">男</option>
								<option value="0">女</option>
						    </select>
						</div>
					</div> -->

					<div class="form-group">
						<label for="" class="col-sm-3 control-label"><i class="form-required">*</i>手机号码:</label>
						<div class="col-sm-7">
							<input type="text" class="form-control"  name="telephone">
						</div>
					</div>

				</form>

				<div class='modal-footer'>
        			<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        			<button type='button' class='btn btn-hm personalInfo-confirm'>确  定</button>
      			</div>
			</div>

		</div>
	</div>
</script>

<script class='template ChangePswDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 600px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>修改密码</strong></h4>
      		</div>
      		<div class='modal-body' style='max-height: 560px; overflow: auto;'>
      			<form class='changePsw-form form-horizontal' role='form'>
					<div class="form-group">
						<label for="password" class="col-sm-3 control-label"><i class="form-required">*</i>原始密码:</label>
						<div class="col-sm-7">
							<input type="password" class="form-control" name="password">
						</div>
					</div>
					<div class="form-group">
						<label for="newPassword" class="col-sm-3 control-label"><i class="form-required">*</i>新密码:</label>
						<div class="col-sm-7">
							<input type="password" class="form-control" name="newPassword">
						</div>
					</div>
					<div class="form-group">
						<label for="confirmPassword" class="col-sm-3 control-label"><i class="form-required">*</i>确认新密码:</label>
						<div class="col-sm-7">
							<input type="password" class="form-control" name="confirmPassword">
						</div>
					</div>
				</form>

				<div class='modal-footer'>
        			<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        			<button type='button' class='btn btn-hm changePsw-confirm'>确  定</button>
      			</div>
			</div>

		</div>
	</div>
</script>

<script type="text/javascript">
;(function( $ ) {
	
	var fnName = "PersonalInfo";
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $(".template." + fnName)
		},
		$tempMainTar: {
			value: $('.template.' + fnName + 'Main')
		},
		$tempDialogTar: {
			value: $('.template.' + fnName + 'Dialog')
		},
		$tempChangePswDialogTar: {
			value: $('.template.ChangePswDialog')
		},
		init: {
			value: function($tar) {
				var self = this;
				self.id = $k.user.get().id;
				self.$tar = $tar
				.on('click', '.personalInfo-edit', function() {
					$.ajax({
						url: 'user/detail',
						type: 'POST',
						data: {
							userId: self.id
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT());
							var $form = $dialog.find('form');
							
							$.each(data.data, function(ky, vl) {
								$dialog.find("[name='"+ ky +"']").val(vl);
							});
							
							$dialog.modal({backdrop: 'static'});
							self.informationValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.personalInfo-confirm', function() {
								var bootstrapValidator = $form.data('bootstrapValidator');
								bootstrapValidator.validate();
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($form[0]);
									formData.append("userId", $k.user.get().id);
									
									$.ajax({
										url: 'user/editInfo',
										type: 'POST',
										data: formData,
							          	cache: false, 
							          	contentType: false, 
							          	processData: false,
										success: function(data) {
											self.load();
											$dialog.modal('hide');
										},
										error: function(err) {
											$dialog.modal('hide');
										}
									});
								} else {
									return;
								}
							});
						},
						error: function(err) {}
					});
				})
				.on('click', '.personalInfo-changePsw', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempChangePswDialogTar.doT());
					$dialog.modal({backdrop: 'static'});
					self.pswValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.changePsw-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							$.ajax({
								url: 'user/changePassword',
								type: 'POST',
								data: {
									userId: $k.user.get().id,
									password: $k.util.encrptByDES($dialog.find('input[name = "password"]').val()),
									newPassword: $k.util.encrptByDES($dialog.find('input[name = "newPassword"]').val())
								},
								success: function(data) {
									if (data.status == 0) {
										$tar.find('.hm-alert').html($(".template.AlertSuccess").doT({
											title: '成功',
											content: '密码修改成功！！'
										}));
									} else if(data.status == 11){
										$tar.find('.hm-alert').html($(".template.AlertDanger").doT({
											title: '错误',
											content: '原密码错误！！'
										}));
									}
									$dialog.modal('hide');
								},
								error: function(err) {
									$dialog.modal('hide');
								}
 							});
						} else {
							return;
						} 
					});
				});
				return self;
			}
		},
		draw: {
			value: function() {
				var self = this;
				self.$tar.html(self.$tempTar.doT());
				
				return self;
			}
		},
		load: {
			value: function() {
				var self = this;
				
				$.ajax({
					url: 'user/detail',
					type: 'POST',
					data: {
						userId: self.id
					},
					success: function(data) {
						self.$tar.find('.main-information').html(
							self.$tempMainTar.doT({
								data: data.data
							})
						);
					},
					error: function(err) {}
				});
				return self;
			}
		},
		informationValid: {
			value: function($dialog) {
				$dialog.find('form').bootstrapValidator({
					message: 'This value is not valid',
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
		            fields: {
		            	telephone: {
			        		validators: {
			                    notEmpty: {
			                        message: '联系方式不能为空'
			                    },
			                    stringLength: {
			                        min: 11,
			                        max: 11,
			                        message: '请输入11位手机号码'
			                    },
			                    regexp: {
			                        regexp: /^1[3|5|8]{1}[0-9]{9}$/,
			                        message: '请输入正确的手机号码'
			                    }
			                }
			        	}
		            }
				});
			}
		},
		loadRole: {
			value: function($tar, role) {
				var self = this;
				var $select = $tar.find('.select-role');
				
				$k.util.getRoleList({
					success: function(data) {
						$.each(data.data, function(key, val) {
							var option = '<option value=' + val.id + '>' + val.name + '</option>';
							$(option).appendTo($select);
						})
						
						if (role) {
							$select.find('option[value="'+role.id+'"]').attr('selected', true);
						}
					}
				});
				
				return self;
			}
		},
		pswValid: {
			value: function($dialog) {
				$dialog.find('form').bootstrapValidator({
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
					fields: {
						username: {
							validators: {
								notEmpty: {
									message: '用户名不能为空'
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
						password: {
							validators: {
								notEmpty: {
									message: '密码不能为空'
								},
								stringLength: {
			                         min: 6,
			                         max: 20,
			                         message: '密码长度必须在6到20之间'
			                    },
							}
						},
						newPassword: {
							validators: {
								notEmpty: {
									message: '新密码不能为空'
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
									field: 'newPassword',
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
