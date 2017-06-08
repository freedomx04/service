<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template Policy' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-policy-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-policy-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-policy-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='financing-policy-table'>
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

<script class='template PolicyDialog' type='text/x-jquery-tmpl'>
	<div class="modal-dialog" style="width: 850px;">
   		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title"><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class="modal-body" style='max-height: 560px; overflow: auto;'>
       			<form class="form-horizontal" role="form">

  					<div class="form-group">
    					<label for="title" class="col-sm-2 control-label"><i class="form-required">*</i>标题:</label>
    					<div class="col-sm-7">
      						<input type="text" class="form-control" name="title">
    					</div>
  					</div>

  					<div class="form-group" style="margin-bottom: 0;">
   						<label for="source" class="col-sm-2 control-label"><i class="form-required">*</i>来源:</label>
    					<div class="col-sm-7">
      						<input type="text" class="form-control" name="source">
    					</div>
      				</div>

					<div class="form-group">
						<div class="article-editor"></div>
					</div>

				</form>
      		<div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">取  消</button>
        		<button type="button" class="btn btn-hm btn-policy-confirm">确  定</button>
      		</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template PolicyList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>标题</th>
			<th>来源</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: policy}}
		<tr class='table-tr' id="{{=policy.id}}">
			<td class="td-check"><input type='checkbox' class='check'/></td>
			<td title='{{=policy.title}}'><a class='hm-a policy-info'>{{=policy.title}}</a></td>
			<td title='{{=policy.source}}'>{{=policy.source}}</td>	
			<td>{{=$k.util.getDateString(policy.updateTime)}}</td>	
		</tr>
		{{~}}
	</tbody>

</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'Policy';
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
				.on('click', '.btn-policy-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					
					$k.util.fileinput($dialog.find('#uploadImage'));
					self.editor = new $k.proto.Editor().init($dialog.find('.article-editor')).draw();
					
					$dialog.modal({backdrop: 'static'});
					self.policyValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-policy-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							var formData = new FormData($dialog.find('form')[0]); 
							formData.append("content", $dialog.find("#editor").html());
							
							$.ajax({
								url: 'financing/policy/add',
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
				})
				.on('click', '.btn-policy-edit', function() {
					var policyId = $k.util.getIds($tar);
					$.ajax({
						url: 'financing/policy/detail',
						type: 'POST',
						data: {
							policyId: policyId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							self.editor = new $k.proto.Editor().init($dialog.find(".article-editor")).draw();
							$dialog.find('input[name="title"]').val(data.data.title);
							$dialog.find('input[name="source"]').val(data.data.source);
							$dialog.find("#editor").html(data.data.content);
							
							$dialog.modal({backdrop: 'static'});
							self.policyValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-policy-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($dialog.find('form')[0]); 
									formData.append("policyId", policyId);
									formData.append("content", $dialog.find("#editor").html());
									
									$.ajax({
										url: 'financing/policy/edit',
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
				.on('click', '.btn-policy-delete', function() {
					var policyIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中的国家政策?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'financing/policy/delete',
							type: 'POST',
							data: {
								policyIds: policyIds,
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
				.on('click', '.policy-info', function(e) {
					e.stopPropagation();
					var policyId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'financing/policy/detail',
						type: 'POST',
						data: {	policyId: policyId },
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
					url: 'financing/policy/list',
					type: 'POST',
					success: function(data) {
						self.$tar.find('#financing-policy-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#financing-policy-table'), {
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
				
				checkCount == 1 ? $tar.find('.btn-policy-edit').removeAttr('disabled') : $tar.find('.btn-policy-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-policy-delete').removeAttr('disabled') : $tar.find('.btn-policy-delete').attr('disabled', 'disabled'); 
			}
		},
		policyValid: {
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