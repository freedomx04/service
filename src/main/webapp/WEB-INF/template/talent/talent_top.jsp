<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<script class="template FilterArea" type="text/x-jquery-tmpl">
	<ul class="select">
		<li class="select-list">
			<dt class="select-dt">区域：</dt>
			<dl class="select-dl" select="area" style="height: 32px; overflow: hidden; padding-right: 28px;">
				<dd class="select-dd select-all" data-class='ar'>
					<a class="select-a">不限</a>
				</dd>
			</dl>
		</li>
		<li class="select-list">
			<dt class="select-dt">工作经验：</dt>
			<dl class="select-dl" select="work-experience" style="height: 32px; overflow: hidden; padding-right: 28px;">
				{{~$k.constant.workingYears: data:index}}
					{{?index == 0}}
					<dd class="select-dd select-all" data-class='wy'>
						<a class="select-a">不限</a>
					</dd>
					{{??}}
					<dd class="select-dd select-item" data-class='wy' data-val='{{=data.value}}'>
						<a class="select-a">{{=data.name}}</a>
					</dd>
					{{?}}
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
			<dt class="select-dt">学业要求：</dt>
			<dl class="select-dl" select="education" style="height: 32px; overflow: hidden; padding-right: 28px;">
				{{~$k.constant.education: data:index}}
					{{?index == 0}}
					<dd class="select-dd select-all" data-class='ed'>
						<a class="select-a">不限</a>
					</dd>
					{{??}}
					<dd class="select-dd select-item" data-class='ed' data-val='{{=data.value}}'>
						<a class="select-a">{{=data.name}}</a>
					</dd>
					{{?}}
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
			<dt class="select-dt">行业领域：</dt>
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
			<dt class="select-dt">薪资：</dt>
			<dl class="select-dl" select="salary" style="height: 32px; overflow: hidden; padding-right: 28px;">
				<dd class="select-dd select-all" data-class='sa'>
					<a class="select-a">不限</a>
				</dd>
				{{~$k.constant.salary: data}}
					<dd class="select-dd select-item" data-class='sa' data-val='{{=data.value}}'>
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

<script class="template SearchBar" type="text/x-jquery-tmpl">
<div class="nav-bar">
	<ul class="nav nav-pills">
	  <li class="{{=it.subnv == 1 ? "active" : ""}}"><a href="recruitment">招聘信息</a></li>
	  <li class="{{=it.subnv == 2 ? "active" : ""}}"><a href="job">求职信息</a></li>
	  <li class="{{=it.subnv == 3 ? "active" : ""}}"><a href="talentunit">服务单位</a></li>
	</ul>
	<div class="input-wraper">
		{{? it.subnv != 3 }}
		<div class="keyword-wraper pull-left ">
		    <input type="text" id="searchStr" autocomplete="off" maxlength="64" placeholder="搜索职位" value="">
		</div>
		{{?}}
		{{? it.subnv == 1}}
		<input type="text" id="recruitment-search" class="submit" value="搜索" readonly="true">
		<a class="addRecruitment m-hidden"><button class="btn btn-default btn-lg pull-right">发布招聘</button></a>
		{{?? it.subnv == 2}}
		<input type="text" id="job-search" class="submit" value="搜索" readonly="true">
		<a class="addJob m-hidden"><button class="btn btn-default btn-lg pull-right">发布求职</button></a>
		{{?}}
	</div>
</div>
</script>

<script>
;(function( $ ) {
	
	var fnName = "FilterArea";
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $(".template." + fnName)
		},
		init: {
			value: function($tar) {
				var self = this;
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
					var ar = [];
					var pr = [];
					var ed = [];
					var wy = [];
					var sa = [];
					$.each($tar.find('.select-result .select-item.selected'), function(index, obj) {
						var $obj = $(obj);
						if ($obj.attr('data-class') == 'ar') {
							ar.push($obj.attr('data-val'));
						} else if ($obj.attr('data-class') == 'pr') {
							pr.push($obj.attr('data-val'));
						} else if ($obj.attr('data-class') == 'ed') {
							ed.push($obj.attr('data-val'));
						} else if ($obj.attr('data-class') == 'wy') {
							wy.push($obj.attr('data-val'));
						} else if ($obj.attr('data-class') == 'sa') {
							sa.push($obj.attr('data-val'));
						}
					});
					
					var currentUrl = window.location.href.split('?')[0]; 
					currentUrl = currentUrl + '?ar=' + ar.join('-') + '&pr=' + pr.join('-') + '&ed=' + ed.join('-') + '&wy=' + wy.join('-') + '&sa=' + sa.join('-'); 
					window.location.href = currentUrl;
				});
				$("#page").on("click", ".addRecruitment, .addJob", function() {
					var user = $k.session.get();
					if(user == undefined) {
						new $k.proto.LoginDialog().init().draw();
					} else {
						if($(this).hasClass("addRecruitment")) {
							window.open("addRecruitment");
						} else {
							window.open("addJob");
						}
					}
				});
				return self;
			}
		},
		draw: {
			value: function() {
				var self = this;
				self.$tar.html(self.$tempTar.doT());
				
				var area = $k.util.getAreaList({
					success: function(data) {
						if (data.status == 0) {
							var $area = self.$tar.find("dl[select='area']");
							$.each(data.data, function(key, val) {
								var html = "<dd class='select-dd select-item' data-class='ar' data-val='"+ val.id +"'>"+
								"<a class='select-a'>"+ val.name +"</a></dd>";
								$(html).appendTo($area);
							});
							$k.util.filter();
							
							var arr = ['ar', 'pr', 'ed', 'wy', 'sa'];
							$.each(arr, function(index, param) {
								var val = $k.util.getRequestParam(param);
								if (val == '') {
									self.$tar.find('.select-all[data-class="' + param +'"]').trigger('click');
								} else {
									$.each(val.split('-'), function(k, v) {
										self.$tar.find('.select-item[data-class="' + param + '"][data-val="' + v + '"]').trigger('click');
									});
								}
							});
							
						}
					}
				});
				return self;
			}
		},
	});

})( jQuery );
</script>
