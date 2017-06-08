<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style type='text/css'>
</style>

<script class="template User" type="text/x-jquery-tmpl">
	
</script>


<script type="text/javascript">
;(function( $ ) {
	
	var fnName = "User";
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
		},
		load: {
			value: function() {
				var self = this;
				
				return self;
			}
		}
	});
	
})( jQuery );
</script>
