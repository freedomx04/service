;(function() {
	
	$k.util.loadArea = function($tar, area) {
		var $select = $tar.find('.select-area');
		
		$k.util.getAreaList({
			success: function(data) {
				$.each(data.data, function(key, val) {
					var option = '<option value=' + val.id + '>' + val.name + '</option>';
					$(option).appendTo($select);
				})
				
				if (area) {
					$select.find('option[value="' + area.id + '"]').attr('selected', true);
				}
			}
		});
	}
	
	
})();