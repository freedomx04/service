<%@page import="com.google.gson.Gson"%>
<%@page import="com.hongmeng.service.entity.authority.BaseUserEntity"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<script>
;(function( $ ) {

	$k.session.get = function() {
		<% 
			Gson gson = new Gson();
			BaseUserEntity user = (BaseUserEntity) session.getAttribute("cur_user");
			String str = gson.toJson(user);
		%>
		var user = JSON.parse('<%=str%>');
		if (user) {
			return user;
		} else {
			return undefined;
		}
	}

})( jQuery );
</script>