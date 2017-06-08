<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ include file="/WEB-INF/manager/manufacture/offer.jsp"%>
<%@ include file="/WEB-INF/manager/manufacture/dynamic.jsp"%>
<%@ include file="/WEB-INF/manager/manufacture/product.jsp"%>
<%@ include file="/WEB-INF/manager/manufacture/solution.jsp"%>
<%@ include file="/WEB-INF/manager/manufacture/case.jsp"%>

<script class='template ManufactureCompany' type='text/x-jquery-tmpl'>

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>

			<ul class="nav nav-tabs" style="padding-top: 20px;">
  				<li class="active"><a href="#manufacture-offer" data-toggle="tab">供应管理</a></li>
				<li><a href="#manufacture-dynamic" data-toggle="tab">企业动态</a></li>
  				<li><a href="#manufacture-product" data-toggle="tab">产品中心</a></li>
  				<li><a href="#manufacture-solution" data-toggle="tab">解决方案</a></li>
  				<li><a href="#manufacture-case" data-toggle="tab">成功案例</a></li>
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

<script class='template ManufactureCompanyContent' type='text/x-jquery-tmpl'>
	<div class="tab-pane fade active in" id="manufacture-offer"></div>
	<div class="tab-pane fade" id="manufacture-dynamic"></div>
    <div class="tab-pane fade" id="manufacture-product"></div>
   	<div class="tab-pane fade" id="manufacture-solution"></div>
	<div class="tab-pane fade" id="manufacture-case"></div>

</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'ManufactureCompany';
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $('.template.' + fnName)
		},
		init: {
			value: function($tar) {
				var self = this;
				self.$tar = $tar;
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
					url: 'manufacture/company/findByUserId',
					type: 'POST',
					data: {
						userId: $k.user.get().id
					},
					success: function(data) {
						if (data.data) {
							var company = data.data;
							
							if (company.status < 2 || company.statusManufacture < 2) {
								self.$tar.find('.tab-content').html($(".template.UnCertification").doT());
							} else {
								self.companyId = company.id;
								
								// introduction
								self.$tar.find('.tab-content').html(
									$('.template.ManufactureCompanyContent').doT({
										data: company
									})
								);
								// offer
								new $k.proto.Offer().init(self.$tar.find('#manufacture-offer')).draw(company.id, company.offers);
								// dynamic
								new $k.proto.ManufactureDynamic().init(self.$tar.find('#manufacture-dynamic')).draw(company.id, company.dynamics);
								// product
								new $k.proto.ManufactureProduct().init(self.$tar.find('#manufacture-product')).draw(company.id, company.products);
								// solution
								new $k.proto.ManufactureSolution().init(self.$tar.find('#manufacture-solution')).draw(company.id, company.solutions);
								// case
								new $k.proto.ManufactureCase().init(self.$tar.find('#manufacture-case')).draw(company.id, company.cases);
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