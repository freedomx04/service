<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<script class="template Evaluation" type="text/x-jquery-tmpl">
<div class="item_container">
	<div class="item_ltitle">企业评价</div>
	<div class="evaluation-content">
		<div class="comprehensive-star">
			<span class="text">综合评分:</span>
			<span class="stars">
				{{for(var i = 0; i<it.averageScore; i++) { }}
				<span class="glyphicon glyphicon-star"></span>
				{{ } }}
				{{for(var i = 0; i<5-it.averageScore; i++) { }}
				<span class="glyphicon glyphicon-star-empty"></span>
				{{ } }}
			</span>
			<span class="count">（{{=it.averageScore + "分    "}}来自{{=it.totalEvaluation}}份评价）</span>
		</div>
		<div class="list-container">
		</div>
		<div class="pager_container">
			<ul></ul>
		</div>
		<div class="add-evaluation-content">
			<div><span style="padding: 7px 10px; background-color:#3b8cff; color: #fff;">我要评价</span></div>
			<div style="margin-bottom: 5px; margin-top: 10px;">
				<span>企业评分</span>
				<span class="stars" style="font-size: 24px; top: 6px;">
					<i class="glyphicon glyphicon-star-empty star-1 clickable" star="1"></i>
					<i class="glyphicon glyphicon-star-empty star-2 clickable" star="2"></i>
					<i class="glyphicon glyphicon-star-empty star-3 clickable" star="3"></i>
					<i class="glyphicon glyphicon-star-empty star-4 clickable" star="4"></i>
					<i class="glyphicon glyphicon-star-empty star-5 clickable" star="5"></i>
				</span>
			</div>
			<div><textarea class="form-control" id="comment" name="comment" rows="4"></textarea></div>
			<div style="margin-top: 10px;">
				<input type="checkbox" name="anonymous" id="anonymous" value="1">匿名
				<button id="evaluation-btn" class="btn btn-hm" style="margin-left: 10px;">我要评价</button>
			</div>
		</div>
	</div>
</div>
</script>

<script class="template EvaluationList" type="text/x-jquery-tmpl">
<ul>
	{{~ it.data: evaluation}}
	<li>
		/*<div class="avater"><img alt="头像" src=""></div>*/
		<div>
			<p>
				<span class="name">{{=evaluation.anonymous == 0 && evaluation.user != null ? evaluation.user.username : "匿名"}}</span>
				<span class="text">评分:</span>
				<span class="stars">
					{{for(var i = 0; i<evaluation.score; i++) { }}
					<span class="glyphicon glyphicon-star"></span>
					{{ } }}
					{{for(var i = 0; i<5-evaluation.score; i++) { }}
					<span class="glyphicon glyphicon-star-empty"></span>
					{{ } }}
					<span class="date">{{=new Date(evaluation.createTime).format("yyyy-mm-dd")}}</span>
				</span>
			</p>
			<p>{{=evaluation.comment}}</p>
		</div>
	</li>
	{{~}}
</ul>
</script>

