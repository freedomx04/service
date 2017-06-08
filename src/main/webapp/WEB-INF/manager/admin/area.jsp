<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<style type='text/css'>
</style>

<script class='template Area' type='text/x-jquery-tmpl'>

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-area-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-area-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-area-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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

				<div class='list-table' style='font-size: 12px;'>
					<table class='table table-hover hm-table' id='area-table'>
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

<script class='template AreaDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 600px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class='modal-body'>
       			<form class='area-form form-horizontal' role='form'>

  					<div class='form-group'>
    					<label for='name' class='col-sm-3 control-label'><i class="form-required">*</i>名称:</label>
    					<div class='col-sm-7'>
      						<input type='text' class='form-control' name='name'>
    					</div>
  					</div>

					<div class='form-group'>
   						<label for='description' class='col-sm-3 control-label'>描述:</label>
    					<div class='col-sm-7'>
      						<input type='text' class='form-control' name='description'>
    					</div>
      				</div>

				</form>

      			<div class='modal-footer'>
        			<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        			<button type='button' class='btn btn-hm btn-area-confirm'>确  定</button>
      			</div>
		
			</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template AreaList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th class="td-area-name">名称</th>
			<th class="td-area-description">描述</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: area}}
			<tr class='table-tr' id="{{=area.id}}">
				<td class="td-check"><input type='checkbox' class='check'/></td>
				<td title='{{=area.name}}'><a class='hm-a area-info'>{{=area.name}}</a></td>
				<td title='{{=area.description}}'>{{=area.description}}</td>	
				<td>{{=$k.util.getDateString(area.updateTime)}}</td>
			</tr>
		{{~}}
	</tbody>
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'Area';
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $('.template.' + fnName)
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
				.on('click', '.btn-area-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					$dialog.modal({backdrop: 'static'});
					self.areaValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-area-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							$.ajax({
								url: 'area/add',
								type: 'POST',
								data: {
									name: $dialog.find('input[name = "name"]').val(),
									description: $dialog.find('input[name = "description"]').val(),
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
				.on('click', '.btn-area-edit', function() {
					var areaId = $k.util.getIds($tar);
					$.ajax({
						url: 'area/detail',
						type: 'POST',
						data: {
							areaId: areaId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$dialog.find('input[name="name"]').val(data.data.name);
							$dialog.find('input[name="description"]').val(data.data.description);
							
							$dialog.modal({backdrop: 'static'});
							self.areaValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-area-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									$.ajax({
										url: 'area/edit',
										type: 'POST',
										data: {
											areaId: areaId,
											name: $dialog.find('input[name = "name"]').val(),
											description: $dialog.find('input[name = "description"]').val(),
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
				.on('click', '.btn-area-delete', function() {
					var areaIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中区域?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'area/delete',
							type: 'POST',
							data: {
								areaIds: areaIds,
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
				.on('click', '.area-info', function(e) {
					e.stopPropagation();
					var areaId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'area/detail',
						type: 'POST',
						data: {	areaId: areaId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							$.each(data.data, function(key, val) {
								$dialog.find("[name='"+ key +"']").val(val);
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
					url: 'area/list',
					type: 'POST',
					success: function(data) {
						self.$tar.find('#area-table').html(
							$('.template.AreaList').doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(
							self.$tar.find('#area-table'), {
								'order': [[ 3, 'desc' ]]
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
				
				checkCount == 1 ? $tar.find('.btn-area-edit').removeAttr('disabled') : $tar.find('.btn-area-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-area-delete').removeAttr('disabled') : $tar.find('.btn-area-delete').attr('disabled', 'disabled'); 
			}
		},
		areaValid: {
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
					}
				});
			}
		},
	});
	
})( jQuery );
</script>
