<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style type='text/css'>
</style>

<script class="template CompanyInfo" type="text/x-jquery-tmpl">
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm companyInfo-edit'><span class='fa fa-edit fa-fw'></span>编辑</button>
				</div>
			</div>	
		<div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>
			<div class='main-information col-sm-8'></div>
		</div>
	</div>	
</script>

<script class="template CompanyInfoMain" type="text/x-jquery-tmpl">
	<div class="module-list">
		<div style="max-width: 300px; max-height: 300px; float: right">
			{{? it.data.imagePath}}
	    		<img class='am-u-sm-3 am-radius' src='{{="./"+it.data.imagePath}}' style='width:100%;'>
			{{??}}
				<img src='img/default-user.jpg'>
			{{?}}
		</div>

		<p>
			<span class="hm-label">认证状态:</span>
			<span class="hm-content" style="color: #3b8cff; font-weight: bold;">{{=$k.constant.certification[it.data.status].name}}</span>
		</p>
		<p>
			<span class="hm-label">公司名称:</span>
			<span class="hm-content">{{=it.data.name}}</span>
		</p>
		<p>
			<span class="hm-label">行业类别:</span>
			<span class="hm-content">{{=$k.constant.profession[it.data.profession].name}}</span>
		</p>
		<p>
			<span class="hm-label">公司性质:</span>
			<span class="hm-content">{{=$k.constant.property[it.data.property].name}}</span>
		</p>
		<p>
			<span class="hm-label">公司规模:</span>
			<span class="hm-content">{{=$k.constant.scale[it.data.scale].name}}</span>
		</p>
		<p>
			<span class="hm-label">公司地点:</span>
			<span class="hm-content">{{=it.data.area != null ? it.data.area.name : ""}}</span>
		</p>
		<p>
			<span class="hm-label">公司地址:</span>
			<span class="hm-content">{{=it.data.address || ""}}</span>
		</p>
		<p>
			<span class="hm-label">座机号码:</span>
			<span class="hm-content">{{=it.data.phone || ""}}</span>
		</p>
		<p>
			<span class="hm-label">传真号:</span>
			<span class="hm-content">{{=it.data.fax || ""}}</span>
		</p>
		<p>
			<span class="hm-label">联系人:</span>
			<span class="hm-content">{{=it.data.contactUser || ""}}</span>
		</p>
		<p>
			<span class="hm-label">联系方式:</span>
			<span class="hm-content">{{=it.data.contact || ""}}</span>
		</p>
		<p>
			<span class="hm-label">公司网站:</span>
			<span class="hm-content">{{=it.data.website || ""}}</span>
		</p>
		<p>
			<span class="hm-label">公司简介:</span>
			<span class="hm-content">{{=it.data.introduction || ""}}</span>
		</p>
	</div>
</script>

<script class='template CompanyInfoDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 640px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class='modal-body' style='max-height: 560px; overflow: auto;'>
      			<form class='companyInfo-form form-horizontal' role='form'>

					<div class="form-group">
						<label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>公司名称:</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="name" disabled="disabled">
						</div>
					</div>

					<div class="form-group">
						<label for="uploadImage" class="col-sm-3 control-label">公司logo:</label>
						<div class="col-sm-8">
							<input type="file" class="form-control file-loading" id="uploadImage" name="uploadImage">
						</div>
					</div>

					<div class="form-group">
						<label for="profession" class="col-sm-3 control-label"><i class="form-required">*</i>行业类别:</label>
						<div class="col-sm-8">
							<select class="form-control" name="profession" disabled="disabled">
						      	<option value="">请选择</option>
								{{~ $k.constant.profession: profession}}
							   	 <option value="{{=profession.value}}">{{=profession.name}}</option>
								{{~}}
						    </select>
						</div>
					</div>

					<div class="form-group">
						<label for="property" class="col-sm-3 control-label"><i class="form-required">*</i>公司性质:</label>
						<div class="col-sm-8">
							<select class="form-control" name="property" disabled="disabled">
						      	<option value="">请选择</option>
								{{~ $k.constant.property: property}}
							   	 <option value="{{=property.value}}">{{=property.name}}</option>
								{{~}}
						    </select>
						</div>
					</div>

					<div class="form-group">
						<label for="scale" class="col-sm-3 control-label"><i class="form-required">*</i>公司规模:</label>
						<div class="col-sm-8">
							<select class="form-control" name="scale">
						      	<option value="">请选择</option>
								{{~ $k.constant.scale: scale}}
							   	 <option value="{{=scale.value}}">{{=scale.name}}</option>
								{{~}}
						    </select>
						</div>
					</div>

					<div class="form-group">
						<label for="areaId" class="col-sm-3 control-label"><i class="form-required">*</i>公司地点:</label>
						<div class="col-sm-8">
							<select class="form-control" id="areaId" name="areaId">
						      <option value="">请选择</option>
						    </select>
						</div>
					</div>

					<div class="form-group">
						<label for="address" class="col-sm-3 control-label"><i class="form-required">*</i>公司详细地址:</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="address">
						</div>
					</div>

					<div class="form-group">
						<label for="phone" class="col-sm-3 control-label"><i class="form-required">*</i>座机号码:</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="phone">
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
						<label for="fax" class="col-sm-3 control-label">传真号:</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="fax">
						</div>
					</div>

					<div class="form-group">
						<label for="website" class="col-sm-3 control-label">公司网站:</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="website">
						</div>
					</div>

					<div class="form-group">
						<label for="introduction" class="col-sm-3 control-label">公司简介:</label>
						<div class="col-sm-8">
							<textarea class="form-control" rows="6" name="introduction"></textarea>
						</div>
					</div>

				</form>

				<div class='modal-footer'>
        			<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        			<button type='button' class='btn btn-hm companyInfo-confirm'>确  定</button>
      			</div>

			</div>

		</div>
	</div>
