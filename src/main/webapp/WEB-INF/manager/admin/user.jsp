<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script class="template User" type="text/x-jquery-tmpl">

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-user-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-user-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-user-status' disabled='disabled'><span class='fa fa-ban fa-fw'></span><span class="span-user-status">禁用</span></button>
					<button type='button' class='btn btn-hm btn-user-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
				</div>
			</div>	
		<div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-list'>
				<div class='module-history-list col-sm-6' style="height: 35px; line-height: 35px; float: left;">
					<span class='list-tips'>正在加载</span>
				</div>	

				<div class='list-table' tyle='font-size: 12px;'>
					<table class='table table-hover hm-table' id='user-table'>
						<tr>
							<td>
								<div class="sk-three-bounce">
									<div class="sk-child sk-bounce1"></div>
									<div class="sk-child sk-bounce2"></div>
									<div class="sk-child sk-bounce3"></div>
								</div>
							</td>
						</tr>
					</table>
				</div>

			</div><!-- module-list -->
		</div>
	</div>
</script>

<script class='template UserDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 640px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class='modal-body'>
       			<form class='user-form form-horizontal' role='form'>

					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-info-circle"></i> 基本信息
						</div>
						<div class="panel-body">

  							<div class='form-group form-username'>
    							<label for='username' class='col-sm-3 control-label'><i class="form-required">*</i>用户名:</label>
    							<div class='col-sm-7'>
      								<input type='text' class='form-control' name='username'>
    							</div>
  							</div>

							<div class='form-group form-password'>
   								<label for='password' class='col-sm-3 control-label'><i class="form-required">*</i>密码:</label>
    							<div class='col-sm-7'>
      								<input type='password' class='form-control' name='password'>
    							</div>
      						</div>

							<div class='form-group'>
   								<label for='role' class='col-sm-3 control-label'><i class="form-required">*</i>角色:</label>
    							<div class='col-sm-7'>
      								<select class="form-control select-role" name="role">
										<option value="">请选择</option>
									</select>
    							</div>
      						</div>

							<div class='form-group'>
   								<label for='telephone' class='col-sm-3 control-label'><i class="form-required">*</i>联系电话:</label>
    							<div class='col-sm-7'>
      								<input type='text' class='form-control' name='telephone'>
    							</div>
      						</div>

						</div>
					</div>


				</form>
      		<div class='modal-footer'>
        		<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        		<button type='button' class='btn btn-hm btn-user-confirm'>确  定</button>
      		</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template UserList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th class="td-user-username">用户名</th>
			<th class="td-user-role">角色</th>
			<th class="td-user-telephone">联系电话</th>
			<th class="td-user-status">状态</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: user}}
		<tr class='table-tr' id="{{=user.id}}">
			<td class="td-check"><input type='checkbox' class='check'/></td>
			<td title='{{=user.username}}'><a class='hm-a user-info'>{{=user.username}}</a></td>
			<td>{{=user.role ? user.role.name : ''}}</td>
			<td>{{=user.telephone}}</td>	
			<td class="td-user-status" status={{=user.status}}>{{=(user.status == 1 ? '正常' : '禁用')}}</td>
		</tr>
		{{~}}
	</tbody>
</script>

