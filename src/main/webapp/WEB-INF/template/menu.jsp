<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<script class="template Menu" type="text/x-jquery-tmpl">
	<div class="menu_wrapper">
		<div class="m-hidden" style="float: left; padding-left: 15px; padding-right: 50px;">
			<a class="logo-bg" href="index"></a>
		</div>
		<div id="menu_outer" class="pull-left">
			<ul class="nav">
				<li>
					<a class="{{=it.nav == 1 ? "current" : ""}}" href="recommend">企业推介</a>
				</li>
				<li>
					<a class="{{=it.nav == 2 ? "current" : ""}}" href="bulletin">智能制造</a>
				</li>
				<li>
					<a rel="nofollow" class="{{=it.nav == 3 ? "current" : ""}}" href="recruitment">人才服务</a>
				</li>
				<li>
					<a class="{{=it.nav == 4 ? "current" : ""}}" rel="nofollow" href="financing">融资服务</a>
				</li>
				<li>
					<a class="{{=it.nav == 5 ? "current" : ""}}" rel="nofollow" href="supply">物流服务</a>
				</li>
			</ul>
		</div>
	</div>
</script>

<script>
;(function( $ ) {
	
	var fnName = "Menu";
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
			value: function(nav) {
				var self = this;
				self.$tar
					.html(self.$tempTar.doT({
						nav: nav
					})
				);
				return self;
			}
		}
	});

})( jQuery );
</script>