<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template Bulletin' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-bulletin-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-bulletin-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-bulletin-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='manufacture-bulletin-table'>
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

<script class='template BulletinDialog' type='text/x-jquery-tmpl'>
	<div class="modal-dialog" style="width: 850px;">
   		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title"><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class="modal-body" style='max-height: 580px; overflow: auto;'>
       			<form class="form-horizontal" role="form">

  					<div class="form-group">
    					<label for="title" class="col-sm-2 control-label"><i class="form-required">*</i>标题:</label>
    					<div class="col-sm-7">
      						<input type="text" class="form-control" name="title">
    					</div>
  					</div>

  					<div class="form-group">
   						<label for="source" class="col-sm-2 control-label"><i class="form-required">*</i>来源:</label>
    					<div class="col-sm-7">
      						<input type="text" class="form-control" name="source">
    					</div>
      				</div>

					<div class="form-group" style="margin-bottom: 0px;">
						<label for="uploadImage" class="col-sm-2 control-label"><i class="form-required">*</i>图片:</label>
						<div class="col-sm-7">
							<input type="file" class="form-control file-loading" id="uploadImage" name="uploadImage">
						</div>
					</div>

					<div class="form-group">
						<div class="article-editor"></div>
					</div>

				</form>
      		<div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">取  消</button>
        		<button type="button" class="btn btn-hm btn-bulletin-confirm">确  定</button>
      		</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template BulletinList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>标题</th>
			<th>来源</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: bulletin}}
		<tr class='table-tr' id="{{=bulletin.id}}">
			<td class="td-check"><input type='checkbox' class='check'/></td>
			<td title='{{=bulletin.title}}'><a class='hm-a bulletin-info'>{{=bulletin.title}}</a></td>
			<td title='{{=bulletin.source}}'>{{=bulletin.source}}</td>	
			<td>{{=$k.util.getDateString(bulletin.updateTime)}}</td>	
		</tr>
		{{~}}
	</tbody>

</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'Bulletin';
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
				.on('click', '.btn-bulletin-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					
					$k.util.fileinput($dialog.find('#uploadImage'));
					self.editor = new $k.proto.Editor().init($dialog.find('.article-editor')).draw();
					
					$dialog.modal({backdrop: 'static'});
					self.bulletinValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-bulletin-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							var formData = new FormData($dialog.find('form')[0]); 
							formData.append("type", self.type);
							formData.append("content", $dialog.find("#editor").html());
							
							$.ajax({
								url: 'manufacture/bulletin/add',
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
				.on('click', '.btn-bulletin-edit', function() {
					var bulletinId = $k.util.getIds($tar);
					$.ajax({
						url: 'manufacture/bulletin/detail',
						type: 'POST',
						data: {
							bulletinId: bulletinId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$k.util.fileinput($dialog.find('#uploadImage'), {
								initialPreview:	"<img src='" + data.data.imagePath + "' class='file-preview-image'>"
							});
							self.editor = new $k.proto.Editor().init($dialog.find(".article-editor")).draw();
							$dialog.find('input[name="title"]').val(data.data.title);
							$dialog.find('input[name="source"]').val(data.data.source);
							$dialog.find("#editor").html(data.data.content);
							
							$dialog.modal({backdrop: 'static'});
							self.bulletinValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-bulletin-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.removeField('uploadImage');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($dialog.find('form')[0]); 
									formData.append("bulletinId", bulletinId);
									formData.append("content", $dialog.find("#editor").html());
									
									$.ajax({
										url: 'manufacture/bulletin/edit',
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
				.on('click', '.btn-bulletin-delete', function() {
					var bulletinIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中的智能快报?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'manufacture/bulletin/delete',
							type: 'POST',
							data: {
								bulletinIds: bulletinIds,
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
				.on('click', '.bulletin-info', function(e) {
					e.stopPropagation();
					var bulletinId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'manufacture/bulletin/detail',
						type: 'POST',
						data: {	bulletinId: bulletinId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							$k.util.fileinputDisabled($dialog.find('#uploadImage'), {
								initialPreview:	"<img src='" + data.data.imagePath + "' class='file-preview-image'>"
							});
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
			value: function(type) {
				var self = this;
				self.type = type;
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
					url: 'manufacture/bulletin/listByType',
					type: 'POST',
					data: {
						type: self.type
					},
					success: function(data) {
						self.$tar.find('#manufacture-bulletin-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#manufacture-bulletin-table'), {
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
				
				checkCount == 1 ? $tar.find('.btn-bulletin-edit').removeAttr('disabled') : $tar.find('.btn-bulletin-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-bulletin-delete').removeAttr('disabled') : $tar.find('.btn-bulletin-delete').attr('disabled', 'disabled'); 
			}
		},
		bulletinValid: {
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
						uploadImage: {
							validators: {
								notEmpty: {
									message: '图片不能为空'
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