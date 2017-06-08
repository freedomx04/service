<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<%@ include file="/WEB-INF/manager/financing/policy.jsp"%>

<script class='template FinancingManager' type='text/x-jquery-tmpl'>

	<div class='row'>
		<div class='col-lg-12'>
			<div class="hm-alert"></div>
		</div>
	</div>

	<div class='row'>
		<div class='col-lg-12'>

			<ul class="nav nav-tabs" style="padding-top: 20px;">
  				<li class="active"><a href="#financing-policy" data-toggle="tab">国家政策</a></li>
			</ul>

			<div class="tab-content">
				<div class="tab-pane fade active in" id="financing-policy"></div>
			</div>
		<div>
	</div>

</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'FinancingManager';
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
				
				new $k.proto.Policy().init(self.$tar.find("#financing-policy")).draw().load();
				
				return self;
			}
		}
	});
	
})( jQuery );
</script>