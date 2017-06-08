<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template Invest' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-invest-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-invest-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-invest-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='financing-invest-table'>
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

<script class='template InvestDialog' type='text/x-jquery-tmpl'>
	<div class="modal-dialog" style="width: 600px;">
   		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title"><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class="modal-body" style='max-height: 560px; overflow: auto;'>
       			<form class="form-horizontal" role="form">

  					<div class="form-group">
    					<label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>投资名称:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="name">
    					</div>
  					</div>

  					<div class="form-group">
   						<label for="investType" class="col-sm-3 control-label"><i class="form-required">*</i>投资类型:</label>
    					<div class="col-sm-8">
      						<select class="form-control" name="investType">
						        <option value="">请选择</option>
								{{~ $k.constant.investType: investType}}
							    <option value="{{=investType.value}}">{{=investType.name}}</option>
								{{~}}
						   	</select>
    					</div>
      				</div>

  					<div class="form-group">
   						<label for="fundType" class="col-sm-3 control-label"><i class="form-required">*</i>资金类型:</label>
    					<div class="col-sm-8">
      						<select class="form-control" name="fundType">
						        <option value="">请选择</option>
								{{~ $k.constant.fundType: fundType}}
							    <option value="{{=fundType.value}}">{{=fundType.name}}</option>
								{{~}}
						   	</select>
    					</div>
      				</div>

  					<div class="form-group">
    					<label for="location" class="col-sm-3 control-label"><i class="form-required">*</i>所在地区:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="location">
    					</div>
  					</div>

  					<div class="form-group">
    					<label for="profession" class="col-sm-3 control-label"><i class="form-required">*</i>投资行业:</label>
    					<div class="col-sm-8">
      						<select class="selectpicker show-tick form-control" id="profession" name="profession" 
								multiple data-live-search="false" title="请选择" data-size="6">
								{{~ $k.constant.profession: profession}}
							    <option value="{{=profession.value}}">{{=profession.name}}</option>
								{{~}}
						   	</select>
    					</div>
  					</div> 

  					<div class="form-group">
    					<label for="investArea" class="col-sm-3 control-label"><i class="form-required">*</i>投资地区:</label>
    					<div class="col-sm-8">
      						<select class="selectpicker show-tick form-control" name="investArea" 
								multiple data-live-search="false" title="请选择" data-size="6">
								{{~ $k.constant.investArea: investArea}}
							    <option value="{{=investArea.value}}">{{=investArea.name}}</option>
								{{~}}
						   	</select>
    					</div>
  					</div> 

  					<div class="form-group">
    					<label for="amount" class="col-sm-3 control-label"><i class="form-required">*</i>投资金额:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="amount">
    					</div>
  					</div>

 					<div class="form-group">
   						<label for="description" class="col-sm-3 control-label"><i class="form-required">*</i>投资要求概述:</label>
						<div class="col-sm-8">
      						<textarea class="form-control" rows="6" name="description"></textarea>
    					</div>
      				</div>

 					<div class="form-group">
   						<label for="remark" class="col-sm-3 control-label"><i class="form-required">*</i>其他备注:</label>
						<div class="col-sm-8">
      						<textarea class="form-control" rows="6" name="remark"></textarea>
    					</div>
      				</div>

				</form>
      		<div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">取  消</button>
        		<button type="button" class="btn btn-hm btn-invest-confirm">确  定</button>
      		</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template InvestList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>投资名称</th>
			<th>投资类型</th>
			<th>资金类型</th>
			<th>所在地区</th>
			<th>投资金额</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: invest}}
		<tr class='table-tr' id="{{=invest.id}}">
			<td class="td-check"><input type='checkbox' class='check'/></td>
			<td title='{{=invest.name}}'><a class='hm-a invest-info'>{{=invest.name}}</a></td>
			<td>{{=$k.constant.investType[invest.investType].name}}</td>	
			<td>{{=$k.constant.fundType[invest.fundType].name}}</td>	
			<td>{{=invest.location}}</td>	
			<td>{{=invest.amount}}</td>	
			<td>{{=$k.util.getDateString(invest.updateTime)}}</td>	
		</tr>
		{{~}}
	</tbody>