<script type="text/javascript">
;(function( $ ) {
	
	var fnName = "User";
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $(".template." + fnName)
		},
		$tempDialogTar: {
			value: $('.template.' + fnName + 'Dialog')
		},
		init: {
			value: function($tar) {
				var self = this;
				self.$tar = $tar
				.on('click', '.table-tr, .check', function(e) {
					e.stopPropagation();
					$(this).find('.check').trigger('click');
				})
				.on('change', '.check-all', function(e) {
					e.stopPropagation();
					$tar.find('.check').prop('checked', this.checked);
					self.updateBar($tar);
				})
				.on('change', '.check', function() {
					self.updateBar($tar);
				})
				.on('click', '.btn-user-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					self.loadRole($dialog);
					$dialog.modal({backdrop: 'static'});
					self.userValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-user-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							$.ajax({
								url: 'user/add',
								type: 'POST',
								data: {
									username: $dialog.find('input[name = "username"]').val(),
									password: $k.util.encrptByDES($dialog.find('input[name = "password"]').val()),
									roleId: $dialog.find('.select-role').val(),
									telephone: $dialog.find('input[name = "telephone"]').val()
								},
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
				})
				.on('click', '.btn-user-edit', function() {
					var userId = $k.util.getIds($tar);
					$.ajax({
						url: 'user/detail',
						type: 'POST',
						data: {
							userId: userId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$.each(data.data, function(key, val) {
								if (key == 'password') {
									$dialog.find('.form-password').hide();
								} else if (key == 'username') {
									$dialog.find('[name="username"]').val(val);
									$dialog.find('[name="username"]').attr("disabled", "disabled");
								} else if (key == 'role') {
									self.loadRole($dialog, val);
								} else {
									$dialog.find("[name='"+ key +"']").val(val);
								}
							});
							
							$dialog.modal({backdrop: 'static'});
							self.userValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-user-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									$.ajax({
										url: 'user/edit',
										type: 'POST',
										data: {
											userId: userId,
											roleId: $dialog.find('.select-role').val(),
											telephone: $dialog.find('input[name = "telephone"]').val(),
										},
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
				.on('click', '.btn-user-status', function() {
					var userId = $k.util.getIds($tar);
					var status = $(this).find('span').hasClass('fa-ban') ? 0 : 1;
					
					$.ajax({
						url: 'user/status',
						type: 'POST',
						data: {
							userId: userId,
							status: status
						},
						success: function(data) {
							self.load();
						},
						error: function(data) {}
					});
				})
				.on('click', '.btn-user-delete', function() {
					var userIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除用户",
						content: "是否删除选中的用户?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'user/delete',
							type: 'POST',
							data: {
								userIds: userIds,
							},
							success: function(data) {
								if (data.status == 0) {
									self.load();
								} else if(data.status == 4){
									$tar.find('.hm-alert').html($(".template.AlertDanger").doT({
										title: '错误',
										content: '该记录正在使用，请先删除关联记录，再进行删除！！'
									}));
								}
								$dialog.modal('hide');
							},
							error: function(err) {
								$dialog.modal('hide');
							} 
						});
					}); 
				})
				.on('click', '.user-info', function(e) {
					e.stopPropagation();
					var userId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'user/detail',
						type: 'POST',
						data: {	userId: userId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							$.each(data.data, function(key, val) {
								if (key == 'password') {
									$dialog.find('.form-password').hide();
								} else if (key == 'username') {
									$dialog.find('[name="username"]').val(val);
								} else if (key == 'role') {
									self.loadRole($dialog, val);
								} else {
									$dialog.find("[name='"+ key +"']").val(val);
								}
							});
							
							$k.util.disabled($dialog);
							$dialog.modal({backdrop: 'static'});
						},
						error: function(err) {}
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
				
				if (self.table) {
					self.table.destroy();
				}
				
				$.ajax({
					url: 'user/list',
					type: 'POST',
					success: function(data) {
						self.$tar.find('#user-table').html(
							$('.template.UserList').doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(
							self.$tar.find('#user-table'), {
								'order': [[ 1, 'asc' ]],
							}); 
								
						self.$tar.find('.list-tips').text('已全部加载，共' + data.data.length + '个');
						self.updateBar(self.$tar);
					},
					error: function(err) {}
				});
				
				return self;
			}
		},
		updateBar: {
			value: function($tar) {
				var checkCount = 0;
				var $check;
				$tar.find('.check').each(function(k, v) {
					if (v.checked == true) {
						checkCount += 1;
						$check = v;
					}
				});
				
				checkCount == 1 ? $tar.find('.btn-user-edit').removeAttr('disabled') : $tar.find('.btn-user-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-user-delete').removeAttr('disabled') : $tar.find('.btn-user-delete').attr('disabled', 'disabled');
				
				if (checkCount == 1) {
					$tar.find('.btn-user-status').removeAttr('disabled');
					
					var $tr = $($check).closest('.table-tr');
					var status = $tr.find('.td-user-status').attr('status');
					
					if (status == 1) {
						$tar.find('.btn-user-status span.fa').removeClass('fa-user').addClass('fa-ban');
						$tar.find('.btn-user-status span.span-user-status').text('禁用');
					} else {
						$tar.find('.btn-user-status span.fa').removeClass('fa-ban').addClass('fa-user')
						$tar.find('.btn-user-status span.span-user-status').text('启用');
					}
					
				} else {
					$tar.find('.btn-user-status').attr('disabled', 'disabled');
				}
				
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
		userValid: {
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
						role: {
			        		validators: {
			                    notEmpty: {
			                        message: '角色不能为空'
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
					}
				});
			}
		},
	});
	
})( jQuery );
</script>
