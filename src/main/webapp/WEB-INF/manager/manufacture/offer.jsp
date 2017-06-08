<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template Offer' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-offer-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-offer-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-offer-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='manufacture-offer-table'>
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

<script class='template OfferDialog' type='text/x-jquery-tmpl'>
	<div class="modal-dialog" style="width: 600px;">
   		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title"><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class="modal-body" style='max-height: 560px; overflow: auto;'>
       			<form class="form-horizontal" role="form">

  					<div class="form-group">
    					<label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>产品名称:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="name">
    					</div>
  					</div>

					<div class="form-group">
						<label for="uploadImage" class="col-sm-3 control-label"><span class="form-required">*</span>产品图片</label>
						<div class="col-sm-8">
							<input type="file" class="form-control file-loading" id="uploadImage" name="uploadImage">
						</div>
					</div>

  					<div class="form-group">
   						<label for="price" class="col-sm-3 control-label"><i class="form-required">*</i>价格:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="price">
    					</div>
      				</div>

  					<div class="form-group">
   						<label for="origin" class="col-sm-3 control-label"><i class="form-required">*</i>产地:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="origin">
    					</div>
      				</div>

  					<div class="form-group">
   						<label for="location" class="col-sm-3 control-label"><i class="form-required">*</i>所在地:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="location">
    					</div>
      				</div>

  					<div class="form-group">
   						<label for="lowest" class="col-sm-3 control-label"><i class="form-required">*</i>起订量:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="lowest">
    					</div>
      				</div>

  					<div class="form-group">
   						<label for="total" class="col-sm-3 control-label"><i class="form-required">*</i>供货总量:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="total">
    					</div>
      				</div>

					<div class="form-group">
   						<label for="description" class="col-sm-3 control-label"><i class="form-required">*</i>详细说明:</label>
    					<div class="col-sm-8">
      						<textarea class="form-control" rows="6" name="description"></textarea>
    					</div>
      				</div>

				</form>
      		<div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">取  消</button>
        		<button type="button" class="btn btn-hm btn-offer-confirm">确  定</button>
      		</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template OfferList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>产品名称</th>
			<th>价格</th>
			<th>产地</th>
			<th>所在地</th>
			<th>起订量</th>
			<th>供货总量</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: offer}}
		<tr class='table-tr' id="{{=offer.id}}">
			<td class="td-check"><input type='checkbox' class='check'/></td>
			<td title='{{=offer.name}}'><a class='hm-a offer-info'>{{=offer.name}}</a></td>
			<td>{{=offer.price}}</td>
			<td>{{=offer.origin}}</td>
			<td>{{=offer.location}}</td>
			<td>{{=offer.lowest}}</td>
			<td>{{=offer.total}}</td>
			<td>{{=$k.util.getDateString(offer.updateTime)}}</td>	
		</tr>
		{{~}}
	</tbody>
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'Offer';
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
				.on('click', '.btn-offer-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					$k.util.fileinput($dialog.find('#uploadImage'));
					$dialog.modal({backdrop: 'static'});
					self.offerValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-offer-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							var formData = new FormData($dialog.find('form')[0]); 
							formData.append("companyId", self.companyId);
							$.ajax({
								url: 'manufacture/offer/add',
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
				.on('click', '.btn-offer-edit', function() {
					var offerId = $k.util.getIds($tar);
					$.ajax({
						url: 'manufacture/offer/detail',
						type: 'POST',
						data: {
							offerId: offerId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$.each(data.data, function(key, val) {
								if (key == 'imagePath') {
									$k.util.fileinput($dialog.find('#uploadImage'), {
										initialPreview:	"<img src='" + data.data.imagePath + "' class='file-preview-image'>",
										initialCaption: "img"
									});
								} else {
									$dialog.find("[name='"+ key +"']").val(val);
								}
							});
							
							$dialog.modal({backdrop: 'static'});
							self.offerValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-offer-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.removeField('uploadImage');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($dialog.find('form')[0]); 
									formData.append("offerId", offerId);
									$.ajax({
										url: 'manufacture/offer/edit',
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
				.on('click', '.btn-offer-delete', function() {
					var offerIds = $k.util.getIds($tar);
					
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
							url: 'manufacture/offer/delete',
							type: 'POST',
							data: {
								offerIds: offerIds,
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
				.on('click', '.offer-info', function(e) {
					e.stopPropagation();
					var offerId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'manufacture/offer/detail',
						type: 'POST',
						data: {	offerId: offerId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							$.each(data.data, function(key, val) {
								if (key == 'imagePath') {
									$k.util.fileinputDisabled($dialog.find('#uploadImage'), {
										initialPreview:	"<img src='" + data.data.imagePath + "' class='file-preview-image'>"
									});
								} else {
									$dialog.find('[name=' + key + ']').val(val);
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
			value: function(companyId, offers) {
				var self = this;
				self.companyId = companyId;
				self.$tar.html(self.$tempTar.doT());
				
				if (self.table) {
					self.table.destroy();
				}
				
				self.$tar.find('#manufacture-offer-table').html(
					self.$tempListTar.doT({
						data: offers
					})
				);
				self.table = $k.util.dataTable(self.$tar.find('#manufacture-offer-table'), {
					'order': [[ 7, 'desc' ]]
				}); 
				self.$tar.find('.list-tips').text('已全部加载，共' + offers.length + '个');
				
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
					url: 'manufacture/offer/listByCompanyId',
					type: 'POST',
					data: {
						companyId: self.companyId
					},
					success: function(data) {
						self.$tar.find('#manufacture-offer-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#manufacture-offer-table'), {
							'order': [[ 7, 'desc' ]]
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
				
				checkCount == 1 ? $tar.find('.btn-offer-edit').removeAttr('disabled') : $tar.find('.btn-offer-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-offer-delete').removeAttr('disabled') : $tar.find('.btn-offer-delete').attr('disabled', 'disabled'); 
			}
		},
		offerValid: {
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
						price: {
							validators: {
								notEmpty: {
									message: '价格不能为空'
								},
								numeric: {
									message: '必须为数字'
								}
							}
						},
						origin: {
							validators: {
								notEmpty: {
									message: '产地不能为空'
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
						lowest: {
							validators: {
								notEmpty: {
									message: '起订量不能为空'
								},
								integer: {
									message: '必须为整数'
								}
							}
						},
						total: {
							validators: {
								notEmpty: {
									message: '供货总量不能为空'
								},
								integer: {
									message: '必须为整数'
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