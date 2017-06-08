;(function() {
	
	$k.user.set = function(userObj) {
		if (userObj) {
			$.session.clear();
			$.session.set("service_cur_user", JSON.stringify(userObj))
		}
	}
	
	$k.user.get = function() {
		var userObj = $.session.get("service_cur_user");
		if (userObj != undefined) {
			return JSON.parse($.session.get("service_cur_user"));
		}
		return undefined;
	}
	
	$k.user.logout = function() {
		$.session.clear();
	}
	
})();