</script>

<script type="text/javascript">
;(function( $ ) {
	
	var fnName = "CompanyInfo";
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $(".template." + fnName)
		},
		$tempMainTar: {
			value: $('.template.' + fnName + 'Main')
		},
		$tempDialogTar: {
			value: $('.template.' + fnName + 'Dialog')
		},
		init: {
			value: function($tar) {
				var self = this;
				self.$tar = $tar
				.on('click', '.companyInfo-edit', function() {
					$.ajax({
						url: 'company/detail',
						type: 'POST',
						data: {
							companyId: self.companyId
						},
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html(self.$tempDialogTar.doT({title: '编辑'}));
							
							$.each(data.data, function(key, val) {
								if (key == 'imagePath') {
									$k.util.fileinput($dialog.find('#uploadImage'), {
										initialPreview:	"<img src='" + data.data.imagePath + "' class='file-preview-image'>"
									});
								} else if (key == 'area') {
									$.ajax({
										url: "area/list",
										type: "POST",
										success: function(data) {
											$.each(data.data, function(k, v) {
												var html = "<option value='"+ v.id +"'>"+ v.name +"</option>";
												$(html).appendTo($dialog.find("#areaId"));
											});
											$dialog.find('#areaId').val(val.id);
										},
										error: function(err) {}
									});
								} else {
									$dialog.find("[name='"+ key +"']").val(val);
								}
							});
							
							$dialog.modal({backdrop: 'static'});
							self.informationValid($dialog);
							
							$dialog
							.on('hidden.bs.modal', function (e) {
								$dialog.remove();
							})
							.on('click', '.companyInfo-confirm', function() {
								var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
								bootstrapValidator.validate();
								
								if (bootstrapValidator.isValid()) {
									var formData = new FormData($dialog.find('form')[0]); 
									formData.append("companyId", self.companyId);
									
									$.ajax({
										url: 'company/edit',
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
				
				$k.util.getCompanyByUserId($k.user.get().id, {
					success: function(data) {
						if (data.data) {
							self.companyId = data.data.id;
								
							$.ajax({
								url: 'talent/company/detail',
								type: 'POST',
								data: { companyId: self.companyId },
								success: function(data) {
									self.$tar.find('.main-information').html(
										self.$tempMainTar.doT({
											data: data.data
										})
									);
								},
								error: function(err) {}
							});
						} else {
							self.$tar.find('.main-information').html($(".template.UnCertification").doT());
							self.$tar.find('.companyInfo-edit').attr('disabled', 'disabled');
						}
					}
				});
				return self;
			}
		},
		informationValid: {
			value: function($dialog) {
				$dialog.find('form').bootstrapValidator({
					message: 'This value is not valid',
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
		            fields: {
		            	profession: {
			        		validators: {
			                    notEmpty: {
			                        message: '行业类别不能为空'
			                    }
			                }
			        	},
			        	property: {
			        		validators: {
			                    notEmpty: {
			                        message: '公司性质不能为空'
			                    }
			                }
			        	},
			        	scale: {
			        		validators: {
			                    notEmpty: {
			                        message: '公司规模不能为空'
			                    }
			                }
			        	},
			        	phone: {
			        		validators: {
			                    notEmpty: {
			                        message: '座机号码不能为空'
			                    },
			                    regexp: {
			                    	regexp: /^(\d{3,4}-?)?\d{7,9}$/g,
			                    	message: '请输入正确的座机号码'
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
			                        message: '工作地址不能为空'
			                    }
			                }
			       		},
		            }
				});
			}
		}
	});
	
})( jQuery );
</script>