</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'Invest';
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
				.on('click', '.btn-invest-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					
					$dialog.find('.selectpicker').selectpicker();

					$dialog.modal({backdrop: 'static'});
					self.investValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-invest-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							var formData = new FormData($dialog.find('form')[0]); 
							formData.append("companyId", self.companyId);
							
							$.ajax({
								url: 'financing/invest/add',
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
				.on('click', '.btn-invest-edit', function() {
					var investId = $k.util.getIds($tar);
					$.ajax({
						url: 'financing/invest/detail',
						type: 'POST',
						data: {
							investId: investId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$.each(data.data, function(key, val) {
								if (key == 'profession' || key == 'investArea') {
									$dialog.find('[name="' + key + '"]').selectpicker('val', val.split(','));
								} else {
									$dialog.find("[name='"+ key +"']").val(val);
								}
							});
							
							$dialog.modal({backdrop: 'static'});
							self.investValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-invest-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($dialog.find('form')[0]); 
									formData.append("investId", investId);
									
									$.ajax({
										url: 'financing/invest/edit',
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
				.on('click', '.btn-invest-delete', function() {
					var investIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中的投资信息?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'financing/invest/delete',
							type: 'POST',
							data: {
								investIds: investIds,
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
				.on('click', '.invest-info', function(e) {
					e.stopPropagation();
					var investId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'financing/invest/detail',
						type: 'POST',
						data: {	investId: investId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							$.each(data.data, function(key, val) {
								if (key == 'profession' || key == 'investArea') {
									$dialog.find('[name="' + key + '"]').selectpicker('val', val.split(','));
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
			value: function(companyId, invests) {
				var self = this;
				self.companyId = companyId;
				self.$tar.html(self.$tempTar.doT());
				
				if (self.table) {
					self.table.destroy();
				}
				
				self.$tar.find('#financing-invest-table').html(
					self.$tempListTar.doT({
						data: invests
					})
				);
				self.table = $k.util.dataTable(self.$tar.find('#financing-invest-table'), {
					'order': [[ 6, 'desc' ]]
				}); 
				self.$tar.find('.list-tips').text('已全部加载，共' + invests.length + '个');
				
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
					url: 'financing/invest/listByCompanyId',
					type: 'POST',
					data: {
						companyId: self.companyId
					},
					success: function(data) {
						self.$tar.find('#financing-invest-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#financing-invest-table'), {
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
				
				checkCount == 1 ? $tar.find('.btn-invest-edit').removeAttr('disabled') : $tar.find('.btn-invest-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-invest-delete').removeAttr('disabled') : $tar.find('.btn-invest-delete').attr('disabled', 'disabled'); 
			}
		},
		investValid: {
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
									message: '投资名称不能为空'
								}
							}
						},
						investType: {
							validators: {
								notEmpty: {
									message: '投资类型不能为空'
								}
							}
						},
						fundType: {
							validators: {
								notEmpty: {
									message: '资金类型不能为空'
								}
							}
						},
						location: {
							validators: {
								notEmpty: {
									message: '所在地区不能为空'
								}
							}
						},
						profession: {
							validators: {
								notEmpty: {
									message: '投资行业不能为空'
								}
							}
						},
						investArea: {
							validators: {
								notEmpty: {
									message: '投资地区不能为空'
								}
							}
						},
						amount: {
							validators: {
								notEmpty: {
									message: '投资金额不能为空'
								}
							}
						},
						description: {
							validators: {
								notEmpty: {
									message: '投资要求概述不能为空'
								}
							}
						},
						remark: {
							validators: {
								notEmpty: {
									message: '其他备注不能为空'
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