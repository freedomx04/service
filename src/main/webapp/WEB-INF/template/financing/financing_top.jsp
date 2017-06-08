<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<script class="template NavBar" type="text/x-jquery-tmpl">
	<div class="nav-bar">
		<ul class="nav nav-pills">
			<li class="{{=it.subnv == 1 ? "active" : ""}}"><a href="financing">资金需求</a></li>
	 	 	<li class="{{=it.subnv == 2 ? "active" : ""}}"><a href="invest">投资信息</a></li>
	 		<li class="{{=it.subnv == 3 ? "active" : ""}}"><a href="policy">国家政策</a></li>
	 	 	<li class="{{=it.subnv == 4 ? "active" : ""}}"><a href="financingUnit">服务单位</a></li>
		</ul>

		{{? it.subnv == 1 || it.subnv == 2}}
		<div class="input-wraper">
			{{? it.subnv == 1}}
			<div class="keyword-wraper pull-left">
				<input type="text" id="searchStr" autocomplete="off" maxlength="64" placeholder="项目名称" value="">
			</div>
			<input type="text" id="financing-search" class="submit" value="搜索" readonly="true">
			{{?? it.subnv == 2}}
				<div class="keyword-wraper pull-left ">
		   			<input type="text" id="searchStr" autocomplete="off" maxlength="64" placeholder="项目名称" value="">
				</div>
				<input type="text" id="invest-search" class="submit" value="搜索" readonly="true">
			{{?}}
		</div>
		{{?}}
	</div>
</script>

<script class="template FinancingFilterArea" type="text/x-jquery-tmpl">
	<ul class="select">
		<li class="select-list">
			<dt class="select-dt">所属行业：</dt>
			<dl class="select-dl" select="profession" style="height: 32px; overflow: hidden; padding-right: 28px;">
				<dd class="select-dd select-all" data-class='pr'>
					<a class="select-a">不限</a>
				</dd>
				{{~$k.constant.profession: data}}
					<dd class="select-dd select-item" data-class='pr' data-val='{{=data.value}}'>
						<a class="select-a">{{=data.name}}</a>
					</dd>
				{{~}}
			</dl>
			<dl class="select-toggle hm-a hm-collapse">
				<a>
					<span class="select-toggle-text">更多</span>
					<span class="fa fa-angle-down"></span>
				</a>
			</dl>
		</li>
		<li class="select-list">
			<dt class="select-dt">融资方式：</dt>
			<dl class="select-dl" select="financingType">
				<dd class='select-dd select-all' data-class='ft'>
					<a class="select-a">不限</a>
				</dd>
				{{~$k.constant.financingType: data}}
					<dd class="select-dd select-item" data-class='ft' data-val='{{=data.value}}'>
						<a class="select-a">{{=data.name}}</a>
					</dd>
				{{~}}
			</dl>
		</li>

		<li class="select-result">
			<dt class="select-dt">已选条件：</dt>
			<dl>
				<dd class="select-dd select-no">暂时没有选择过滤条件</dd>
			</dl>
		</li>

		<li class="search-btn" style="padding-top: 15px;">
			<button type="button" class='btn btn-hm select-comfirm'>确定</button>
		</li>
	</ul>
</script>

<script class="template InvestFilterArea" type="text/x-jquery-tmpl">
	<ul class="select">
		<li class="select-list">
			<dt class="select-dt">投资类型：</dt>
			<dl class="select-dl" select="investType" style="height: 32px; overflow: hidden; padding-right: 28px;">
				<dd class="select-dd select-all" data-class='it'>
					<a class="select-a">不限</a>
				</dd>
				{{~$k.constant.investType: data}}
					<dd class="select-dd select-item" data-class='it' data-val='{{=data.value}}'>
						<a class="select-a">{{=data.name}}</a>
					</dd>
				{{~}}
			</dl>
			<dl class="select-toggle hm-a hm-collapse">
				<a>
					<span class="select-toggle-text">更多</span>
					<span class="fa fa-angle-down"></span>
				</a>
			</dl>
		</li>
		<li class="select-list">
			<dt class="select-dt">资金类型：</dt>
			<dl class="select-dl" select="fundType" style="height: 32px; overflow: hidden; padding-right: 28px;">
				<dd class='select-dd select-all' data-class='ft'>
					<a class="select-a">不限</a>
				</dd>
				{{~$k.constant.fundType: data}}
					<dd class="select-dd select-item" data-class='ft' data-val='{{=data.value}}'>
						<a class="select-a">{{=data.name}}</a>
					</dd>
				{{~}}
			</dl>
			<dl class="select-toggle hm-a hm-collapse">
				<a>
					<span class="select-toggle-text">更多</span>
					<span class="fa fa-angle-down"></span>
				</a>
			</dl>
		</li>

		<li class="select-result">
			<dt class="select-dt">已选条件：</dt>
			<dl>
				<dd class="select-dd select-no">暂时没有选择过滤条件</dd>
			</dl>
		</li>

		<li class="search-btn" style="padding-top: 15px;">
			<button type="button" class='btn btn-hm select-comfirm'>确定</button>
		</li>
	</ul>
