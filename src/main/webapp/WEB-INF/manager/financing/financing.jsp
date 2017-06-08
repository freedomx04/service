<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template Financing' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-financing-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm btn-financing-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm btn-financing-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
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
					<table class='table table-hover hm-table' id='financing-financing-table'>
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

<script class='template FinancingDialog' type='text/x-jquery-tmpl'>
	<div class="modal-dialog" style="width: 640px;">
   		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title"><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class="modal-body" style='max-height: 560px; overflow: auto;'>
       			<form class="form-horizontal" role="form">

					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-info-circle fa-fw"></i>融资信息
						</div>
						<div class="panel-body">
							<div class="form-group">
    							<label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>融资名称:</label>
    							<div class="col-sm-8">
      								<input type="text" class="form-control" name="name">
    							</div>
  							</div>

  							<div class="form-group">
   								<label for="location" class="col-sm-3 control-label"><i class="form-required">*</i>所在地区:</label>
    							<div class="col-sm-8">
      								<input type="text" class="form-control" name="location">
    							</div>
      						</div>

  							<div class="form-group">
   								<label for="profession" class="col-sm-3 control-label"><i class="form-required">*</i>所属行业:</label>
    							<div class="col-sm-8">
      								<select class="form-control" id="clazz" name="profession">
						        		<option value="">请选择</option>
										{{~ $k.constant.profession: profession}}
							   	 		<option value="{{=profession.value}}">{{=profession.name}}</option>
										{{~}}
						    		</select>
    							</div>
      						</div>

 							<div class="form-group">
   								<label for="purpose" class="col-sm-3 control-label"><i class="form-required">*</i>融资用途:</label>
    							<div class="col-sm-8">
      								<input type="text" class="form-control" name="purpose">
    							</div>
      						</div>

 							<div class="form-group">
   								<label for="amount" class="col-sm-3 control-label"><i class="form-required">*</i>融资金额:</label>
    							<div class="col-sm-8">
      								<input type="text" class="form-control" name="amount">
    							</div>
      						</div>

 							<div class="form-group">
   								<label for="financingType" class="col-sm-3 control-label"><i class="form-required">*</i>融资类型:</label>
    							<div class="col-sm-8">
      								<select class="form-control" name="financingType">
						        		<option value="">请选择</option>
										{{~ $k.constant.financingType: financingType}}
							    		<option value="{{=financingType.value}}">{{=financingType.name}}</option>
										{{~}}
						   		 	</select>
    							</div>
      						</div>

 							<div class="form-group">
   								<label for="description" class="col-sm-3 control-label"><i class="form-required">*</i>项目概述:</label>
								<div class="col-sm-8">
      								<textarea class="form-control" rows="6" name="description"></textarea>
    							</div>
      						</div>

 							<div class="form-group">
   								<label for="advantage" class="col-sm-3 control-label"><i class="form-required">*</i>项目优势:</label>
								<div class="col-sm-8">
      								<textarea class="form-control" rows="6" name="advantage"></textarea>
    							</div>
      						</div>

						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-info-circle fa-fw"></i>联系信息
						</div>
						<div class="panel-body">

 							<div class="form-group">
   								<label for="companyName" class="col-sm-3 control-label"><i class="form-required">*</i>公司名称:</label>
    							<div class="col-sm-8">
      								<input type="text" class="form-control" name="companyName">
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

						</div>
					</div>


				</form>
      		<div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">取  消</button>
        		<button type="button" class="btn btn-hm btn-financing-confirm">确  定</button>
      		</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template FinancingList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>融资名称</th>
			<th>所属行业</th>
			<th>融资金额</th>
			<th>融资类型</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: financing}}
		<tr class='table-tr' id="{{=financing.id}}">
			<td class="td-check"><input type='checkbox' class='check'/></td>
			<td title='{{=financing.name}}'><a class='hm-a financing-info'>{{=financing.name}}</a></td>
			<td>{{=$k.constant.profession[financing.profession].name}}</td>	
			<td>{{=financing.amount}}</td>	
			<td>{{=$k.constant.financingType[financing.financingType].name}}</td>	
			<td>{{=$k.util.getDateString(financing.updateTime)}}</td>	
		</tr>
		{{~}}
	</tbody>

</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'Financing';
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
				.on('click', '.btn-financing-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					$dialog.modal({backdrop: 'static'});
					self.financingValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-financing-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							var formData = new FormData($dialog.find('form')[0]); 
							formData.append("userId", $k.user.get().id);
							
							$.ajax({
								url: 'financing/financing/add',
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
				.on('click', '.btn-financing-edit', function() {
					var financingId = $k.util.getIds($tar);
					$.ajax({
						url: 'financing/financing/detail',
						type: 'POST',
						data: {
							financingId: financingId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$.each(data.data, function(key, val) {
								$dialog.find("[name='"+ key +"']").val(val);
							});
							
							$dialog.modal({backdrop: 'static'});
							self.financingValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.btn-financing-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($dialog.find('form')[0]); 
									formData.append("financingId", financingId);
									
									$.ajax({
										url: 'financing/financing/edit',
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
				.on('click', '.btn-financing-delete', function() {
					var financingIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否删除选中的融资信息?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'financing/financing/delete',
							type: 'POST',
							data: {
								financingIds: financingIds,
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
				.on('click', '.financing-info', function(e) {
					e.stopPropagation();
					var financingId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'financing/financing/detail',
						type: 'POST',
						data: {	financingId: financingId },
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
					url: 'financing/financing/listByUserId',
					type: 'POST',
					data: {	userId: $k.user.get().id },
					success: function(data) {
						self.$tar.find('#financing-financing-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#financing-financing-table'), {
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
				
				checkCount == 1 ? $tar.find('.btn-financing-edit').removeAttr('disabled') : $tar.find('.btn-financing-edit').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.btn-financing-delete').removeAttr('disabled') : $tar.find('.btn-financing-delete').attr('disabled', 'disabled'); 
			}
		},
		financingValid: {
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
									message: '融资名称不能为空'
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
									message: '行业不能为空'
								}
							}
						},
						purpose: {
							validators: {
								notEmpty: {
									message: '融资用途不能为空'
								}
							}
						},
						amount: {
							validators: {
								notEmpty: {
									message: '融资金额不能为空'
								}
							}
						},
						financingType: {
							validators: {
								notEmpty: {
									message: '融资类型不能为空'
								}
							}
						},
						description: {
							validators: {
								notEmpty: {
									message: '项目概述不能为空'
								}
							}
						},
						advantage: {
							validators: {
								notEmpty: {
									message: '项目优势不能为空'
								}
							}
						},
						companyName: {
							validators: {
								notEmpty: {
									message: '公司名称不能为空'
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
						contact: {
							validators: {
								notEmpty: {
									message: '联系方式不能为空'
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
					}
				});
			}
		},
	});
	
})( jQuery );
</script>