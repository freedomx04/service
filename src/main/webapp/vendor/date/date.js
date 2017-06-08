if (!Date.init) {

	Date.init = function(s) {
		if (s && typeof (s.$date) == "string") {
			s = s.$date;
		}

		var date = new Date(s);
		if (!isNaN(date)) {
			return date;
		}

		s = s.replace(/[Zz]\s*$/, "+0");
		date = new Date(s);
		if (!isNaN(date)) {
			return date;
		}

		s = s.replace(/-/g, "/");
		date = new Date(s);
		if (!isNaN(date)) {
			return date;
		}

		s = s.replace(/\.\d+\+0$/i, "+0");
		date = new Date(s);
		if (!isNaN(date)) {
			return date;
		}

		var re = s.match(/^(\d{4})(\d{2})(\d{2})$/);
		if (re) {
			re.shift();
			s = re.join("/");
			date = new Date(s);
		}

		return date;
	};

}

if (!Date.now) {

	Date.now = function() {
		return new Date().getTime();
	};

}
