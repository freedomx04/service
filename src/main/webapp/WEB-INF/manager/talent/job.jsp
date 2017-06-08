<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style type='text/css'>
</style>

<script class="template Job" type="text/x-jquery-tmpl">
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm job-add'><span class='fa fa-plus fa-fw'></span>新增</button>
					<button type='button' class='btn btn-hm job-edit' disabled='disabled'><span class='fa fa-edit fa-fw'></span>编辑</button>
					<button type='button' class='btn btn-hm job-delete' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>删除</button>
					<button type='button' class='btn btn-hm job-refresh' disabled='disabled'><span class='fa fa-refresh fa-fw'></span>刷新</button>
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
					<table class='table table-hover hm-table' id='job-table'>
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

<script class='template JobDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 640px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>{{=it.title}}</strong></h4>
      		</div>

      		<div class='modal-body' style='max-height: 560px; overflow: auto;'>
       			<form class='job-form form-horizontal' role='form'>

					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-info-circle fa-fw"></i>基本信息
						</div>
						<div class="panel-body">

							<div class="form-group">
								<label for="name" class="col-sm-3 control-label"><span class="form-required">*</span>姓名</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="name">
								</div>
							</div>

							<div class="form-group">
								<label for="sex" class="col-sm-3 control-label"><span class="form-required">*</span>性别</label>
								<div class="col-sm-8">
									<select class="form-control" name="sex">
										<option value="">请选择</option>
								      	<option value="0">男</option>
								     	<option value="1">女</option>
								    </select>
								</div>
							</div>

							<div class="form-group">
								<label for="birthYear" class="col-sm-3 control-label"><span class="form-required">*</span>出生年份</label>
								<div class="col-sm-8">
									<select class="form-control" name="birthYear">
										<option value="">请选择</option>
									  	{{for(var i=1953; i<=2000; i++) { }}
									  		<option value="{{=i}}">{{=i}}</option>
				  					  	{{ } }}
								    </select>
								</div>
							</div>

							<div class="form-group">
								<label for="workingYears" class="col-sm-3 control-label"><span class="form-required">*</span>工作年限</label>
								<div class="col-sm-8">
									<select class="form-control" name="workingYears">
								    	<option value="">请选择</option>
										{{ for (var i = 1; i < $k.constant.workingYears.length; i++) { }}
											<option value="{{=$k.constant.workingYears[i].value}}">{{=$k.constant.workingYears[i].name}}</option>
				  					 	{{ } }}
								    </select>
								</div>
							</div>

							<div class="form-group">
								<label for="education" class="col-sm-3 control-label"><span class="form-required">*</span>最高学历</label>
								<div class="col-sm-8">
									<select class="form-control" name="education">
										<option value="">请选择</option>
										{{ for (var i = 1; i < $k.constant.education.length; i++) { }}
											<option value="{{=$k.constant.education[i].value}}">{{=$k.constant.education[i].name}}</option>
				  					  	{{ } }}
								    </select>
								</div>
							</div>

							<div class="form-group">
								<label for="contact" class="col-sm-3 control-label"><span class="form-required">*</span>联系方式</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="contact">
								</div>
							</div>

							<div class="form-group">
								<label for="uploadImage" class="col-sm-3 control-label"><span class="form-required">*</span>个人头像</label>
								<div class="col-sm-8">
									<input type="file" class="form-control file-loading" id="uploadImage" name="uploadImage">
								</div>
							</div>

						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-info-circle fa-fw"></i>求职信息
						</div>
						<div class="panel-body">

							<div class="form-group">
								<label for="intention" class="col-sm-3 control-label"><span class="form-required">*</span>求职意向</label>
								<div class="col-sm-8">
									<textarea class="form-control" rows="3" name="intention"></textarea>
								</div>
							</div>

							<div class="form-group">
								<label for="profession" class="col-sm-3 control-label"><span class="form-required">*</span>行业类别</label>
								<div class="col-sm-8">
									<select class="form-control" name="profession">
										<option value="">请选择</option>
										{{ for (var i = 1; i < $k.constant.profession.length; i++) { }}
											<option value="{{=$k.constant.profession[i].value}}">{{=$k.constant.profession[i].name}}</option>
				  					  	{{ } }}
								    </select>
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
								<label for="salary" class="col-sm-3 control-label"><span class="form-required">*</span>期望薪资</label>
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
								<label for="introduction" class="col-sm-3 control-label"><span class="form-required">*</span>自我介绍</label>
								<div class="col-sm-8">
									<textarea class="form-control" rows="3" name="introduction"></textarea>
								</div>
							</div>

							<div class="form-group">
								<label for="workExperience" class="col-sm-3 control-label">工作经验</label>
								<div class="col-sm-8">
									<textarea class="form-control" rows="3" name="workExperience"></textarea>
								</div>
							</div>

							<div class="form-group">
								<label for="educationExperience" class="col-sm-3 control-label">教育经历</label>
								<div class="col-sm-8">
									<textarea class="form-control" rows="3" name="educationExperience"></textarea>
								</div>
							</div>

						</div>
					</div>
				</form>
				
				<div class='modal-footer'>
        			<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        			<button type='button' class='btn btn-hm job-confirm'>确  定</button>
      			</div>

			</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script class='template JobList' type='text/x-jquery-tmpl'>
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>姓名</th>
			<th>工作年限</th>
			<th>最高学历</th>
			<th>行业类别</th>
			<th>地区</th>
			<th>手机号码</th>
			<th class="td-update-time">修改时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: job}}
			<tr class='table-tr' id="{{=job.id}}">
				<td class="td-check"><input type='checkbox' class='check'/></td>
				<td title='{{=job.name}}'><a class='hm-a job-info'>{{=job.name}}</a></td>
				<td title='{{=$k.constant.workingYears[job.workingYears].name}}'>{{=$k.constant.workingYears[job.workingYears].name}}</td>
				<td title='{{=$k.constant.education[job.education].name}}'>{{=$k.constant.education[job.education].name}}</td>
				<td title='{{=$k.constant.profession[job.profession].name}}'>{{=$k.constant.profession[job.profession].name}}</td>
				<td title='{{=job.area != null ? job.area.name : ""}}'>{{=job.area != null ? job.area.name : ""}}</td>
				<td title='{{=job.contact}}'>{{=job.contact}}</td>
				<td>{{=$k.util.getDateString(job.updateTime)}}</td>
			</tr>
		{{~}}
	</tbody>
