<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<style type='text/css'>
.hm-panel-body {
	min-height: 300px;
}
</style>

<script class='template Location' type='text/x-jquery-tmpl'>

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12' style="padding-top: 20px;">
			
			<div class='col-lg-4'>
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-info-circle fa-fw"></i> 省
					</div>
					<div class="panel-body hm-panel-body location-province">
						<div class="navigation">
							<ol class="breadcrumb">
  								<li>中国</li>
							</ol>
						</div>

						<div style='font-size: 12px;'>
							<table class='table table-hover hm-table' id='location-province-table'>
								<thead>
									<tr>
										<th>名称</th>
										<th class="text-right"><a class="fa fa-plus fa-fw hm-a btn-location-add" type="1" title="新增"></a></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td colspan = "2">
											<div class="sk-three-bounce">
												<div class="sk-child sk-bounce1"></div>
												<div class="sk-child sk-bounce2"></div>
												<div class="sk-child sk-bounce3"></div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<div class='col-lg-4'>
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-info-circle fa-fw"></i> 市
					</div>
					<div class="panel-body hm-panel-body location-city">
						<div class="navigation">
							<ol class="breadcrumb">
  								<li>中国</li>
							</ol>
						</div>

						<div style='font-size: 12px;'>
							<table class='table table-hover hm-table' id='location-city-table'>
								<thead>
									<tr>
										<th>名称</th>
										<th class="text-right"><a class="fa fa-plus fa-fw hm-a btn-location-add" type="2" title="新增"></a></th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<div class='col-lg-4'>
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-info-circle fa-fw"></i> 县区
					</div>
					<div class="panel-body hm-panel-body location-county">
						<div class="navigation">
							<ol class="breadcrumb">
  								<li>中国</li>
							</ol>
						</div>


						<div style='font-size: 12px;'>
							<table class='table table-hover hm-table' id='location-county-table'>
								<thead>
									<tr>
										<th>名称</th>
										<th class="text-right"><a class="fa fa-plus fa-fw hm-a btn-location-add" type="3" title="新增"></a></th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>			

		<div>
	</div>
</script>

<script class='template LocationDialog' type='text/x-jquery-tmpl'>
	<div class='modal-dialog' style='width: 450px;'>
   		<div class='modal-content'>
      		<div class='modal-header'>
        		<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>
        		<h4 class='modal-title'><strong>新增</strong></h4>
      		</div>
      		<div class='modal-body'>
       			<form class='location-form form-horizontal' role='form'>

  					<div class='form-group'>
    					<label for='level' class='col-sm-3 control-label'>分类:</label>
    					<div class='col-sm-7'>
      						<select class="form-control" id="level" name="level" disabled>
								{{? it.type == 1}}
								<option value="1">省</option>
								{{?? it.type == 2}}
								<option value="2">市</option>
								{{??}}
								<option value="3">县区</option>
								{{?}}
							</select>
    					</div>
  					</div>
				
					{{? it.type == 2 }}
					<div class='form-group'>
   						<label for='parent' class='col-sm-3 control-label'>所属省:</label>
    					<div class='col-sm-7'>
      						<input type='text' class='form-control' name='parent' value="{{=it.provinceName}}" pid="{{=it.provinceId}}" disabled>
    					</div>
      				</div>
					{{?}}

					{{? it.type == 3 }}
					<div class='form-group'>
   						<label for='parent' class='col-sm-3 control-label'>所属市:</label>
    					<div class='col-sm-7'>
      						<input type='text' class='form-control' name='parent' value="{{=it.cityName}}" pid="{{=it.cityId}}" disabled>
    					</div>
      				</div>
					{{?}}

					<div class='form-group'>
   						<label for='name' class='col-sm-3 control-label'>名称:</label>
    					<div class='col-sm-7'>
      						<input type='text' class='form-control' name='name'>
    					</div>
      				</div>

				</form>

      			<div class='modal-footer'>
        			<button type='button' class='btn btn-default' data-dismiss='modal'>取  消</button>
        			<button type='button' class='btn btn-hm btn-location-confirm'>确  定</button>
      			</div>

			</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

						
<script class="template NavigationTemp" type="text/x-jquery-tmpl">
	<ol class="breadcrumb">
  		<li>中国</li>
		{{? it.provinceName}}
		<li>{{=it.provinceName}}</li>
		{{?}}
		{{? it.cityName}}
		<li>{{=it.cityName}}</li>
		{{?}}
	</ol>
</script>

