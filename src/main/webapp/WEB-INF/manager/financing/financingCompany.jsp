<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ include file="/WEB-INF/manager/financing/invest.jsp"%>

<script class='template FinancingCompany' type='text/x-jquery-tmpl'>

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>

			<ul class="nav nav-tabs" style="padding-top: 20px;">
  				<li class="active"><a href="#financing-invest" data-toggle="tab">投资管理</a></li>
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

<script class='template FinancingCompanyContent' type='text/x-jquery-tmpl'>

	<div class="tab-pane fade active in"" id="financing-invest"></div>
	
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'FinancingCompany';
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $('.template.' + fnName)
		},
		init: {
			value: function($tar) {
				var self = this;
				self.$tar = $tar
				.on('click', '.btn-financing-introduction-edit', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($('.template.RecommendIntroductionDialog').doT({
						data: self.introduction
					}));
					$dialog.modal({backdrop: 'static'});
					self.introductionValid($dialog);
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-financing-introduction-confirm', function() {
						var bootstrapValidator = $dialog.find('form').data('bootstrapValidator');
						bootstrapValidator.validate();
						
						var introduction = $dialog.find('textarea[name = "introduction"]').val();
						if (bootstrapValidator.isValid()) {
							$.ajax({
								url: 'manufacture/company/editIntroduction',
								type: 'POST',
								data: {
									companyId: self.companyId,
									introduction: introduction
								},
								success: function(data) {
									self.introduction = introduction;
									$tar.find('.content-financing-introduction').html(introduction);
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
				
				if (self.table) {
					self.table.destroy();
				}
				
				$.ajax({
					url: 'financing/company/findByUserId',
					type: 'POST',
					data: {
						userId: $k.user.get().id
					},
					success: function(data) {
						if (data.data) {
							var company = data.data;
							
							if (company.status < 2 || company.statusFinancing < 2) {
								self.$tar.find('.tab-content').html($(".template.UnCertification").doT());
							} else {
								self.companyId = company.id;
								
								self.$tar.find('.tab-content').html(
									$('.template.FinancingCompanyContent').doT({
										data: company
									})
								);
								// invest
								new $k.proto.Invest().init(self.$tar.find('#financing-invest')).draw(company.id, company.invests);
							}
						} else {
							self.$tar.find('.tab-content').html($(".template.UnCertification").doT());
						}
					},
					error: function(err) {}
				});
				
				return self;
			}
		},
		introductionValid: {
			value: function($dialog) {
				$dialog.find('form').bootstrapValidator({
					message: 'This value is not valid',
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
					fields: {
						introduction: {
							validators: {
								notEmpty: {
									message: '公司简介不能为空'
								},
								stringLength: {
									max: 2000,
									message: '公司介绍字数不能超过2000'
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