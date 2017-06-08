<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template Purchase' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-purchase-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-purchase-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-purchase-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='manufacture-purchase-table'>
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

<script class='template PurchaseDialog' type='text/x-jquery-tmpl'>
	<div class="modal-dialog" style="width: 600px;">
   		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title"><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class="modal-body" style='max-height: 560px; overflow: auto;'>
       			<form class="form-horizontal" role="form">

  					<div class="form-group">
    					<label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>采购标题:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="name">
    					</div>
  					</div>

  					<div class="form-group">
   						<label for="num" class="col-sm-3 control-label"><i class="form-required">*</i>采购数量:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="num">
    					</div>
      				</div>

  					<div class="form-group">
   						<label for="location" class="col-sm-3 control-label"><i class="form-required">*</i>所在地:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="location">
    					</div>
      				</div>

  					<div class="form-group">
   						<label for="contactUser" class="col-sm-3 control-label"><i class="form-required">*</i>联系人:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="contactUser">
    					</div>
      				</div>

  					<div class="form-group">
   						<label for="contact" class="col-sm-3 control-label"><i class="form-required">*</i>联系方式:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="contact">
    					</div>
      				</div>

					<div class="form-group">
   						<label for="description" class="col-sm-3 control-label"><i class="form-required">*</i>详细描述:</label>
    					<div class="col-sm-8">
      						<textarea class="form-control" rows="6" name="description"></textarea>
    					</div>
      				</div>

				</form>
      		<div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">取  消</button>
        		<button type="button" class="btn btn-hm btn-purchase-confirm">确  定</button>
      		</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template PurchaseList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>采购标题</th>
			<th>采购数量</th>
			<th>所在地</th>
			<th>联系人</th>
			<th>联系方式</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: purchase}}
		<tr class='table-tr' id="{{=purchase.id}}">
			<td class="td-check"><input type='checkbox' class='check'/></td>
			<td title='{{=purchase.name}}'><a class='hm-a purchase-info'>{{=purchase.name}}</a></td>
			<td>{{=purchase.num}}</td>
			<td>{{=purchase.location}}</td>
			<td>{{=purchase.contactUser}}</td>
			<td>{{=purchase.contact}}</td>
			<td>{{=$k.util.getDateString(purchase.updateTime)}}</td>	
		</tr>
		{{~}}
	</tbody>
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'Purchase';
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
				.on('change', '#clazz', function() {
					var clazz = $(this).val();
					var $subCLazz = $tar.find('#subClazz');
					$subCLazz.empty();
					$.each($k.constant.clazz.where('o.value == "' + clazz + '"')[0].subClazz, function(key, val) {
						$('<option value="'+ val.value +'">'+ val.name + '</option>').appendTo($subCLazz);
					});
				})
				.on('click', '.btn-purchase-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					$dialog.modal({backdrop: 'static'});
					self.purchaseValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-purchase-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							var formData = new FormData($dialog.find('form')[0]); 
							formData.append("userId", $k.user.get().id);
							
							$.ajax({
								url: 'manufacture/purchase/add',
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
				.on('click', '.btn-purchase-edit', function() {
					var purchaseId = $k.util.getIds($tar);
					$.ajax({
						url: 'manufacture/purchase/detail',
						type: 'POST',
						data: {
							purchaseId: purchaseId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$.each(data.data, function(key, val) {
								$dialog.find("[name='"+ key +"']").val(val);
							});
							
							$dialog.modal({backdrop: 'static'});
							self.purchaseValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-purchase-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($dialog.find('form')[0]); 
									formData.append("purchaseId", purchaseId);
									$.ajax({
										url: 'manufacture/purchase/edit',
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
				.on('click', '.btn-purchase-delete', function() {
					var purchaseIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中的供应产品?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'manufacture/purchase/delete',
							type: 'POST',
							data: {
								purchaseIds: purchaseIds,
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
				.on('click', '.purchase-info', function(e) {
					e.stopPropagation();
					var purchaseId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'manufacture/purchase/detail',
						type: 'POST',
						data: {	purchaseId: purchaseId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							$.each(data.data, function(key, val) {
								$dialog.find('[name=' + key + ']').val(val);
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
					url: 'manufacture/purchase/listByUserId',
					type: 'POST',
					data: {
						userId: $k.user.get().id
					},
					success: function(data) {
						self.$tar.find('#manufacture-purchase-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#manufacture-purchase-table'), {
							'order': [[ 6, 'desc' ]]
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
				
				checkCount == 1 ? $tar.find('.btn-purchase-edit').removeAttr('disabled') : $tar.find('.btn-purchase-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-purchase-delete').removeAttr('disabled') : $tar.find('.btn-purchase-delete').attr('disabled', 'disabled'); 
			}
		},
		purchaseValid: {
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
									message: '采购标题不能为空'
								}
							}
						},
						num: {
							validators: {
								notEmpty: {
									message: '采购数量不能为空'
								},
								numeric: {
									message: '必须为数字'
								}
							}
						},
						location: {
							validators: {
								notEmpty: {
									message: '所在地不能为空'
								}
							}
						},
						contactUser: {
							validators: {
								notEmpty: {
									message: '联系人不能为空'
								},
							}
						},
						contact: {
							validators: {
			                    notEmpty: {
			                        message: '联系电话不能为空'
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
						},
						description: {
							validators: {
								notEmpty: {
									message: '详细描述不能为空'
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