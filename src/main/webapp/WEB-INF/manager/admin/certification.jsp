<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script class="template Certification" type="text/x-jquery-tmpl">

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>
			<div class='module-toolbar'>
				<div class='bar'>
					<button type='button' class='btn btn-hm btn-certification-pass' disabled='disabled'><span class='fa fa-edit fa-fw'></span>通过</button>
					<button type='button' class='btn btn-hm btn-certification-deny' disabled='disabled'><span class='fa fa-trash-o fa-fw'></span>驳回</button>
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
					<table class='table table-hover hm-table' id='certification-table'>
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

<script class="template CertificationList" type="text/x-jquery-tmpl">
	<thead>
		<tr>	
			<th class="td-check" style='width: 1%;'><input type='checkbox' class='check-all'/></th>
			<th>公司名称</th>
			<th>营业执照</th>
			<th>用户名</th>
			<th>行业类别</th>
			<th>企业性质</th>
			<th class="td-update-time">申请时间</th>
		</tr>
	</thead>
	<tbody>
		{{~ it.data: company}}
			<tr class='table-tr' id="{{=company.id}}">
				<td class="td-check"><input type='checkbox' class='check'/></td>
				<td title='{{=company.name}}'><a class="hm-a certification-info">{{=company.name}}</a></td>
				<td><a class='hm-a certification-licence' licencePath='{{=company.attachmentPath}}'>{{=company.license}}</a></td>	
				<td>{{=company.user.username}}</td>	
				<td>{{=$k.constant.profession[company.profession].name}}</td>	
				<td>{{=$k.constant.property[company.property].name}}</td>	
				<td>{{=$k.util.getDateString(company.updateTime)}}</td>
			</tr>
		{{~}}	
	</tbody>
</script>

<script class="template CertificationLicenceDialog" type="text/x-jquery-tmpl">
	<div class="modal-dialog" style="width: 600px;">
   		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title"><strong>营业执照详情</strong></h4>
      		</div>
      		<div class="modal-body" style='max-height: 560px; overflow: auto;'>
       			<form class="form-horizontal" role="form">

  					<div class="form-group">
    					<label for="licence" class="col-sm-3 control-label"><i class="form-required">*</i>营业执照号:</label>
    					<div class="col-sm-8">
      						<input type="text" class="form-control" name="licence">
    					</div>
  					</div>

					<div class="form-group">
						<label for="licenceImage" class="col-sm-3 control-label"><span class="form-required">*</span>营业执照附件</label>
						<div class="col-sm-8">
							<input type="file" class="form-control file-loading" id="licenceImage" name="licenceImage"/>
						</div>
					</div>

				</form>
			</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script type="text/javascript">
;(function( $ ) {
	
	var fnName = "Certification";
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
				.on('click', '.btn-certification-pass', function() {
					var companyId = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "通过",
						content: "点击确定, 则该公司将通过企业认证."
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'company/certification',
							type: 'POST',
							data: {
								companyId: companyId,
								status: 2
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
				.on('click', '.btn-certification-deny', function() {
					var companyId = $k.util.getIds($tar);
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($(".template.ConfirmDialog").doT({
						title: "驳回",
						content: "是否认证驳回该公司, 驳回后该公司需要重新上传材料通过认证?"
					}));
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on("click", ".btn-confirm", function() {
						$.ajax({
							url: 'company/certification',
							type: 'POST',
							data: {
								companyId: companyId,
								status: 3
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
				.on('click', '.certification-info', function(e) {
					e.stopPropagation();
					var companyId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'company/detail',
						type: 'POST',
						data: {	companyId: companyId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html($('.template.CompanyInfoDialog').doT({
								title: '详情'
							}));
							
							$.each(data.data, function(key, val) {
								if (key == 'imagePath') {
									$k.util.fileinputDisabled($dialog.find('#uploadImage'), {
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
							
							$k.util.disabled($dialog);
							$dialog.modal({backdrop: 'static'});
						},
						error: function(err) {}
					});
				})
				.on('click', '.certification-licence', function(e) {
					e.stopPropagation();
					var licence = $(this).text();
					var licencePath = $(this).attr('licencePath');
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($('.template.CertificationLicenceDialog').doT());
					$dialog.find("[name='licence']").val(licence);
					$k.util.fileinputDisabled($dialog.find('#licenceImage'), {
						initialPreview:	"<img src='" + licencePath + "' class='file-preview-image'>"
					});
					
					$k.util.disabled($dialog);
					$dialog.modal({backdrop: 'static'});
					
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
					url: 'company/listCertification',
					type: 'POST',
					success: function(data) {
						self.$tar.find('#certification-table').html(
							self.$tempListTar.doT({
								data: data.data
							})
						);
						
						self.table = $k.util.dataTable(
							self.$tar.find('#certification-table'), {
								'order': [[ 5, 'desc' ]],
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
				
				checkCount == 1 ? $tar.find('.btn-certification-pass').removeAttr('disabled') : $tar.find('.btn-certification-pass').attr('disabled', 'disabled');
				checkCount == 1 ? $tar.find('.btn-certification-deny').removeAttr('disabled') : $tar.find('.btn-certification-deny').attr('disabled', 'disabled');
			}
		},
	});
	
})( jQuery );
</script>
