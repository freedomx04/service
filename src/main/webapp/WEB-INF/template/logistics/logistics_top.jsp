<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<script class="template NavBar" type="text/x-jquery-tmpl">
<div class="nav-bar">
	<ul class="nav nav-pills">
	  <li class="{{=it.subnv == 1 ? "active" : ""}}"><a href="supply">货源信息</a></li>
	  <li class="{{=it.subnv == 2 ? "active" : ""}}"><a href="line">物流线路</a></li>
	  <li class="{{=it.subnv == 3 ? "active" : ""}}"><a href="network">物流网点</a></li>
	  <li class="{{=it.subnv == 4 ? "active" : ""}}"><a href="logisticsDynamic">服务动态</a></li>
	</ul>
</div>
</script>

<script>
;(function( $ ) {
	
	var fnName = "NavBar";
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $(".template." + fnName)
		},
		init: {
			value: function($tar) {
				var self = this;
				self.$tar = $tar;
				return self;
			}
		},
		draw: {
			value: function(subnv) {
				var self = this;
				self.$tar.html(self.$tempTar.doT({
					subnv: subnv
				}));
				return self;
			}
		}
	});

})( jQuery );
</script>
