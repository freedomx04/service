<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<style type="text/css">
</style>

<script class='template LogisticsLine' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-line-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-line-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-line-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='logistics-line-table'>
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

<script class='template LogisticsLineDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 600px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class='modal-body'>
       			<form class='form-horizontal' role='form'>

  					<div class='form-group'>
    					<label for='origin' class='col-sm-3 control-label'><i class="form-required">*</i>发货地:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control citypicker' name='origin'>
    					</div>
  					</div>

					<div class='form-group'>
   						<label for='destination' class='col-sm-3 control-label'><i class="form-required">*</i>收货地:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control citypicker' name='destination'>
    					</div>
      				</div>

					<div class='form-group'>
   						<label for='transportMode' class='col-sm-3 control-label'><i class="form-required">*</i>运输模式:</label>
    					<div class='col-sm-8'>
      						<select class="form-control select-transportMode" name="transportMode">
								{{~ $k.constant.transportMode: mode}}
									<option value="{{=mode.value}}">{{=mode.name}}</option>
								{{~}}
							</select>
    					</div>
      				</div>

					<div class='form-group'>
   						<label for='aging' class='col-sm-3 control-label'><i class="form-required">*</i>参考时效:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='aging' placeholder='天'>
    					</div>
      				</div>

					<div class='form-group'>
   						<label for='heavyPrice' class='col-sm-3 control-label'><i class="form-required">*</i>单价（重货）:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='heavyPrice' placeholder='元/公斤'>
    					</div>
      				</div>

					<div class='form-group'>
   						<label for='lightPrice' class='col-sm-3 control-label'><i class="form-required">*</i>单价（轻货）:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='lightPrice' placeholder='元/立方'>
    					</div>
      				</div>

					<div class='form-group'>
   						<label for='lowest' class='col-sm-3 control-label'><i class="form-required">*</i>最低一票:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='lowest' placeholder='元'>
    					</div>
      				</div>

				</form>

      			<div class='modal-footer'>
        			<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        			<button type='button' class='btn btn-hm btn-line-confirm'>确  定</button>
      			</div>
		
			</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template LogisticsLineList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>线路</th>
			<th>运输方式</th>
			<th>参考时效</th>
			<th>单价（重货）</th>
			<th>单价（轻货）</th>
			<th>最低一票</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: line}}
			<tr class='table-tr' id="{{=line.id}}">
				<td class="td-check"><input type='checkbox' class='check'/></td>
				<td title='{{=line.origin}}  -  {{=line.destination}}'><a class='hm-a line-info'>{{=line.origin}}  -  {{=line.destination}}</a></td>
				<td>{{=$k.constant.transportMode[line.transportMode].name}}</td>	
				<td>{{=line.aging}} 天</td>
				<td>{{=line.heavyPrice}} 元/公斤</td>		
				<td>{{=line.lightPrice}} 元/立方</td>		
				<td>{{=line.lowest}} 元</td>		
			</tr>
		{{~}}
	</tbody>
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'LogisticsLine';
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
				.on('click', '.btn-line-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					self.lineValid($dialog);
				    $dialog.find('.citypicker').citypicker($k.config.initCityPicker);
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-line-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							$.ajax({
								url: 'logistics/line/add',
								type: 'POST',
								data: {
									companyId: self.companyId,
									origin: $dialog.find('input[name="origin"]').citypicker().val(),
									destination: $dialog.find('input[name="destination"]').citypicker().val(),
									transportMode: $dialog.find('.select-transportMode').val(),
									aging: $dialog.find('input[name = "aging"]').val(),
									heavyPrice: $dialog.find('input[name = "heavyPrice"]').val(),
									lightPrice: $dialog.find('input[name = "lightPrice"]').val(),
									lowest: $dialog.find('input[name = "lowest"]').val()
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
				.on('click', '.btn-line-edit', function() {
					var lineId = $k.util.getIds($tar);
					$.ajax({
						url: 'logistics/line/detail',
						type: 'POST',
						data: {
							lineId: lineId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$dialog.find('input[name="origin"]').citypicker(self.initCityPicker(data.data.origin));
							$dialog.find('input[name="destination"]').citypicker(self.initCityPicker(data.data.destination));
							$dialog.find('.select-transportMode > option[value="'+ data.data.transportMode + '"]').attr('selected', true);
							$dialog.find('input[name="aging"]').val(data.data.aging);
							$dialog.find('input[name="heavyPrice"]').val(data.data.heavyPrice);
							$dialog.find('input[name="lightPrice"]').val(data.data.lightPrice);
							$dialog.find('input[name="lowest"]').val(data.data.lowest);
							
							$dialog.modal({backdrop: 'static'});
							self.lineValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-line-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									$.ajax({
										url: 'logistics/line/edit',
										type: 'POST',
										data: {
											lineId: lineId,
											origin: $dialog.find('input[name="origin"]').citypicker().val(),
											destination: $dialog.find('input[name="destination"]').citypicker().val(),
											transportMode: $dialog.find('.select-transportMode').val(),
											aging: $dialog.find('input[name = "aging"]').val(),
											heavyPrice: $dialog.find('input[name = "heavyPrice"]').val(),
											lightPrice: $dialog.find('input[name = "lightPrice"]').val(),
											lowest: $dialog.find('input[name = "lowest"]').val()
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
				.on('click', '.btn-line-delete', function() {
					var lineIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中线路?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'logistics/line/delete',
							type: 'POST',
							data: {
								lineIds: lineIds,
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
				.on('click', '.line-info', function(e) {
					e.stopPropagation();
					var lineId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'logistics/line/detail',
						type: 'POST',
						data: {	lineId: lineId },
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
			value: function(companyId, lines) {
				var self = this;
				self.companyId = companyId;
				self.$tar.html(self.$tempTar.doT());
				
				self.$tar.find('#logistics-line-table').html(
					self.$tempListTar.doT({
						data: lines
					})
				);
				self.table = $k.util.dataTable(self.$tar.find('#logistics-line-table'), {
					'order': [[ 1, 'asc' ]]
				}); 
				self.$tar.find('.list-tips').text('已全部加载，共' + lines.length + '个');
				
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
					url: 'logistics/line/listByCompanyId',
					type: 'POST',
					data: {
						companyId: self.companyId
					},
					success: function(data) {
						self.$tar.find('#logistics-line-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#logistics-line-table'), {
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
				
				checkCount == 1 ? $tar.find('.btn-line-edit').removeAttr('disabled') : $tar.find('.btn-line-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-line-delete').removeAttr('disabled') : $tar.find('.btn-line-delete').attr('disabled', 'disabled'); 
			}
		},
		lineValid: {
			value: function($dialog) {
				$dialog.find('form').bootstrapValidator({
					message: 'This value is not valid',
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
					fields: {
						origin: {
			                validators: {
			                    notEmpty: {
			                        message: '发货地不能为空'
			                    }
			                }
			       		},
			       		destination: {
			                validators: {
			                    notEmpty: {
			                        message: '发货地不能为空'
			                    }
			                }
			       		},
						aging: {
							validators: {
								notEmpty: {
									message: '参考时效不能为空'
								},
								integer: {
									message: '必须为整数'
								}
							}
						},
						heavyPrice: {
							validators: {
								notEmpty: {
									message: '单价（重货）不能为空'
								},
								numeric: {
									message: '必须为数字'
								}
							}
						},
						lightPrice: {
							validators: {
								notEmpty: {
									message: '单价（轻货）不能为空'
								},
								numeric: {
									message: '必须为数字'
								}
							}
						},
						lowest: {
							validators: {
								notEmpty: {
									message: '最低一票不能为空'
								},
								numeric: {
									message: '必须为数字'
								}
							}
						},
					}
				});
			}
		},
		initCityPicker: {
			value: function(item) {
				 var arr = item.split('/');
				 switch (arr.length) {
				 case 1:	return {	province: arr[0] };
				 case 2:	return {	province: arr[0],	city: arr[1]	};
				 case 3: 	return {	province: arr[0],	city: arr[1],	district: arr[2]	};
				 default:	return {}		 
				 }
			}
		}
	});
	
})( jQuery );
</script>