</script>

<script>
;(function( $ ) {
	
	var fnName = "FilterArea";
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		init: {
			value: function($tar, serviceType) {
				var self = this;
				self.serviceType = serviceType;
				self.$tar = $tar
				.on('click', '.select-toggle', function() {
					var $this = $(this);
					if ($this.hasClass('hm-collapse')) {
						$this.removeClass('hm-collapse').addClass('hm-expand');
						$this.find('.select-toggle-text').text('收起');
						$this.find('.fa').removeClass('fa-angle-down').addClass('fa-angle-up');
						$this.closest('.select-list').find('.select-dl').css({'height': '100%', 'overflow': 'visible'});
					} else {
						$this.removeClass('hm-expand').addClass('hm-collapse');
						$this.find('.select-toggle-text').text('更多');
						$this.find('.fa').removeClass('fa-angle-up').addClass('fa-angle-down');
						$this.closest('.select-list').find('.select-dl').css({'height': '32px', 'overflow': 'hidden'});
					}
				})
				.on('click', '.select-comfirm', function() {
					var pr = [];
					var ft = [];
					var it = [];
					$.each($tar.find('.select-result .select-item.selected'), function(index, obj) {
						var $obj = $(obj);
						if ($obj.attr('data-class') == 'pr') {
							pr.push($obj.attr('data-val'));
						} else if ($obj.attr('data-class') == 'ft') {
							ft.push($obj.attr('data-val'));
						} else if ($obj.attr('data-class') == 'it') {
							it.push($obj.attr('data-val'));
						}
					});
					
					var currentUrl = window.location.href.split('?')[0]; 
					if(serviceType == "financing") {
						currentUrl = currentUrl + '?pr=' + pr.join('-') + '&ft=' + ft.join('-'); 
					} else {
						currentUrl = currentUrl + '?ft=' + ft.join('-') + '&it=' + it.join('-'); 
					}
					window.location.href = currentUrl;
				});
				
				return self;
			}
		},
		draw: {
			value: function() {
				var self = this;
				if(self.serviceType == "financing") {
					self.$tar.html($(".template.FinancingFilterArea").doT());
				} else {
					self.$tar.html($(".template.InvestFilterArea").doT());
				}
				$k.util.filter();
				
				var pr = $k.util.getRequestParam('pr');
				var ft = $k.util.getRequestParam('ft');
				var it = $k.util.getRequestParam('it');
				
				if (pr == '') {
					self.$tar.find('.select-all[data-class="pr"]').trigger('click');
				} else {
					$.each(pr.split('-'), function(k, v) {
						self.$tar.find('.select-item[data-class="pr"][data-val="' + v + '"]').trigger('click');
					});
				}
				
				if (ft == '') {
					self.$tar.find('.select-all[data-class="ft"]').trigger('click');
				} else {
					$.each(ft.split('-'), function(k, v) {
						self.$tar.find('.select-item[data-class="ft"][data-val="' + v + '"]').trigger('click');
					});
				}
				
				if (it == '') {
					self.$tar.find('.select-all[data-class="it"]').trigger('click');
				} else {
					$.each(it.split('-'), function(k, v) {
						self.$tar.find('.select-item[data-class="it"][data-val="' + v + '"]').trigger('click');
					});
				}
				
				return self;
			}
		}
	});

})( jQuery );
</script>