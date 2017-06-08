<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ include file="/WEB-INF/manager/admin/bulletin.jsp"%>

<script class='template ManufactureManager' type='text/x-jquery-tmpl'>

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>

			<ul class="nav nav-tabs" style="padding-top: 20px;">
  				<li class="active"><a href="#manufacture-bulletin-0" data-toggle="tab">制造快讯</a></li>
  				<li><a href="#manufacture-bulletin-1" data-toggle="tab">市场分析</a></li>
  				<li><a href="#manufacture-bulletin-2" data-toggle="tab">企业动态</a></li>
  				<li><a href="#manufacture-bulletin-3" data-toggle="tab">新品速递</a></li>
  				<li><a href="#manufacture-bulletin-4" data-toggle="tab">技术前沿</a></li>
  				<li><a href="#manufacture-bulletin-5" data-toggle="tab">政策法规</a></li>
			</ul>

			<div class="tab-content">
				<div class="tab-pane fade active in" id="manufacture-bulletin-0"></div>
   				<div class="tab-pane fade" id="manufacture-bulletin-1"></div>
    			<div class="tab-pane fade" id="manufacture-bulletin-2"></div>
    			<div class="tab-pane fade" id="manufacture-bulletin-3"></div>
    			<div class="tab-pane fade" id="manufacture-bulletin-4"></div>
    			<div class="tab-pane fade" id="manufacture-bulletin-5"></div>
			</div>
		<div>
	</div>

</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'ManufactureManager';
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
				
				new $k.proto.Bulletin().init(self.$tar.find("#manufacture-bulletin-0")).draw(0).load();
				new $k.proto.Bulletin().init(self.$tar.find("#manufacture-bulletin-1")).draw(1).load();
				new $k.proto.Bulletin().init(self.$tar.find("#manufacture-bulletin-2")).draw(2).load();
				new $k.proto.Bulletin().init(self.$tar.find("#manufacture-bulletin-3")).draw(3).load();
				new $k.proto.Bulletin().init(self.$tar.find("#manufacture-bulletin-4")).draw(4).load();
				new $k.proto.Bulletin().init(self.$tar.find("#manufacture-bulletin-5")).draw(5).load();
				
				return self;
			}
		}
	});
	
})( jQuery );
</script>