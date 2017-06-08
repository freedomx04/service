<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template LogisticsContact' type='text/x-jquery-tmpl'>
	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-contact-edit'><span class='fa fa-edit fa-fw'></span>编辑</button>
				</div>
			</div>	
		<div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-list'>
				<p>
					<span class="hm-label">座机:</span>
					<span class="hm-content">{{=it.data.phone}}</span>
				</p>
				<p>
					<span class="hm-label">地址:</span>
					<span class="hm-content">{{=it.data.address}}</span>
				</p>
				<p>
					<span class="hm-label">联系人:</span>
					<span class="hm-content">{{=it.data.contactUser}}<span>
				</p>
				<p>
					<span class="hm-label">联系电话:</span>
					<span class="hm-content">{{=it.data.contact}}</span>
				</p>
				<p>
					<span class="hm-label">传真:</span>
					<span class="hm-content">{{=it.data.fax}}</span>
				</p>
				<p>
					<span class="hm-label">公司主页:</span>
					<span class="hm-content"><a href='http://{{=it.data.website}}' target='_blank'>{{=it.data.website}}</a></span>
				</p>
			</div><!-- module-list -->
		</div>
	</div>

</script>

<script class='template LogisticsContactDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 600px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>编辑</strong></h4>
      		</div>
      		<div class='modal-body'>
       			<form class='form-horizontal' role='form'>

  					<div class='form-group'>
    					<label for='phone' class='col-sm-3 control-label'><i class="form-required">*</i>座机:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control citypicker' name='phone' value='{{=it.data.phone}}'>
    					</div>
  					</div>

					<div class='form-group'>
   						<label for='address' class='col-sm-3 control-label'><i class="form-required">*</i>地址:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control citypicker' name='address' value='{{=it.data.address}}'>
    					</div>
      				</div>

					<div class='form-group'>
   						<label for='contactUser' class='col-sm-3 control-label'><i class="form-required">*</i>联系人:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='contactUser' value='{{=it.data.contactUser}}'>
    					</div>
      				</div>

					<div class='form-group'>
   						<label for='contact' class='col-sm-3 control-label'><i class="form-required">*</i>联系电话:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='contact' value='{{=it.data.contact}}'>
    					</div>
      				</div>

					<div class='form-group'>
   						<label for='fax' class='col-sm-3 control-label'>传真:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='fax' value='{{=it.data.fax}}'>
    					</div>
      				</div>

					<div class='form-group'>
   						<label for='website' class='col-sm-3 control-label'>公司主页:</label>
    					<div class='col-sm-8'>
      						<input type='text' class='form-control' name='website' value='{{=it.data.website}}'>
    					</div>
      				</div>

				</form>

      			<div class='modal-footer'>
        			<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        			<button type='button' class='btn btn-hm btn-contact-confirm'>确  定</button>
      			</div>
		
			</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'LogisticsContact';
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
				.on('click', '.btn-contact-edit', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({
						data: self.data
					}));
					
					$dialog.modal({backdrop: 'static'});
					self.contactValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-contact-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							var formData = new FormData($dialog.find('form')[0]); 
							formData.append("companyId", self.companyId);
							$.ajax({
								url: 'logistics/company/editContact',
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
					
				});
				
				return self;
			}
		},
		draw: {
			value: function(companyId, data) {
				var self = this;
				
				self.companyId = companyId;
				self.data = data;
				
				self.$tar.html(self.$tempTar.doT({
					data: data
				}));
				return self;
			}
		},
		load: {
			value: function() {
				var self = this;
				
				$.ajax({
					url: 'logistics/company/detail',
					type: 'POST',
					data: {
						companyId: self.companyId
					},
					success: function(data) {
						self.draw(data.data.id, data.data);
					},
					error: function(err) {}
				});
			    
				return self;
			}
		},
		contactValid: {
			value: function($dialog) {
				$dialog.find('form').bootstrapValidator({
					message: 'This value is not valid',
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
					fields: {
						phone: {
							validators: {
								notEmpty: {
									message: '座机不能为空'
								},
								regexp: {
			                    	regexp: /^(\d{3,4}-?)?\d{7,9}$/g,
			                    	message: '请输入正确的座机号码'
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