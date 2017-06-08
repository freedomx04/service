<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ include file="/WEB-INF/manager/logistics/network.jsp"%>
<%@ include file="/WEB-INF/manager/logistics/line.jsp"%>
<%@ include file="/WEB-INF/manager/logistics/dynamic.jsp"%>
<%@ include file="/WEB-INF/manager/logistics/contact.jsp"%>

<script class='template LogisticsCompany' type='text/x-jquery-tmpl'>

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>

			<ul class="nav nav-tabs" style="padding-top: 20px;">
  				<li class="active"><a href="#logistics-network" data-toggle="tab">网点介绍</a></li>
  				<li><a href="#logistics-line" data-toggle="tab">线路运价</a></li>
  				<li><a href="#logistics-evaluation" data-toggle="tab">评价详情</a></li>
  				<li><a href="#logistics-dynamic" data-toggle="tab">公司动态</a></li>
  				<li><a href="#logistics-contact" data-toggle="tab">联系我们</a></li>
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

<script class='template LogisticsCompanyContent' type='text/x-jquery-tmpl'>
    <div class="tab-pane fade active in" id="logistics-network"></div>

   	<div class="tab-pane fade" id="logistics-line"></div>

	<div class="tab-pane fade" id="logistics-evaluation">
		<div class='module-history-list col-sm-6' style="height: 35px; line-height: 35px; float: left;">
			<span class='list-tips'>已全部加载，共{{=it.data.evaluations.length}}个</span>
		</div>	
	
		<div class='list-table' tyle='font-size: 12px;'>
			<table class='table table-hover hm-table' id='logistics-evaluation-table'>
				<thead>
					<tr>
						<th>评论详情</th>	
						<th>综合评分</th>
						<th>用户名</th>
						<th class="td-update-time">评论时间</th>
					</tr>
				</thead>
				<tbody>
					{{~ it.data.evaluations: evaluation }}
						<tr class='table-tr'>
							<td title='{{=evaluation.comment}}'>{{=evaluation.comment}}</td>
							<td class="stars">
								<span class="stars">
								{{for(var i = 0; i < evaluation.score; i++) { }}
									<span class="glyphicon glyphicon-star"></span>
								{{ } }}
								{{for(var i = 0; i < 5-evaluation.score; i++) { }}
									<span class="glyphicon glyphicon-star-empty"></span>
								{{ } }}
								</span>
							</td>
							<td>{{=evaluation.user.username}}</td>	
							<td>{{=$k.util.getDateString(evaluation.updateTime)}}</td>
						</tr>
					{{~}}						
				</tbody>
			</table>
		</div>		
	</div>

	<div class="tab-pane fade" id="logistics-dynamic"></div>

	<div class="tab-pane fade" id="logistics-contact"></div>

</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'LogisticsCompany';
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
					url: 'logistics/company/findByUserId',
					type: 'POST',
					data: {
						userId: $k.user.get().id
					},
					success: function(data) {
						if (data.data) {
							var company = data.data;
							
							if (company.status < 2 || company.statusLogistics < 2) {
								self.$tar.find('.tab-content').html($(".template.UnCertification").doT());
							} else {
								self.companyId = company.id;
								
								self.$tar.find('.tab-content').html(
									$('.template.LogisticsCompanyContent').doT({
										data: company
									})
								);
								// network
								new $k.proto.LogisticsNetwork().init(self.$tar.find('#logistics-network')).draw(company.id, company.networks);
								// line
								new $k.proto.LogisticsLine().init(self.$tar.find('#logistics-line')).draw(company.id, company.lines);
								// evaluation
								$k.util.dataTable(
									self.$tar.find('#logistics-evaluation-table'), {
										'order': [[ 3, 'desc' ]],
									}); 
								// dynamic
								new $k.proto.LogisticsDynamic().init(self.$tar.find('#logistics-dynamic')).draw(company.id, company.dynamics);
								// contact
								new $k.proto.LogisticsContact().init(self.$tar.find('#logistics-contact')).draw(company.id, company);
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