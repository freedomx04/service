<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="/WEB-INF/manager/admin/certification.jsp"%>

<script class="template Company" type="text/x-jquery-tmpl">

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>

			<ul class="nav nav-tabs" style="padding-top: 20px;">
  				<li class="active"><a href="#company-pass" data-toggle="tab">已认证</a></li>
  				<li><a href="#company-certification" data-toggle="tab">待审核</a></li>
			</ul>

			<div class="tab-content">
				<div class="sk-three-bounce">
					<div class="sk-child sk-bounce1"></div>
					<div class="sk-child sk-bounce2"></div>
					<div class="sk-child sk-bounce3"></div>
				</div>
			</div>

		<div>
	</div>
</script>

<script class='template CompanyContent' type='text/x-jquery-tmpl'>
	<div class="tab-pane fade active in" id="company-pass">
		<div class='module-history-list col-sm-6' style="height: 35px; line-height: 35px; float: left;">
			<span class='list-tips'>已全部加载，共{{=it.data.length}}个</span>
		</div>	
	
		<div class='list-table' tyle='font-size: 12px;'>
			<table class='table table-hover hm-table' id='company-pass-table'>
				<thead>
					<tr>
						<th>公司名称</th>	
						<th>行业类别</th>
						<th>企业性质</th>
						<th>联系人</th>
						<th>联系方式</th>
						<th class="td-update-time">入驻时间</th>
					</tr>
				</thead>
				<tbody>
					{{~ it.data: company }}
						<tr class='table-tr' id="{{=company.id}}">
							<td title='{{=company.name}}'><a class='hm-a company-info'>{{=company.name}}</a></td>
							<td>{{=$k.constant.profession[company.profession].name}}</td>
							<td>{{=$k.constant.property[company.property].name}}</td>	
							<td>{{=company.contactUser}}</td>	
							<td>{{=company.contact}}</td>	
							<td>{{=$k.util.getDateString(company.createTime)}}</td>
						</tr>
					{{~}}						
				</tbody>
			</table>
		</div>
	</div>

    <div class="tab-pane fade" id="company-certification"></div>

</script>


<script type="text/javascript">
;(function( $ ) {
	
	var fnName = "Company";
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $(".template." + fnName)
		},
		init: {
			value: function($tar) {
				var self = this;
				self.$tar = $tar
				.on('click', '.company-info', function() {
					var companyId = $k.util.getInfoId($(this));
					
					$.ajax({
						url: 'company/detail',
						type: 'POST',
						data: {	companyId: companyId },
						success: function(data) {
							var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
							$dialog.html($('.template.CompanyInfoDialog').doT({title: '详情'}));
							
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
					url: 'company/listPass',
					type: 'POST',
					success: function(data) {
						if (data.data) {
							self.$tar.find('.tab-content').html(
								$('.template.CompanyContent').doT({
									data: data.data
								})
							);
							
							// company pass
							$k.util.dataTable(
								self.$tar.find('#company-pass-table'), {
									'order': [[ 5, 'desc' ]],
								});
							
							// certification
							new $k.proto.Certification().init(self.$tar.find('#company-certification')).draw().load();
						}
					},
					error: function(err) {}
				});
				
				return self;
			}
		}
	});
	
})( jQuery );
</script>
