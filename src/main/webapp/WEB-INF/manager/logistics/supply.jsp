<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<style type='text/css'>
</style>

<script class='template LogisticsSupply' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-supply-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-supply-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-supply-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='logistics-supply-table'>
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

<script class='template LogisticsSupplyDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 640px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class='modal-body' style='max-height: 560px; overflow: auto;'>
       			<form class='form-horizontal' role='form'>

					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-info-circle fa-fw"></i>货源信息
						</div>
						<div class="panel-body">

							<div class='form-group'>
    							<label for='origin' class='col-sm-3 control-label'><i class="form-required">*</i>发货地:</label>
    							<div class='col-sm-7'>
      								<input type='text' class='form-control citypicker' name='origin'>
    							</div>
  							</div>

							<div class='form-group'>
   								<label for='destination' class='col-sm-3 control-label'><i class="form-required">*</i>收货地:</label>
    							<div class='col-sm-7'>
      								<input type='text' class='form-control citypicker' name='destination'>
    							</div>
      						</div>

							<div class='form-group'>
    							<label for='description' class='col-sm-3 control-label'><i class="form-required">*</i>货源描述:</label>
    							<div class='col-sm-7'>
      								<input type='text' class='form-control' name='description'>
    							</div>
  							</div>

							<div class="form-group">
								<label for="supplyType" class="col-sm-3 control-label"><span class="form-required">*</span>货物类型</label>
								<div class="col-sm-7">
									<select class="form-control select-supplyType" name="supplyType">
										<option value="">请选择</option>
										<option value="0">重货</option>
										<option value="1">轻货</option>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label for="validDate" class="col-sm-3 control-label"><span class="form-required">*</span>信息有效期</label>
								<div class="col-sm-7">
									<input type="text" class="form-control datetimepicker" id="validDate" name="validDate" data-date-format="yyyy-mm-dd">
								</div>
							</div>
							<div class="form-group" style="margin-bottom: 0;">
								<label for="remark" class="col-sm-3 control-label">备注</label>
								<div class="col-sm-7">
									<input type="text" class="form-control" name="remark">
								</div>
							</div>

						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-info-circle fa-fw"></i>联系人信息
						</div>
						<div class="panel-body">

							<div class="form-group">
								<label for="contactUser" class="col-sm-3 control-label"><span class="form-required">*</span>联系人</label>
								<div class="col-sm-7">
									<input type="text" class="form-control" name="contactUser">
								</div>
							</div>
							<div class="form-group">
								<label for="contact" class="col-sm-3 control-label"><span class="form-required">*</span>联系电话</label>
								<div class="col-sm-7">
									<input type="text" class="form-control" name="contact">
								</div>
							</div>
							<div class="form-group" style="margin-bottom: 0;">
								<label for="address" class="col-sm-3 control-label"><span class="form-required">*</span>接货地点</label>
								<div class="col-sm-7">
									<input type="text" class="form-control" name="address">
								</div>
							</div>

						</div>
					</div>
				</form>

      			<div class='modal-footer'>
        			<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        			<button type='button' class='btn btn-hm btn-supply-confirm'>确  定</button>
      			</div>
		
			</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template LogisticsSupplyList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>线路</th>
			<th>货源类型</th>
			<th>有效时间</th>
			<th>联系人</th>
			<th>联系电话</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: supply}}
			<tr class='table-tr' id="{{=supply.id}}">
				<td class="td-check"><input type='checkbox' class='check'/></td>
				<td title='{{=supply.origin}}  -  {{=supply.destination}}'><a class='hm-a supply-info'>{{=supply.origin}}  -  {{=supply.destination}}</a></td>
				<td>{{=$k.constant.supplyType[supply.supplyType].name}}</td>
				<td>{{=$k.util.getDateString2(supply.validDate)}}</td>	
				<td>{{=supply.contactUser}}</td>
				<td>{{=supply.contact}}</td>
				<td>{{=$k.util.getDateString(supply.updateTime)}}</td>	
			</tr>
		{{~}}
	</tbody>
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'LogisticsSupply';
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
				.on('click', '.btn-supply-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					self.supplyValid($dialog);
					
					$dialog.find('.citypicker').citypicker($k.config.initCityPicker);
					$dialog.find('.datetimepicker').datetimepicker({
						language: 'zh-CN',
						format: 'yyyy-mm-dd',
						minView: "month",
						autoclose: true
					})
					.on('hide', function(e) {
						 $dialog.find('form').bootstrapValidator('revalidateField', 'validDate');  
					});
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-supply-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							$.ajax({
								url: 'logistics/supply/add',
								type: 'POST',
								data: {
									userId: $k.user.get().id,
									origin: $dialog.find('input[name="origin"]').citypicker().val(),
									destination: $dialog.find('input[name="destination"]').citypicker().val(),
									description: $dialog.find('input[name="description"]').val(),
									supplyType: $dialog.find('.select-supplyType').val(),
									validDate: new Date(Date.parse($dialog.find('input[name="validDate"]').val())),
									remark: $dialog.find('input[name = "remark"]').val(),
									contactUser: $dialog.find('input[name = "contactUser"]').val(),
									contact: $dialog.find('input[name = "contact"]').val(),
									address: $dialog.find('input[name = "address"]').val()
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
				.on('click', '.btn-supply-edit', function() {
					var supplyId = $k.util.getIds($tar);
					
					$.ajax({
						url: 'logistics/supply/detail',
						type: 'POST',
						data: {
							supplyId: supplyId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							self.supplyValid($dialog);
							
							$.each(data.data, function(key, val) {
								if (key == 'supplyType') {
									$dialog.find('.select-supplyType > option[value="'+ data.data.supplyType + '"]').attr('selected', true);
								} else if (key == 'origin' || key == 'destination') {
									$dialog.find('input[name=' + key + ']').citypicker(self.initCityPicker(val));
								} else if (key == 'validDate') {
									$dialog.find('input[name="validDate"]').val($k.util.getDateString2(val));
									$dialog.find('input[name="validDate"]').datetimepicker({
										language: 'zh-CN',
										format: 'yyyy-mm-dd',
										minView: "month",
										autoclose: true
									})
									.on('hide', function(e) {
										$dialog.find('form').bootstrapValidator('revalidateField', 'validDate');  
									});
								} else {
									$dialog.find('input[name=' + key + ']').val(val);
								} 
							});
							
							$dialog.modal({backdrop: 'static'});
							
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-supply-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									$.ajax({
										url: 'logistics/supply/edit',
										type: 'POST',
										data: {
											supplyId: supplyId,
											origin: $dialog.find('input[name="origin"]').citypicker().val(),
											destination: $dialog.find('input[name="destination"]').citypicker().val(),
											description: $dialog.find('input[name="description"]').val(),
											supplyType: $dialog.find('.select-supplyType').val(),
											validDate: new Date(Date.parse($dialog.find('input[name="validDate"]').val())),
											remark: $dialog.find('input[name = "remark"]').val(),
											contactUser: $dialog.find('input[name = "contactUser"]').val(),
											contact: $dialog.find('input[name = "contact"]').val(),
											address: $dialog.find('input[name = "address"]').val()
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
				.on('click', '.btn-supply-delete', function() {
					var supplyIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中货源?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'logistics/supply/delete',
							type: 'POST',
							data: {
								supplyIds: supplyIds,
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
				.on('click', '.supply-info', function(e) {
					e.stopPropagation();
					var supplyId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'logistics/supply/detail',
						type: 'POST',
						data: {	supplyId: supplyId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							$.each(data.data, function(key, val) {
								if (key == 'validDate') {
									$dialog.find('input[name="validDate"]').val($k.util.getDateString2(val));
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
					url: 'logistics/supply/listByUserId',
					type: 'POST',
					data: {
						userId: $k.user.get().id
					},
					success: function(data) {
						self.$tar.find('#logistics-supply-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#logistics-supply-table'), {
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
				
				checkCount == 1 ? $tar.find('.btn-supply-edit').removeAttr('disabled') : $tar.find('.btn-supply-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-supply-delete').removeAttr('disabled') : $tar.find('.btn-supply-delete').attr('disabled', 'disabled'); 
			}
		},
		supplyValid: {
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
						description: {
			                validators: {
			                    notEmpty: {
			                        message: '货源描述不能为空'
			                    }
			                }
			       		},
			       		supplyType: {
			                validators: {
			                    notEmpty: {
			                        message: '货物类型不能为空'
			                    }
			                }
			       		},
			       		validDate: {
			                validators: {
			                	date: {  
			                        format: 'YYYY-MM-DD',  
			                        message: '日期格式为 yyyy-MM-dd' 
			                    }, 
			                    notEmpty: {
			                        message: '信息有效期不能为空'
			                    }
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
			       		contactUser: {
			                validators: {
			                    notEmpty: {
			                        message: '联系人不能为空'
			                    }
			                }
			       		},
			       		address: {
			                validators: {
			                    notEmpty: {
			                        message: '接货地点不能为空'
			                    }
			                }
			       		}
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