<script>
;(function( $ ) {
	
	var fnName = "Evaluation";
	var Klass = $k.proto[fnName] = function() {};
	Klass.prototype = Object.create(Object.prototype, {
		$tempTar: {
			value: $(".template." + fnName)
		},
		init: {
			value: function($tar, serviceType, companyId) {
				var self = this;
				self.$tar = $tar;
				self.id = companyId;
				self.serviceType = serviceType;
				
				$tar
				.on("click mouseover mouseout", ".add-evaluation-content .glyphicon-star-empty, .add-evaluation-content .glyphicon-star", function() {
					var starNum = $(this).attr("star");
					for(var i=1;i<=5;i++) {
						if(starNum == 1 && event.type != "mouseover") {
							$(this).parent().find(".star-"+i).removeClass("glyphicon-star").addClass("glyphicon-star-empty");
						} else if(i<=starNum && $(this).hasClass("glyphicon-star-empty") && event.type != "mouseout"){
							$(this).parent().find(".star-"+i).removeClass("glyphicon-star-empty").addClass("glyphicon-star");
						} else if(i>starNum){
							$(this).parent().find(".star-"+i).removeClass("glyphicon-star").addClass("glyphicon-star-empty");
						}
					}
				})
				.on("click", "#evaluation-btn", function() {
					var user = $k.session.get();
					if (user == undefined) {
						new $k.proto.LoginDialog().init().draw();
						return self;
					}
					var userId = user.id;
					var $evaluation = $tar.find(".add-evaluation-content");
					$.ajax({
						url: serviceType+ "/evaluation/add",
						type: "POST",
						data: {
							companyId: companyId,
							userId: userId,
							score: $evaluation.find(".glyphicon-star").length,
							comment: $evaluation.find("#comment").val(),
							anonymous: $evaluation.find("#anonymous").prop("checked") ? 1 : 0
						},
						success: function(data) {
							if(data.status == 0) {
								self.load(0);
								document.getElementById("top").scrollIntoView();
								$tar.find(".add-evaluation-content .glyphicon-star").removeClass("glyphicon-star").addClass("glyphicon-star-empty");
								$tar.find(".add-evaluation-content").find("#anonymous").prop("checked", false);
								$tar.find(".add-evaluation-content").find("#comment").val("");
								self.getCompanyEvaluation();
							}
						},
						error: function(e) {}
					});
				});
				return self;
			}
		},
		draw: {
			value: function(averageScore, totalEvaluation) {
				var self = this;
				self.$tar.html(self.$tempTar.doT({
					averageScore: Math.round(averageScore),
					totalEvaluation: totalEvaluation
				}));
				
				return self;
			}
		},
		load: {
			value: function(page) {
				var self = this;
				$.ajax({
		    		url: self.serviceType + "/evaluation/listByCompanyIdPaging",
		    		type: "POST",
		    		data: {
		    			companyId: self.id,
		    			page: page,
		    			size: $k.config.paginator.pageSize
		    		},
		    		success: function(data) {
		    			if(data.status == 0) {
		    				self.$tar.find(".list-container").html($(".template.EvaluationList").doT({
								data: data.data.content,
							}));
		    				
		    				self.$tar.find(".pager_container ul").html("");
		    				if(data.data.content.length == 0) {
		    					return;
		    				}
		    				
		    				var options = $k.config.paginator.options;
							options.totalPages = data.data.totalPages;
							options.onPageClicked = function (event, originalEvent, type, page) { //异步换页
								$.ajax({
					        		url: self.serviceType + "/evaluation/listByCompanyIdPaging",
					        		type: "POST",
					        		data: {
					        			companyId: self.id,
					        			page: page - 1,
					        			size: $k.config.paginator.pageSize
					        		},
					        		success: function(data) {
					        			if(data.status == 0) {
					        				self.$tar.find(".list-container").html($(".template.EvaluationList").doT({
												data: data.data.content,
											}));
					        			}
					        		}
					        	});
					        };
					        self.$tar.find(".pager_container ul").bootstrapPaginator(options);
		    			}
		    		}
		    	});
				return self;
			}
		},
		getCompanyEvaluation: {
			value: function() {
				var self = this;
				$.ajax({
		    		url: self.serviceType + "/company/detail",
		    		type: "POST",
		    		data: {
		    			companyId: self.id,
		    		},
		    		success: function(data) {
		    			if(data.status == 0) {
		    				var score = data.data.score;
		    				var count = data.data.evaluations.length;
		    				var html = "";
		    				for(var i = 0; i<score; i++) {
		    					html = html + '<span class="glyphicon glyphicon-star"></span>';
		    				}
		    				for(var i = 0; i<5-score; i++) {
		    					html = html + '<span class="glyphicon glyphicon-star-empty"></span>';
		    			 	}
	    					self.$tar.find(".comprehensive-star .stars").html(html);
	    					self.$tar.find(".evaluation-content .count").html("（"+ score +"分    来自"+ count +"份评价）");
	    					$(".enterprise-evaluation span").html(count);
	    					/* if(self.serviceType == "talent") {
		    					$(".company_data strong.evaluation-count").html(count);
	    					} */
		    			}
		    		}
		    	});
				return self;
			}
		}
	});

})( jQuery );
</script>