<script class="template LocationProvinceList" type="text/x-jquery-tmpl">
	{{~ it.data: province }}
		<tr class='table-tr' id="{{=province.id}}" provinceName="{{=province.name}}">
			<td title='{{=province.name}}'>
				<a class="hm-a location-province-name">{{=province.name}}</a>
			</td>
			<td class="text-right">
				<a class="fa fa-edit fa-fw hm-a btn-province-edit" title="编辑"></a>
				<a class="fa fa-trash-o fa-fw hm-a btn-province-delete" title="删除"></a>
			</td>
		</tr>
	{{~}}	
</script>

<script class="template LocationCityList" type="text/x-jquery-tmpl">
	{{~ it.data: city }}
		<tr class='table-tr' id="{{=city.id}}" provinceName="{{=it.provinceName}}" cityName="{{=city.name}}">
			<td title='{{=city.name}}'>
				<a class="hm-a location-city-name">{{=city.name}}</a>
			</td>
			<td class="text-right">
				<a class="fa fa-edit fa-fw hm-a btn-city-edit" title="编辑"></a>
				<a class="fa fa-trash-o fa-fw hm-a btn-city-delete" title="删除"></a>
			</td>
		</tr>
	{{~}}	
</script>

<script class="template LocationCountyList" type="text/x-jquery-tmpl">
	{{~ it.data: county }}
		<tr class='table-tr' id="{{=county.id}}">
			<td title='{{=county.name}}'>{{=county.name}}</td>
			<td class="text-right">
				<a class="fa fa-edit fa-fw hm-a btn-county-edit" title="编辑"></a>
				<a class="fa fa-trash-o fa-fw hm-a btn-county-delete" title="删除"></a>
			</td>
		</tr>
	{{~}}
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'Location';
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
				.on('click', '.location-province-name', function() {
					var $tr = $(this).closest('.table-tr');
					self.provinceId = $tr.attr('id');
					self.provinceName = $tr.attr('provinceName');
					self.loadCity();
					
				})
				.on('click', '.location-city-name', function() {
					var $tr = $(this).closest('.table-tr');
					self.cityId = $tr.attr('id');
					self.cityName = $tr.attr('cityName');
					self.loadCounty();
				})
				.on('click', '.btn-location-add', function() {
					var type = $(this).attr('type');
					
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html(self.$tempDialogTar.doT({
						type: type,
						provinceId: self.provinceId,
						provinceName: self.provinceName,
						cityId: self.cityId,
						cityName: self.cityName
					}));
					$dialog.modal({backdrop: 'static'});
					self.locationValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-location-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						if (bootstrapValidator.isValid()) {
							$.ajax({
								url: 'location/add',
								type: 'POST',
								data: {
									pid: $dialog.find('input[name = "parent"]').attr('pid'),
									level: $dialog.find('#level').val(),
									name: $dialog.find('input[name = "name"]').val(),
								},
								success: function(data) {
									if (type == 1) {
										self.loadProvince();
									} else if (type == 2) {
										self.loadCity();
									} else {
										self.loadCounty();
									}
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
			value: function() {
				var self = this;
				self.$tar.html(self.$tempTar.doT());
				return self;
			}
		},
		load: {
			value: function() {
				var self = this;
				self.loadProvince();
				return self;
			}
		},
		loadProvince: {
			value: function() {
				var self = this;
				
				$.ajax({
					url: 'location/listByLevel',
					type: 'POST',
					data: { level: 1 },
					success: function(data) {
						self.$tar.find('#location-province-table tbody').html(
							$('.template.LocationProvinceList').doT({
								data: data.data
							})
						);
						
					},
					error: function(err) {}
				});
				
				return self;
			}
		},
		loadCity: {
			value: function() {
				var self = this;
				
				$.ajax({
					url: 'location/listByPid',
					type: 'POST',
					data: {
						pid: self.provinceId
					},
					success: function(data) {
						self.$tar.find('#location-city-table tbody').html(
							$('.template.LocationCityList').doT({
								data: data.data,
							})
						);
						
						self.$tar.find('.location-city .navigation').html(
							$('.template.NavigationTemp').doT({
								provinceName: self.provinceName
							})	
						);
						
					},
					error: function(err) {}
				});
				
				return self;
			}
		},
		loadCounty: {
			value: function() {
				var self = this;
				
				$.ajax({
					url: 'location/listByPid',
					type: 'POST',
					data: {
						pid: self.cityId
					},
					success: function(data) {
						self.$tar.find('#location-county-table tbody').html(
							$('.template.LocationCountyList').doT({
								data: data.data
							})
						);
						
						self.$tar.find('.location-county .navigation').html(
							$('.template.NavigationTemp').doT({
								provinceName: self.provinceName,
								cityName: self.cityName
							})	
						);
						
					},
					error: function(err) {}
				});
				
				return self;
			}
		},
		locationValid: {
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
									message: '名称不能为空'
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