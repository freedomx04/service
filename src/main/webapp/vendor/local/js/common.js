;
(function() {

	Array.prototype.where = function(s) {
		return eval("(jQuery.grep(this, function (o, i){return " + s + ";}))");
	}

	/**
	 * 无需jquery
	 */
	/*Array.prototype.where = function(str) {
		var rs = [];
		for ( var i in this) {
			var o = this[i];
			if (typeof (this[i]) != 'function')
				if (eval(str))
					rs.push(o);
		}
		return rs
	};*/

})();