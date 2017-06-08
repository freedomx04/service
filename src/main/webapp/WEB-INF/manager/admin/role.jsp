<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script class="template Role" type="text/x-jquery-tmpl">

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-role-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-role-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-role-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='role-table'>
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
				
			</div>	<!-- module-list -->
		</div>
	</div>	
</script>

<script class="template RoleDialog" type="text/x-jquery-tmpl">
	<div class='modal-dialog' style='width: 640px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class='modal-body' style='max-height: 560px; overflow: auto;'>
       			<form class='article-form form-horizontal' role='form'>

  					<div class='form-group'>
    					<label for='name' class='col-sm-3 control-label'><i class="form-required">*</i>名称:</label>
    					<div class='col-sm-7'>
      						<input type='text' class='form-control' name='name'>
    					</div>
  					</div>

					<div class='form-group'>
   						<label for='description' class='col-sm-3 control-label'><i class="form-required">*</i>描述:</label>
    					<div class='col-sm-7'>
      						<input type='text' class='form-control' name='description'>
    					</div>
      				</div>

					{{~ $k.constant.resource: module}}
					<div class='form-group'>
						<label for='resourceName' class='col-sm-3 control-label'>{{=module.name}}:</label>
						<div class='col-sm-8'>
							{{~ module.list: sub}}
							<label class="checkbox-inline">
								<input type="checkbox" class="{{=sub.value}}" name="role-resource" value="{{=sub.value}}">{{=sub.name}}
                            </label>
							{{~}}
						</div>
					</div>
					{{~}}

				</form>
      		<div class='modal-footer'>
        		<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        		<button type='button' class='btn btn-hm btn-role-confirm'>确  定</button>
      		</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->	
</script>

<script class="template RoleList" type="text/x-jquery-tmpl">
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th class="td-role-name">名称</th>
			<th class="td-role-description">描述</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: role}}
			<tr class='table-tr' id="{{=role.id}}">
				<td class="td-check"><input type='checkbox' class='check'/></td>
				<td title='{{=role.name}}'><a class='hm-a role-info'>{{=role.name}}</a></td>
				<td title='{{=role.description}}'>{{=role.description}}</td>	
				<td>{{=$k.util.getDateString(role.updateTime)}}</td>
			</tr>
		{{~}}	
	</tbody>

</script>


<script type="text/javascript">
;(function( $ ) {
	
	var fnName = "Role";
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
				.on('click', '.btn-role-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					$dialog.modal({backdrop: 'static'});
					self.roleValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-role-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						var checkeds = [];
						$dialog.find('[name="role-resource"]').each(function() {
							if ($(this).prop("checked") == true) {
								checkeds.push($(this).val());
							}
						});
						
						if (bootstrapValidator.isValid()) {
							$.ajax({
								url: 'role/add',
								type: 'POST',
								data: {
									name: $dialog.find('input[name = "name"]').val(),
									description: $dialog.find('input[name = "description"]').val(),
									resource: checkeds.join(',')
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
				.on('click', '.btn-role-edit', function() {
					var roleId = $k.util.getIds($tar);
					$.ajax({
						url: 'role/detail',
						type: 'POST',
						data: {
							roleId: roleId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$dialog.find('input[name="name"]').val(data.data.name);
							$dialog.find('input[name="description"]').val(data.data.description);
							var resourceList = data.data.resource.split(',');
							$.each(resourceList, function(key, val) {
								$dialog.find('.' + val + '').prop('checked', true);
							})
							
							$dialog.modal({backdrop: 'static'});
							self.roleValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-role-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								var checkeds = [];
								$dialog.find('[name="role-resource"]').each(function() {
									if ($(this).prop("checked") == true) {
										checkeds.push($(this).val());
									}
								});
								
								if (bootstrapValidator.isValid()) {
									$.ajax({
										url: 'role/edit',
										type: 'POST',
										data: {
											roleId: roleId,
											name: $dialog.find('input[name = "name"]').val(),
											description: $dialog.find('input[name = "description"]').val(),
											resource: checkeds.join(',')
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
				.on('click', '.btn-role-delete', function() {
					var roleIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中的用户?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'role/delete',
							type: 'POST',
							data: {
								roleIds: roleIds,
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
				.on('click', '.role-info', function(e) {
					e.stopPropagation();
					var roleId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'role/detail',
						type: 'POST',
						data: {	roleId: roleId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							$dialog.find('input[name="name"]').val(data.data.name);
							$dialog.find('input[name="description"]').val(data.data.description);
							var resourceList = data.data.resource.split(',');
							$.each(resourceList, function(key, val) {
								$dialog.find('.' + val + '').prop('checked', true);
							})
							
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
					url: 'role/list',
					type: 'POST',
					success: function(data) {
						self.$tar.find('#role-table').html(
							$('.template.RoleList').doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(
							self.$tar.find('#role-table'), {
								'order': [[ 3, 'desc' ]],
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
				$tar.find('.check').each(function(k, v) {
					if (v.checked == true) {
						checkCount += 1;
					}
				});
				
				checkCount == 1 ? $tar.find('.btn-role-edit').removeAttr('disabled') : $tar.find('.btn-role-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-role-delete').removeAttr('disabled') : $tar.find('.btn-role-delete').attr('disabled', 'disabled'); 
			}
		},
		roleValid: {
			value: function($dialog) {
				$dialog.find('form').bootstrapValidator({
					message: 'This value is not valid',
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
					fields: {
						name: {
							validators: {
								notEmpty: {
									message: '名称不能为空'
								}
							}
						},
						description: {
							validators: {
								notEmpty: {
									message: '描述不能为空'
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
