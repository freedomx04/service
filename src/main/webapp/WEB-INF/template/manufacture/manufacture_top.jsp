<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<script class="template NavBar" type="text/x-jquery-tmpl">
<div class="nav-bar">
	<ul class="nav nav-pills">
	  <li class="{{=it.subnv == 1 ? "active" : ""}}"><a href="bulletin">智能快报</a></li>
	  <li class="{{=it.subnv == 2 ? "active" : ""}}"><a href="purchase">供求商机</a></li>
	  <li class="{{=it.subnv == 3 ? "active" : ""}}"><a href="product">智能产品</a></li>
	  <li class="{{=it.subnv == 4 ? "active" : ""}}"><a href="successcase">成功案例</a></li>
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
			value: function() {
				var self = this;
				self.$tar.html(self.$tempTar.doT());
				return self;
			}
		}
	});

})( jQuery );
</script>
