<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ include file="/WEB-INF/manager/recommend/dynamic.jsp"%>
<%@ include file="/WEB-INF/manager/recommend/product.jsp"%>

<script class='template RecommendCompany' type='text/x-jquery-tmpl'>

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>

			<ul class="nav nav-tabs" style="padding-top: 20px;">
  				<li class="active"><a href="#recommend-introduction" data-toggle="tab">推介详情</a></li>
				<li><a href="#recommend-dynamic" data-toggle="tab">动态详情</a></li>
  				<li><a href="#recommend-product" data-toggle="tab">产品详情</a></li>
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

<script class='template RecommendCompanyContent' type='text/x-jquery-tmpl'>
	<div class="tab-pane fade active in" id="recommend-introduction">
		<div class='module-toolbar'>
			<button type='button' class='btn btn-hm btn-recommend-introduction-edit'><span class='fa fa-edit fa-fw'></span>编辑</button>
		</div>
		<div class='recommend-content'>{{=it.data.content}}</div>	
	</div>

	<div class="tab-pane fade" id="recommend-dynamic"></div>

    <div class="tab-pane fade" id="recommend-product"></div>
	
</script>

<script class='template RecommendDialog' type='text/x-jquery-tmpl'>
	<div class="modal-dialog" style="width: 850px;">
   		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title"><strong>{{=it.title}}</strong></h4>
      		</div>
      		<div class="modal-body">
       			<form class="form-horizontal" role="form">

					<div class="form-group">
						<div class="article-editor"></div>
					</div>

				</form>
			</div>
      		<div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">取  消</button>
        		<button type="button" class="btn btn-hm btn-recommend-confirm">确  定</button>
      		</div>
    	</div><!-- /.modal-content -->
  	</div><!-- /.modal-dialog -->
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'RecommendCompany';
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $('.template.' + fnName)
		},
		init: {
			value: function($tar) {
				var self = this;
				self.$tar = $tar
				.on('click', '.btn-recommend-introduction-edit', function() {
					var $dialog = $('<div class="modal" role="dialog"></div>').appendTo($tar);
					$dialog.html($('.template.RecommendDialog').doT({title: '编辑'}));
					
					self.editor = new $k.proto.Editor().init($dialog.find('.article-editor')).draw();
					$dialog.find("#editor").html(self.content);
					
					$dialog.modal({backdrop: 'static'});
					
					$dialog
					.on('hidden.bs.modal', function (e) {
						$dialog.remove();
					})
					.on('click', '.btn-recommend-confirm', function() {
						self.content = $dialog.find("#editor").html();
						
						$.ajax({
							url: 'recommend/company/editRecommend',
							type: 'POST',
							data: {
								companyId: self.companyId,
								content: self.content
							},
							success: function(data) {
								$tar.find('.recommend-content').html(self.content);
								$dialog.modal('hide');
							},
							error: function(err) {
								$dialog.modal('hide');
							}
						});
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
					url: 'recommend/company/findByUserId',
					type: 'POST',
					data: {
						userId: $k.user.get().id
					},
					success: function(data) {
						if (data.data) {
							var company = data.data;
							
							if (company.status < 2 || company.statusRecommend < 2) {
								self.$tar.find('.tab-content').html($(".template.UnCertification").doT());
							} else {
								self.companyId = company.id;
								self.content = company.content;
								
								self.$tar.find('.tab-content').html(
									$('.template.RecommendCompanyContent').doT({
										data: company
									})
								);
								// dynamic
								new $k.proto.RecommendDynamic().init(self.$tar.find('#recommend-dynamic')).draw(company.id, company.dynamics);
								// product
								new $k.proto.RecommendProduct().init(self.$tar.find('#recommend-product')).draw(company.id, company.products);
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
	});
	
})( jQuery );
</script>