<%@ page contentType='text/html;charset=UTF-8' language='java' %>

<script class='template Visit' type='text/x-jquery-tmpl'>
	<div class='row' style="padding-top: 30px;">
		<div class='col-lg-12'>
			<div class='module-list'>

				<div class='list-table' tyle='font-size: 12px;'>
					<table class='table table-hover hm-table' id='visit-table'>
						<thead>
            				<tr>
								<th>日期</th>
            					<th>访问量</th>
               				</tr>
            			</thead>
            			<tbody>
							{{~ it.data: visit }}
							<tr class="table-tr">
								<td>{{=visit[0]}}</td>
								<td>{{=visit[1]}}</td>
							</tr>
							{{~}}
						</tbody>
					</table>
				</div>

			</div><!-- module-list -->
		</div>
	</div>
</script>

<script type='text/javascript'>
;(function( $ ) {
	
	var fnName = 'Visit';
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $('.template.' + fnName)
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
				
				if (self.datatables) {
					self.datatables.fnDestroy();
				}
				
				$.ajax({
					url: 'visit/list',
					type: 'POST',
					success: function(data) {
						self.$tar.html(self.$tempTar.doT({
							data: data.data
						}));
						self.table = $k.util.dataTable(
							self.$tar.find('#visit-table'), {
								'order': [[ 0, 'desc' ]],
							});
					},
					error: function(err) {}
				});
				
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
