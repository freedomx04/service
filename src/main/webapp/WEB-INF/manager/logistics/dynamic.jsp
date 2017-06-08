<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template LogisticsDynamic' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-dynamic-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-dynamic-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-dynamic-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='logistics-dynamic-table'>
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

<script class='template LogisticsDynamicDialog' type='text/x-jquery-tmpl'>
	<div class="modal-dialog" style="width: 850px;">
   		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title"><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class="modal-body">
       			<form class="form-horizontal" role="form">

  					<div class="form-group">
    					<label for="title" class="col-sm-2 control-label"><i class="form-required">*</i>标题:</label>
    					<div class="col-sm-9">
      						<input type="text" class="form-control" name="title">
    					</div>
  					</div>

  					<div class="form-group" style="margin-bottom: 0px;">
   						<label for="source" class="col-sm-2 control-label"><i class="form-required">*</i>来源:</label>
    					<div class="col-sm-9">
      						<input type="text" class="form-control" name="source">
    					</div>
      				</div>

					<div class="form-group">
						<div class="article-editor"></div>
					</div>

				</form>
      		<div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">取  消</button>
        		<button type="button" class="btn btn-hm btn-dynamic-confirm">确  定</button>
      		</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template LogisticsDynamicList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>标题</th>
			<th>来源</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: dynamic}}
			<tr class='table-tr' id="{{=dynamic.id}}">
				<td class="td-check"><input type='checkbox' class='check'/></td>
				<td title='{{=dynamic.title}}'><a class='hm-a dynamic-info'>{{=dynamic.title}}</a></td>
				<td title='{{=dynamic.source}}'>{{=dynamic.source}}</td>	
				<td>{{=$k.util.getDateString(dynamic.updateTime)}}</td>	
			</tr>
		{{~}}
	</tbody>
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'LogisticsDynamic';
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $('.template.' + fnName)
		},
		$tempDialogTar: {
			value: $('.template.' + fnName + 'Dialog')
		},
		$tempListTar: {
			value: $('.template.' + fnName + 'List')
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
				.on('click', '.btn-dynamic-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					self.editor = new $k.proto.Editor().init($dialog.find('.article-editor')).draw();
					$dialog.modal({backdrop: 'static'});
					self.dynamicValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-dynamic-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							$.ajax({
								url: 'logistics/dynamic/add',
								type: 'POST',
								data: {
									companyId: self.companyId,
									title: $dialog.find('input[name = "title"]').val(),
									source: $dialog.find('input[name = "source"]').val(),
									content: $dialog.find("#editor").html()
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
				.on('click', '.btn-dynamic-edit', function() {
					var dynamicId = $k.util.getIds($tar);
					$.ajax({
						url: 'logistics/dynamic/detail',
						type: 'POST',
						data: {
							dynamicId: dynamicId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							self.editor = new $k.proto.Editor().init($dialog.find(".article-editor")).draw();
							
							$dialog.find('input[name="title"]').val(data.data.title);
							$dialog.find('input[name="source"]').val(data.data.source);
							$dialog.find("#editor").html(data.data.content);
							
							$dialog.modal({backdrop: 'static'});
							self.dynamicValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-dynamic-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									$.ajax({
										url: 'logistics/dynamic/edit',
										type: 'POST',
										data: {
											dynamicId: dynamicId,
											title: $dialog.find('input[name = "title"]').val(),
											source: $dialog.find('input[name = "source"]').val(),
											content: $dialog.find("#editor").html()
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
				.on('click', '.btn-dynamic-delete', function() {
					var dynamicIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中动态?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'logistics/dynamic/delete',
							type: 'POST',
							data: {
								dynamicIds: dynamicIds,
							},
							success: function(data) {
								self.load();
								$dialog.modal('hide');
							},
							error: function(err) {
								$dialog.modal('hide');
							} 
						});
					}); 
				})
				.on('click', '.dynamic-info', function(e) {
					e.stopPropagation();
					var dynamicId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'logistics/dynamic/detail',
						type: 'POST',
						data: {	dynamicId: dynamicId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							self.editor = new $k.proto.Editor().init($dialog.find(".article-editor")).draw();
							$dialog.find('input[name="title"]').val(data.data.title);
							$dialog.find('input[name="source"]').val(data.data.source);
							$dialog.find("#editor").html(data.data.content);
							
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
			value: function(companyId, dynamics) {
				var self = this;
				self.companyId = companyId;
				self.$tar.html(self.$tempTar.doT());
				
				if (self.table) {
					self.table.destroy();
				}
				
				self.$tar.find('#logistics-dynamic-table').html(
					self.$tempListTar.doT({
						data: dynamics
					})
				);
				self.table = $k.util.dataTable(self.$tar.find('#logistics-dynamic-table'), {
					'order': [[ 3, 'desc' ]]
				}); 
				self.$tar.find('.list-tips').text('已全部加载，共' + dynamics.length + '个');
				
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
					url: 'logistics/dynamic/listByCompanyId',
					type: 'POST',
					data: {
						companyId: self.companyId
					},
					success: function(data) {
						self.$tar.find('#logistics-dynamic-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#logistics-dynamic-table'), {
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
				
				checkCount == 1 ? $tar.find('.btn-dynamic-edit').removeAttr('disabled') : $tar.find('.btn-dynamic-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-dynamic-delete').removeAttr('disabled') : $tar.find('.btn-dynamic-delete').attr('disabled', 'disabled'); 
			}
		},
		dynamicValid: {
			value: function($dialog) {
				$dialog.find('form').bootstrapValidator({
					message: 'This value is not valid',
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
					fields: {
						title: {
							validators: {
								notEmpty: {
									message: '标题不能为空'
								}
							}
						},
						source: {
							validators: {
								notEmpty: {
									message: '来源不能为空'
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