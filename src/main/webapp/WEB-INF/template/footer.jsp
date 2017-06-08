<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<style type="text/css">
#footer {
	min-width: 1000px;
	height: 30px;
	line-height: 30px;
	background-color: #333;
	position: absolute;
	bottom: 0;
	left: 0;
	right: 0;
}
#footer p {
	text-align: center;
	color: #c4c3c3;
	font-size: 12px;
	margin-bottom: 0 !important;
}
</style>

<script class="template Footer" type="text/x-jquery-tmpl">
	<p>广昌县工业和信息化委员会 版权所有 - 赣ICP备17002970号</p>
</script>

<script>
;(function( $ ) {
	
	var fnName = "Footer";
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