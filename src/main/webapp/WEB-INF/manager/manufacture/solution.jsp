<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template ManufactureSolution' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-solution-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-solution-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-solution-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='manufacture-solution-table'>
						<tr><td>
							<div class="sk-three-bounce">
								<div class="sk-child sk-bounce1"></div>
								<div class="sk-child sk-bounce2"></div>
								<div class="sk-child sk-bounce3"></div>
							</div>
						</td></tr>
					</table>
				</div>

			</div><!-- module-list -->
		</div>
	</div>

</script>

<script class='template ManufactureSolutionDialog' type='text/x-jquery-tmpl'>
	<div class="modal-dialog" style="width: 850px;">
   		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title"><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class="modal-body">
       			<form class="form-horizontal" role="form" id="manufacture-solution-form">

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
        		<button type="button" class="btn btn-hm btn-solution-confirm">确  定</button>
      		</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template ManufactureSolutionList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>标题</th>
			<th>来源</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: solution}}
		<tr class='table-tr' id="{{=solution.id}}">
			<td class="td-check"><input type='checkbox' class='check'/></td>
			<td title='{{=solution.title}}'><a class='hm-a solution-info'>{{=solution.title}}</a></td>
			<td title='{{=solution.source}}'>{{=solution.source}}</td>	
			<td>{{=$k.util.getDateString(solution.updateTime)}}</td>	
		</tr>
		{{~}}
	</tbody>
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'ManufactureSolution';
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
				.on('click', '.btn-solution-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					self.editor = new $k.proto.Editor().init($dialog.find('.article-editor')).draw();
					$dialog.modal({backdrop: 'static'});
					self.solutionValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-solution-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							$.ajax({
								url: 'manufacture/solution/add',
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
				.on('click', '.btn-solution-edit', function() {
					var solutionId = $k.util.getIds($tar);
					$.ajax({
						url: 'manufacture/solution/detail',
						type: 'POST',
						data: {
							solutionId: solutionId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							self.editor = new $k.proto.Editor().init($dialog.find(".article-editor")).draw();
							
							$dialog.find('input[name="title"]').val(data.data.title);
							$dialog.find('input[name="source"]').val(data.data.source);
							$dialog.find("#editor").html(data.data.content);
							
							$dialog.modal({backdrop: 'static'});
							self.solutionValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-solution-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									$.ajax({
										url: 'manufacture/solution/edit',
										type: 'POST',
										data: {
											solutionId: solutionId,
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
				.on('click', '.btn-solution-delete', function() {
					var solutionIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中的解决方案?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'manufacture/solution/delete',
							type: 'POST',
							data: {
								solutionIds: solutionIds,
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
				.on('click', '.solution-info', function(e) {
					e.stopPropagation();
					var solutionId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'manufacture/solution/detail',
						type: 'POST',
						data: {	solutionId: solutionId },
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
			value: function(companyId, solutions) {
				var self = this;
				self.companyId = companyId;
				self.$tar.html(self.$tempTar.doT());
				
				if (self.table) {
					self.table.destroy();
				}
				
				self.$tar.find('#manufacture-solution-table').html(
					self.$tempListTar.doT({
						data: solutions
					})
				);
				self.table = $k.util.dataTable(self.$tar.find('#manufacture-solution-table'), {
					'order': [[ 3, 'desc' ]]
				}); 
				self.$tar.find('.list-tips').text('已全部加载，共' + solutions.length + '个');
				
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
					url: 'manufacture/solution/listByCompanyId',
					type: 'POST',
					data: {
						companyId: self.companyId
					},
					success: function(data) {
						self.$tar.find('#manufacture-solution-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#manufacture-solution-table'), {
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
				
				checkCount == 1 ? $tar.find('.btn-solution-edit').removeAttr('disabled') : $tar.find('.btn-solution-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-solution-delete').removeAttr('disabled') : $tar.find('.btn-solution-delete').attr('disabled', 'disabled'); 
			}
		},
		solutionValid: {
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