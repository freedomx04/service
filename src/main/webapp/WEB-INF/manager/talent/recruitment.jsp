<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script class="template Recruitment" type="text/x-jquery-tmpl">
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm recruitment-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm recruitment-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm recruitment-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
					<button type='button' class='btn btn-hm recruitment-refresh' disabled='disabled'><span class='fa fa-refresh fa-fw'></span>刷新</button>
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

				<div class='list-table' tyle='font-size: 12px;'>
					<table class='table table-hover hm-table' id='recruitment-table'>
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
				
			</div>	<!-- module-list -->
		</div>
	</div>	
</script>

<script class='template RecruitmentDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 600px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class='modal-body' style='max-height: 560px; overflow: auto;'>
      			<form class='recruitment-form form-horizontal' role='form'>

					<div class="form-group">
						<label for="position" class="col-sm-3 control-label"><span class="form-required">*</span>招聘职位</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="position"/>
						</div>
					</div>

					<div class="form-group">
						<label for="profession" class="col-sm-3 control-label"><span class="form-required">*</span>行业类别</label>
						<div class="col-sm-8">
							<select class="form-control" name="profession">
								<option value="">请选择</option>
								{{~ $k.constant.profession: profession}}
									<option value="{{=profession.value}}">{{=profession.name}}</option>
				  				{{~}}
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="salary" class="col-sm-3 control-label"><span class="form-required">*</span>薪资待遇</label>
						<div class="col-sm-8">
							<select class="form-control" name="salary">
								<option value="">请选择</option>
									{{~ $k.constant.salary: salary}}
										<option value="{{=salary.value}}">{{=salary.name}}</option>
				  					{{~}}
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="workingYears" class="col-sm-3 control-label"><span class="form-required">*</span>工作年限</label>
						<div class="col-sm-8">
							<select class="form-control" name="workingYears">
								<option value="">请选择</option>
									{{~ $k.constant.workingYears: workingYears}}
										<option value="{{=workingYears.value}}">{{=workingYears.name}}</option>
				  					 {{~}}
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="education" class="col-sm-3 control-label"><span class="form-required">*</span>学历要求</label>
						<div class="col-sm-8">
							<select class="form-control" name="education">
								<option value="">请选择</option>
									{{~ $k.constant.education: education}}
										<option value="{{=education.value}}">{{=education.name}}</option>
				  					{{~}}
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="number" class="col-sm-3 control-label"><span class="form-required">*</span>招聘人数</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="number"/>
						</div>
					</div>

					<div class="form-group">
						<label for="responsibilities" class="col-sm-3 control-label"><span class="form-required">*</span>岗位职责</label>
						<div class="col-sm-8">
							<textarea class="form-control" rows="3" name="responsibilities"></textarea>
						</div>
					</div>

					<div class="form-group">
						<label for="requirements" class="col-sm-3 control-label"><span class="form-required">*</span>任职要求</label>
						<div class="col-sm-8">
							<textarea class="form-control" rows="3" name="requirements"></textarea>
						</div>
					</div>

					<div class="form-group">
						<label for="areaId" class="col-sm-3 control-label"><span class="form-required">*</span>工作地点</label>
						<div class="col-sm-8">
							<select class="form-control select-area" name="areaId">
								<option value="">请选择</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="address" class="col-sm-3 control-label"><span class="form-required">*</span>详细地址</label>
						<div class="col-sm-8">
							<textarea class="form-control" rows="3" name="address"></textarea>
						</div>
					</div>

					<div class="form-group">
						<label for="workingHours" class="col-sm-3 control-label"><span class="form-required">*</span>工作时间</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="workingHours"/>
						</div>
					</div>

					<div class="form-group">
						<label for="contact" class="col-sm-3 control-label"><span class="form-required">*</span>联系方式</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="contact"/>
						</div>
					</div>

				</form>

				<div class='modal-footer'>
        			<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        			<button type='button' class='btn btn-hm recruitment-confirm'>确  定</button>
      			</div>

			</div>
 		</div>
	</div>
</script>

<script class='template RecruitmentList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>招聘职位</th>
			<th>行业类别</th>
			<th>薪资待遇</th>
			<th>工作年限</th>
			<th>最高学历</th>
			<th>招聘人数</th>
			<th>地区</th>
			<th>手机号码</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: recruitment}}
			<tr class='table-tr' id="{{=recruitment.id}}">
				<td class="td-check"><input type='checkbox' class='check'/></td>
				<td title='{{=recruitment.position}}'><a class='hm-a recruitment-info'>{{=recruitment.position}}</a></td>
				<td>{{=$k.constant.profession[recruitment.profession].name}}</td>
				<td>{{=$k.constant.salary[recruitment.salary].name}}</td>
				<td>{{=$k.constant.workingYears[recruitment.workingYears].name}}</td>
				<td>{{=$k.constant.education[recruitment.education].name}}</td>
				<td>{{=recruitment.number}}</td>
				<td>{{=recruitment.area != null ? recruitment.area.name : ""}}</td>
				<td>{{=recruitment.contact}}</td>
				<td>{{=$k.util.getDateString(recruitment.updateTime)}}</td>
			</tr>
		{{~}}
	</tbody>
</script>

