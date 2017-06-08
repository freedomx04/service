<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template LogisticsNetwork' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-network-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-network-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-network-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='logistics-network-table'>
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

<script class='template LogisticsNetworkDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 600px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class='modal-body'>
       			<form class='form-horizontal' role='form'>

  					<div class='form-group'>
    					<label for='name' class='col-sm-3 control-label'><i class="form-required">*</i>网点名称:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='name'>
    					</div>
  					</div>

					<div class='form-group'>
   						<label for='address' class='col-sm-3 control-label'><i class="form-required">*</i>地址:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='address'>
    					</div>
      				</div>

					<div class='form-group'>
   						<label for='contact' class='col-sm-3 control-label'><i class="form-required">*</i>联系电话:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='contact'>
    					</div>
      				</div>

					<div class='form-group'>
   						<label for='business' class='col-sm-3 control-label'><i class="form-required">*</i>业务内容:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='business'>
    					</div>
      				</div>

				</form>

      			<div class='modal-footer'>
        			<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        			<button type='button' class='btn btn-hm btn-network-confirm'>确  定</button>
      			</div>
		
			</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template LogisticsNetworkList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>网点名称</th>
			<th>地址</th>
			<th>联系电话</th>
			<th>业务内容</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: network}}
			<tr class='table-tr' id="{{=network.id}}">
				<td class="td-check"><input type='checkbox' class='check'/></td>
				<td title='{{=network.name}}'><a class='hm-a network-info'>{{=network.name}}</a></td>
				<td title='{{=network.address}}'>{{=network.address}}</td>	
				<td title='{{=network.contact}}'>{{=network.contact}}</td>
				<td title='{{=network.business}}'>{{=network.business}}</td>		
			</tr>
		{{~}}
	</tbody>
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'LogisticsNetwork';
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
				.on('click', '.btn-network-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					$dialog.modal({backdrop: 'static'});
					self.networkValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-network-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							var formData = new FormData($dialog.find('form')[0]); 
							formData.append("companyId", self.companyId);
							$.ajax({
								url: 'logistics/network/add',
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
				.on('click', '.btn-network-edit', function() {
					var networkId = $k.util.getIds($tar);
					$.ajax({
						url: 'logistics/network/detail',
						type: 'POST',
						data: {
							networkId: networkId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$.each(data.data, function(key, val){
								$dialog.find('input[name=' + key + ']').val(val);
							});
							$dialog.modal({backdrop: 'static'});
							self.networkValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-network-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($dialog.find('form')[0]); 
									formData.append("networkId", networkId);
									$.ajax({
										url: 'logistics/network/edit',
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
				.on('click', '.btn-network-delete', function() {
					var networkIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中网点?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'logistics/network/delete',
							type: 'POST',
							data: {
								networkIds: networkIds,
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
				.on('click', '.network-info', function(e) {
					e.stopPropagation();
					var networkId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'logistics/network/detail',
						type: 'POST',
						data: {	networkId: networkId },
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
			value: function(companyId, networks) {
				var self = this;
				self.companyId = companyId;
				self.$tar.html(self.$tempTar.doT());
				
				self.$tar.find('#logistics-network-table').html(
					$('.template.LogisticsNetworkList').doT({
						data: networks
					})
				);
				self.table = $k.util.dataTable(self.$tar.find('#logistics-network-table'), {
					'order': [[ 1, 'asc' ]]
				}); 
				self.$tar.find('.list-tips').text('已全部加载，共' + networks.length + '个');
				
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
					url: 'logistics/network/listByCompanyId',
					type: 'POST',
					data: {
						companyId: self.companyId
					},
					success: function(data) {
						self.$tar.find('#logistics-network-table').html(
							$('.template.LogisticsNetworkList').doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#logistics-network-table'), {
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
				
				checkCount == 1 ? $tar.find('.btn-network-edit').removeAttr('disabled') : $tar.find('.btn-network-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-network-delete').removeAttr('disabled') : $tar.find('.btn-network-delete').attr('disabled', 'disabled'); 
			}
		},
		networkValid: {
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
									message: '网点名称不能为空'
								}
							}
						},
						address: {
							validators: {
								notEmpty: {
									message: '地址不能为空'
								}
							}
						},
						contact: {
							validators: {
								notEmpty: {
									message: '联系电话不能为空'
								}
							}
						},
						business: {
							validators: {
								notEmpty: {
									message: '业务内容不能为空'
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