</script>

<script type="text/javascript">
;(function( $ ) {
	
	var fnName = "Job";
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $(".template." + fnName)
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
				.on('click', '.job-add', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({title: '新增'}));
					
					$k.util.fileinput($dialog.find('#uploadImage'));
					$k.util.loadArea($dialog);
					
					self.jobValid($dialog);
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.job-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							var formData = new FormData($dialog.find('form')[0]); 
							formData.append("userId", $k.user.get().id);
							
							$.ajax({
								url: 'talent/job/add',
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
				.on('click', '.job-edit', function() {
					var jobId = $k.util.getIds($tar);
					
					$.ajax({
						url: 'talent/job/detail',
						type: 'POST',
						data: { jobId: jobId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$.each(data.data, function(ky, vl) {
								$.each(data.data, function(key, val) {
									if (key == 'imagePath') {
										$k.util.fileinput($dialog.find('#uploadImage'), {
											initialPreview:	"<img src='" + data.data.imagePath + "' class='file-preview-image'>",
											initialCaption: "img"
										});
									} else if (key == 'area') {
										$k.util.loadArea($dialog, val);
									} else {
										$dialog.find("[name='"+ key +"']").val(val);
									}
								});
							});
							
							self.jobValid($dialog);
							$dialog.modal({backdrop: 'static'});
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.job-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.removeField('uploadImage');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($dialog.find('form')[0]); 
									formData.append("jobId", jobId);
									
									$.ajax({
										url: 'talent/job/edit',
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
				.on('click', '.job-delete', function() {
					var jobIds = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "删除",
						content: "是否确定删除选中的求职信息?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'talent/job/delete',
							type: 'POST',
							data: { jobIds: jobIds },
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
				.on('click', '.job-refresh', function() {
					var jobId = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "刷新",
						content: "是否刷新选中的求职信息,刷新后可以优先显示?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'talent/job/refresh',
							type: 'POST',
							data: { jobId: jobId },
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
				.on('click', '.job-info', function(e) {
					e.stopPropagation();
					var jobId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'talent/job/detail',
						type: 'POST',
						data: {	jobId: jobId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '详情'}));
							
							$.each(data.data, function(key, val) {
								if (key == 'imagePath') {
									$k.util.fileinputDisabled($dialog.find('#uploadImage'), {
										initialPreview:	"<img src='" + data.data.imagePath + "' class='file-preview-image'>"
									});
								} else if (key == 'area') {
									$k.util.loadArea($dialog, val);
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
					url: 'talent/job/listByUserId',
					type: 'POST',
					data: {
						userId: $k.user.get().id
					},
					success: function(data) {
						self.$tar.find('#job-table').html(
							$('.template.JobList').doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(
							self.$tar.find('#job-table'), {
								'order': [[ 7, 'desc' ]],
							}); 
								
						self.$tar.find('.list-tips').text('已全部加载，共' + data.data.length + '个');
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
				
				checkCount == 1 ? $tar.find('.job-edit').removeAttr('disabled') : $tar.find('.job-edit').attr('disabled', 'disabled');
				checkCount == 1 ? $tar.find('.job-refresh').removeAttr('disabled') : $tar.find('.job-refresh').attr('disabled', 'disabled');
				checkCount > 0 ? $tar.find('.job-delete').removeAttr('disabled') : $tar.find('.job-delete').attr('disabled', 'disabled'); 
			}
		},
		jobValid: {
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
		                             message: '姓名不能为空'
		                         }
		                     }
		            	},
		            	sex: {
		                     validators: {
		                         notEmpty: {
		                             message: '性别不能为空'
		                         }
		                     }
		            	},
		            	birthYear: {
		            		validators: {
		                        notEmpty: {
		                            message: '出生年份不能为空'
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
		                            message: '最高学历不能为空'
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
		           		uploadImage: {
		                    validators: {
		                        notEmpty: {
		                            message: '个人头像不能为空'
		                        }
		                    }
		           		},
		           		intention: {
		                    validators: {
		                        notEmpty: {
		                            message: '求职意向不能为空'
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
		           		areaId: {
		                    validators: {
		                        notEmpty: {
		                            message: '工作地点不能为空'
		                        }
		                    }
		           		},
		           		salary: {
		                    validators: {
		                        notEmpty: {
		                            message: '期望薪资不能为空'
		                        }
		                    }
		           		},
		           		introduction: {
		                    validators: {
		                        notEmpty: {
		                            message: '自我介绍不能为空'
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