<script type="text/javascript">
;(function( $ ) {
	
	var fnName = "Recruitment";
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $(".template." + fnName)
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
				.on('click', '.recruitment-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					$k.util.loadArea($dialog);
					self.recruitmentValid($dialog);
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.recruitment-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							var formData = new FormData($dialog.find('form')[0]); 
							formData.append("companyId", self.companyId);
							
							$.ajax({
								url: 'talent/recruitment/add',
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
				.on('click', '.recruitment-edit', function() {
					var recruitmentId = $k.util.getIds($tar);
					
					$.ajax({
						url: 'talent/recruitment/detail',
						type: 'POST',
						data: { recruitmentId: recruitmentId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$.each(data.data, function(ky, vl) {
								$.each(data.data, function(key, val) {
									if (key == 'area') {
										$k.util.loadArea($dialog, val);
									} else {
										$dialog.find("[name='"+ key +"']").val(val);
									}
								});
							});

							$dialog.modal({backdrop: 'static'});
							self.recruitmentValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.recruitment-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($dialog.find('form')[0]); 
									formData.append("recruitmentId", recruitmentId);
									
									$.ajax({
										url: 'talent/recruitment/edit',
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
				.on('click', '.recruitment-delete', function() {
					var recruitmentIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否确定删除选中的招聘信息?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'talent/recruitment/delete',
							type: 'POST',
							data: { recruitmentIds: recruitmentIds },
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
				.on('click', '.recruitment-refresh', function(e) {
					var recruitmentId = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "刷新",
						content: "是否刷新选中的招聘信息,刷新后可以优先显示?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'talent/recruitment/refresh',
							type: 'POST',
							data: { recruitmentId: recruitmentId },
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
				.on('click', '.recruitment-info', function(e) {
					e.stopPropagation();
					var recruitmentId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'talent/recruitment/detail',
						type: 'POST',
						data: {	recruitmentId: recruitmentId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							$.each(data.data, function(ky, vl) {
								$.each(data.data, function(key, val) {
									if (key == 'area') {
										$k.util.loadArea($dialog, val);
									} else {
										$dialog.find("[name='"+ key +"']").val(val);
									}
								});
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
			value: function(companyId, recruitments) {
				var self = this;
				self.companyId = companyId;
				self.$tar.html(self.$tempTar.doT());
				
				self.$tar.find('#recruitment-table').html(
					self.$tempListTar.doT({
						data: recruitments
					})
				);
				
				self.table = $k.util.dataTable(self.$tar.find('#recruitment-table'), {
					'order': [[ 9, 'desc' ]],
				}); 
				self.$tar.find('.list-tips').text('已全部加载，共' + recruitments.length + '个');
				
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
					url: 'talent/recruitment/listByCompanyId',
					type: 'POST',
					data: {
						companyId: self.companyId
					},
					success: function(data) {
						self.$tar.find('#recruitment-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(self.$tar.find('#recruitment-table'), {
							'order': [[ 9, 'desc' ]],
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
				
				checkCount == 1 ? $tar.find('.recruitment-edit').removeAttr('disabled') : $tar.find('.recruitment-edit').attr('disabled', 'disabled');
				checkCount == 1 ? $tar.find('.recruitment-refresh').removeAttr('disabled') : $tar.find('.recruitment-refresh').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.recruitment-delete').removeAttr('disabled') : $tar.find('.recruitment-delete').attr('disabled', 'disabled'); 
			}
		},
		recruitmentValid: {
			value: function($dialog) {
				$dialog.find('form').bootstrapValidator({
					message: 'This value is not valid',
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
		            fields: {
		            	position: {
		                     validators: {
		                         notEmpty: {
		                             message: '招聘职位不能为空'
		                         }
		                     }
		            	},
		            	profession: {
		            		validators: {
		                        notEmpty: {
		                            message: '行业类别不能为空'
		                        }
		                    }
		            	},
		            	salary: {
		                    validators: {
		                        notEmpty: {
		                            message: '薪资待遇不能为空'
		                        }
		                    }
		           		},
		           		workingYears: {
		                    validators: {
		                        notEmpty: {
		                            message: '工作年限不能为空'
		                        }
		                    }
		           		},
		           		education: {
		                    validators: {
		                        notEmpty: {
		                            message: '学历要求不能为空'
		                        }
		                    }
		           		},
		           		number: {
		                    validators: {
		                        notEmpty: {
		                            message: '招聘人数不能为空'
		                        },
		                        digits: {
		                        	message: '必须为整数'
		                        }
		                    }
		           		},
		           		responsibilities: {
		                    validators: {
		                        notEmpty: {
		                            message: '岗位职责不能为空'
		                        }
		                    }
		           		},
		           		requirements: {
		                    validators: {
		                        notEmpty: {
		                            message: '任职要求不能为空'
		                        }
		                    }
		           		},
		           		areaId: {
		                    validators: {
		                        notEmpty: {
		                            message: '工作地点不能为空'
		                        }
		                    }
		           		},
		           		address: {
		                    validators: {
		                        notEmpty: {
		                            message: '详细地址不能为空'
		                        }
		                    }
		           		},
		           		workingHours: {
		                    validators: {
		                        notEmpty: {
		                            message: '工作时间不能为空'
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
		           		}
		            }
				});
			}
		}
	});
	
})( jQuery );
</script>
