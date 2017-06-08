<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template RecommendProduct' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-product-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-product-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-product-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='recommend-product-table'>
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

<script class='template RecommendProductDialog' type='text/x-jquery-tmpl'>
	<div class="modal-dialog" style="width: 600px;">
   		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title"><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class="modal-body" style='max-height: 560px; overflow: auto;'>
       			<form class="form-horizontal" role="form" id="recommend-product-form">

  					<div class="form-group">
    					<label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>产品名称:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="name">
    					</div>
  					</div>

					<div class="form-group">
						<label for="uploadImage" class="col-sm-3 control-label"><span class="form-required">*</span>产品图片</label>
						<div class="col-sm-8">
							<input type="file" class="form-control file-loading" id="uploadImage" name="uploadImage"/>
						</div>
					</div>

  					<div class="form-group">
   						<label for="model" class="col-sm-3 control-label">型号:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="model">
    					</div>
      				</div>

  					<div class="form-group">
   						<label for="location" class="col-sm-3 control-label"><i class="form-required">*</i>所在地:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="location"/>
    					</div>
      				</div>

  					<div class="form-group">
   						<label for="introduction" class="col-sm-3 control-label"><i class="form-required">*</i>简单介绍:</label>
    					<div class="col-sm-8">
      						<textarea class="form-control" rows="3" name="introduction"></textarea>
    					</div>
      				</div>

					<div class="form-group">
   						<label for="description" class="col-sm-3 control-label"><i class="form-required">*</i>详细说明:</label>
    					<div class="col-sm-8">
      						<textarea class="form-control" rows="8" name="description"></textarea>
    					</div>
      				</div>

				</form>
			</div>

      		<div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">取  消</button>
        		<button type="button" class="btn btn-hm btn-product-confirm">确  定</button>
      		</div>

    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template RecommendProductList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>产品名称</th>
			<th>型号</th>
			<th>所在地</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: product}}
		<tr class='table-tr' id="{{=product.id}}">
			<td class="td-check"><input type='checkbox' class='check'/></td>
			<td title='{{=product.name}}'><a class='hm-a product-info'>{{=product.name}}</a></td>
			<td>{{=product.model}}</td>
			<td>{{=product.location}}</td>
		</tr>
		{{~}}
	</tbody>
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'RecommendProduct';
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
				.on('click', '.btn-product-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					$k.util.fileinput($dialog.find('#uploadImage'));
					$dialog.modal({backdrop: 'static'});
					self.productValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-product-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							var formData = new FormData($dialog.find('form')[0]); 
							formData.append("companyId", self.companyId);
							$.ajax({
								url: 'recommend/product/add',
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
				.on('click', '.btn-product-edit', function() {
					var productId = $k.util.getIds($tar);
					$.ajax({
						url: 'recommend/product/detail',
						type: 'POST',
						data: {
							productId: productId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$.each(data.data, function(key, val) {
								if (key == 'subClazz') {
									var $subCLazz = $dialog.find('#subClazz');
									$subCLazz.empty();
									$.each($k.constant.clazz.where('o.value == "' + $k.util.getClazz(val) + '"')[0].subClazz, function(key, val) {
										$('<option value="'+ val.value +'">'+ val.name + '</option>').appendTo($subCLazz);
									});
									$subCLazz.val(val);
								} else if (key == 'imagePath') {
									$k.util.fileinput($dialog.find('#uploadImage'), {
										initialPreview:	"<img src='" + data.data.imagePath + "' class='file-preview-image'>",
										initialCaption: "img"
									});
								} else {
									$dialog.find("[name='"+ key +"']").val(val);
								}
							});
							
							$dialog.modal({backdrop: 'static'});
							self.productValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-product-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.removeField('uploadImage');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($dialog.find('form')[0]); 
									formData.append("productId", productId);
									$.ajax({
										url: 'recommend/product/edit',
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
				.on('click', '.btn-product-delete', function() {
					var productIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中的产品?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'recommend/product/delete',
							type: 'POST',
							data: {
								productIds: productIds,
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
				.on('click', '.product-info', function(e) {
					e.stopPropagation();
					var productId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'recommend/product/detail',
						type: 'POST',
						data: {	productId: productId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							$.each(data.data, function(key, val) {
								if (key == 'subClazz') {
									var $subCLazz = $dialog.find('#subClazz');
									$subCLazz.empty();
									$.each($k.constant.clazz.where('o.value == "' + $k.util.getClazz(val) + '"')[0].subClazz, function(key, val) {
										$('<option value="'+ val.value +'">'+ val.name + '</option>').appendTo($subCLazz);
									});
									$subCLazz.val(val);
								} else if (key == 'imagePath') {
									$k.util.fileinputDisabled($dialog.find('#uploadImage'), {
										initialPreview:	"<img src='" + data.data.imagePath + "' class='file-preview-image'>"
									});
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
			value: function(companyId, products) {
				var self = this;
				self.companyId = companyId;
				self.$tar.html(self.$tempTar.doT());
				
				if (self.table) {
					self.table.destroy();
				}
				
				self.$tar.find('#recommend-product-table').html(
					self.$tempListTar.doT({
						data: products
					})
				);
				self.table = $k.util.dataTable(self.$tar.find('#recommend-product-table'), {
					'order': [[ 1, 'asc' ]]
				}); 
				self.$tar.find('.list-tips').text('已全部加载，共' + products.length + '个');
				
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
					url: 'recommend/product/listByCompanyId',
					type: 'POST',
					data: {
						companyId: self.companyId
					},
					success: function(data) {
						self.$tar.find('#recommend-product-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#recommend-product-table'), {
							'order': [[ 1, 'asc' ]]
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
				
				checkCount == 1 ? $tar.find('.btn-product-edit').removeAttr('disabled') : $tar.find('.btn-product-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-product-delete').removeAttr('disabled') : $tar.find('.btn-product-delete').attr('disabled', 'disabled'); 
			}
		},
		productValid: {
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
									message: '产品名称不能为空'
								}
							}
						},
						uploadImage: {
							validators: {
								notEmpty: {
									message: '产品图片不能为空'
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
						introduction: {
							validators: {
								notEmpty: {
									message: '简单介绍不能为空'
								}
							}
						},
						description: {
							validators: {
								notEmpty: {
									message: '详细说明不能为空'
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