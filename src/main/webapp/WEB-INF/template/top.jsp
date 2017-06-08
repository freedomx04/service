<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ include file="/WEB-INF/template/common/session.jsp"%>
<%@ include file="/WEB-INF/template/common/loginDialog.jsp"%>

<script class="template Top" type="text/x-jquery-tmpl">
	<div class="login_wraper m-hidden">
		<div class="login_wraper">
			<div class="login">

				<div class="top_left">
					{{? it.user}}
						<a>{{=it.user.username}}</a>
						<a class="user-logout">登出</a>
					{{??}}
						<a href="login">请登录</a>
						<a href="login#register">免费注册</a>
					{{?}}

				</div>

				<ul class="top_right">
					<li>
						<a href="index">首页</a>
					</li>
					<li>
						<a href="javascript:void(0)" onclick="shoucang(document.title,window.location)">加入收藏</a>
					</li>
					<li>
						<a href="manager" target="_blank">个人中心</a>
					</li>
					<li>
						<a class="supplyIn" href="in" target="_blank">供应商入驻</a>
					</li>
				</ul>

			</div>
		</div>
	</div>
</script>

<script class="template Modal" type="text/x-jquery-tmpl">
	<div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-body">{{=it.content}}</div>
	        <div class="modal-footer">
	            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	            <a href="login" class="btn btn-primary" target="_blank">前去登录</a>
	        </div>
	    </div>
	</div>
</script>

<script>
;(function( $ ) {
	
	var fnName = "Top";
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $(".template." + fnName)
		},
		init: {
			value: function($tar) {
				var self = this;
				self.$tar = $tar;
				$tar
				.on('click', '.user-logout', function() {
					$.ajax({
						url: 'user/logout',
						type: 'POST',
						data: { userId: self.userId },
						success: function(data) {
							if (data.status == 0) {
								window.location.href = "./login";
								$k.user.logout();
							}
						},
						error: function(err) {}
					});
				});
				return self;
			}
		},
		draw: {
			value: function() {
				var self = this;
				
				var user = $k.session.get();
				if (user) {
					self.userId = user.id;
				}
				
				self.$tar.html(self.$tempTar.doT({
					user: user
				}));
				
				return self;
			}
		}
	});

})( jQuery );
</script>
<script type="text/javascript"> 
	
	function shoucang(sTitle,sURL) { // 加入收藏 兼容360和IE6 
		try { 
			window.external.addFavorite(sURL, sTitle); 
		} catch (e) { 
			try { 
				window.sidebar.addPanel(sTitle, sURL, ""); 
			} catch (e) { 
				alert("加入收藏失败，请使用Ctrl+D进行添加"); 
			} 
		} 
	} 
</script>