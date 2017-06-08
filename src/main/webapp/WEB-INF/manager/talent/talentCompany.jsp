<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="/WEB-INF/manager/talent/recruitment.jsp"%>

<script class="template TalentCompany" type="text/x-jquery-tmpl">

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>

			<ul class="nav nav-tabs" style="padding-top: 20px;">
  				<li class="active"><a href="#talent-recruitment" data-toggle="tab">招聘信息管理</a></li>
  				<li><a href="#talent-evaluation" data-toggle="tab">评价详情</a></li>
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

<script class='template TalentCompanyContent' type='text/x-jquery-tmpl'>

    <div class="tab-pane fade active in" id="talent-recruitment"></div>

	<div class="tab-pane fade" id="talent-evaluation">
		<div class='module-history-list col-sm-6' style="height: 35px; line-height: 35px; float: left;">
			<span class='list-tips'>已全部加载，共{{=it.data.evaluations.length}}个</span>
		</div>	
	
		<div class='list-table' tyle='font-size: 12px;'>
			<table class='table table-hover hm-table' id='talent-evaluation-table'>
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

</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'TalentCompany';
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
					url: 'talent/company/findByUserId',
					type: 'POST',
					data: {
						userId: $k.user.get().id
					},
					success: function(data) {
						if (data.data) {
							var company = data.data;
							
							if (company.status < 2 || company.statusTalent < 2) {
								self.$tar.find('.tab-content').html($(".template.UnCertification").doT());
							} else {
								self.companyId = company.id;
								
								self.$tar.find('.tab-content').html(
									$('.template.TalentCompanyContent').doT({
										data: company
									})
								);
								// recruitment
								new $k.proto.Recruitment().init(self.$tar.find('#talent-recruitment')).draw(company.id, company.recruitments);
								// evaluation
								$k.util.dataTable(
									self.$tar.find('#talent-evaluation-table'), {'order': [[ 3, 'desc' ]]}
								); 
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