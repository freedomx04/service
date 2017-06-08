<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--[if lt IE 9]>
  <script src="/vendor/html5shiv/r29/html5.min.js"></script>
  <script src="/vendor/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<title></title>

<%@ include file="/WEB-INF/include/html_head_preload.jsp"%>
<%@ include file="/WEB-INF/template/top.jsp"%>
<%@ include file="/WEB-INF/template/footer.jsp"%>
<link type="text/css" rel="stylesheet" href="vendor/local/css/talent.css" />

</head>
<body>
	<div id="page">
		<div id="top">
			</div>
			
			<div class="add_titile">
				<div style="line-height: 50px;">
					<span>您正在发布求职信息...</span>
				</div>
			</div>
			
			<div class="add_content">
				<form id="add-job-form" class="form-horizontal" role="form">
				</form>
			</div>
			
			<div class="add_success hidden">
				<i class="glyphicon glyphicon-ok-circle"></i>
				<span>发布成功</span>
				<div style="margin-top: 10px;"><a href="job"><button class="btn btn-default">返回首页</button></a></div>
			</div>
			
			<div id="footer">
			</div>
	</div>
</body>

<script class='template JobDialog' type='text/x-jquery-tmpl'>
<div class="panel panel-default">
	<div class="panel-heading">
		<i class="fa fa-info-circle"></i> 基本信息
	</div>
	<div class="panel-body">
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label"><span class="form-required">*</span>姓名</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="name" name="name">
			</div>
		</div>
		<div class="form-group">
			<label for="sex" class="col-sm-2 control-label"><span class="form-required">*</span>性别</label>
			<div class="col-sm-5">
				<select class="form-control" id="sex" name="sex">
			      <option value="">请选择</option>
			      <option value="0">男</option>
			      <option value="1">女</option>
			    </select>
			</div>
		</div>
		<div class="form-group">
			<label for="birthYear" class="col-sm-2 control-label"><span class="form-required">*</span>出生年份</label>
			<div class="col-sm-5">
				<select class="form-control" id="birthYear" name="birthYear">
			      <option value="">请选择</option>
				  {{for(var i=1953; i<=2000; i++) { }}
					<option value="{{=i}}">{{=i}}</option>
				  {{ } }}
			    </select>
			</div>
		</div>
		<div class="form-group">
			<label for="workingYears" class="col-sm-2 control-label"><span class="form-required">*</span>工作年限</label>
			<div class="col-sm-5">
				<select class="form-control" id="workingYears" name="workingYears">
			      <option value="">请选择</option>
				  {{~ $k.constant.workingYears: workingYears}}
					<option value="{{=workingYears.value}}">{{=workingYears.name}}</option>
				  {{~}}
			    </select>
			</div>
		</div>
		<div class="form-group">
			<label for="education" class="col-sm-2 control-label"><span class="form-required">*</span>最高学历</label>
			<div class="col-sm-5">
				<select class="form-control" id="education" name="education">
			      <option value="">请选择</option>
				  {{~ $k.constant.education: education}}
					<option value="{{=education.value}}">{{=education.name}}</option>
				  {{~}}
			    </select>
			</div>
		</div>
		<div class="form-group">
			<label for="contact" class="col-sm-2 control-label"><span class="form-required">*</span>手机号码</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="contact" name="contact">
			</div>
		</div>
		<div class="form-group">
			<label for="uploadImage" class="col-sm-2 control-label"><span class="form-required">*</span>头像</label>
			<div class="col-sm-5">
				<input type="file" class="form-control file-loading" id="uploadImage" name="uploadImage">
			</div>
		</div>
	</div>
</div>
<div class="panel panel-default">
	<div class="panel-heading">
		<i class="fa fa-info-circle"></i> 求职信息
	</div>
	<div class="panel-body">
		<div class="form-group">
			<label for="intention" class="col-sm-2 control-label"><span class="form-required">*</span>求职意向</label>
			<div class="col-sm-7">
				<textarea class="form-control" rows="3" id="intention" name="intention"></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="profession" class="col-sm-2 control-label"><span class="form-required">*</span>行业类别</label>
			<div class="col-sm-5">
				<select class="form-control" id="profession" name="profession">
			      <option value="">请选择</option>
				  {{~ $k.constant.profession: profession}}
					<option value="{{=profession.value}}">{{=profession.name}}</option>
				  {{~}}
			    </select>
			</div>
		</div>
		<div class="form-group">
			<label for="areaId" class="col-sm-2 control-label"><span class="form-required">*</span>工作地点</label>
			<div class="col-sm-5">
				<select class="form-control" id="areaId" name="areaId">
			      <option value="">请选择</option>
				  {{~ it.area: area}}
					<option value="{{=area.id}}">{{=area.name}}</option>
				  {{~}}
			    </select>
			</div>
		</div>
		<div class="form-group">
			<label for="salary" class="col-sm-2 control-label"><span class="form-required">*</span>期望薪资</label>
			<div class="col-sm-7">
				<select class="form-control" id="salary" name="salary">
			      <option value="">请选择</option>
				  {{~ $k.constant.salary: salary}}
					<option value="{{=salary.value}}">{{=salary.name}}</option>
				  {{~}}
			    </select>
			</div>
		</div>
		<div class="form-group">
			<label for="introduction" class="col-sm-2 control-label"><span class="form-required">*</span>自我介绍</label>
			<div class="col-sm-7">
				<textarea class="form-control" id="introduction" name="introduction" rows="3"></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="workExperience" class="col-sm-2 control-label">工作经验</label>
			<div class="col-sm-7">
				<textarea class="form-control" id="workExperience" name="workExperience" rows="3"></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="educationExperience" class="col-sm-2 control-label">教育经历</label>
			<div class="col-sm-7">
				<textarea class="form-control" id="educationExperience" name="educationExperience" rows="3"></textarea>
			</div>
		</div>
	</div>
</div>
<div class="form-group">
<div class="col-sm-offset-6 col-sm-6">
	<button  class="btn btn-default btn-submit">保存</button>
</div>
</div>
</script>

<script>
;(function() {
	new $k.proto.Top().init($("#top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	var $form = $('#add-job-form');
	
	var user = $k.session.get();
	if(user == undefined) {
		window.location.href = "login";
	}
	var	userId = user.id;
	
	$k.util.getAreaList({
		success: function(data) {
			if(data.status == 0) {
				$form.html(self.$(".template.JobDialog").doT({
					area: data.data
				}));
				$k.util.fileinput($form.find('#uploadImage'));
				$form.bootstrapValidator({
					message: 'This value is not valid',
			        feedbackIcons: {/*input状态样式图片*/
			            valid: 'glyphicon glyphicon-ok',
			            invalid: 'glyphicon glyphicon-remove',
			            validating: 'glyphicon glyphicon-refresh'
			        },
			        fields: {/*验证：规则*/
			        	name: {//验证input项：验证规则
			                 validators: {
			                     notEmpty: {//非空验证：提示消息
			                         message: '姓名不能为空'
			                     }
			                 }
			        	},
			        	birthYear: {
			        		validators: {
			                    notEmpty: {
			                        message: '出生年份不能为空'
			                    }
			                }
			        	},
			       		workingYears: {
			                validators: {
			                    notEmpty: {
			                        message: '工作年限不能为空'
			                    }
			                }
			       		},
			       		education: {
			                validators: {
			                    notEmpty: {
			                        message: '最高学历不能为空'
			                    }
			                }
			       		},
			       		contact: {
			                validators: {
			                    notEmpty: {//非空验证：提示消息
			                        message: '联系方式不能为空'
			                    },
			                    stringLength: {
			                        min: 11,
			                        max: 11,
			                        message: '请输入11位手机号码'
			                    },
			                    regexp: {
			                        regexp: /^1[3|5|8]{1}[0-9]{9}$/,
			                        message: '请输入正确的手机号码'
			                    }
			                }
			       		},
			       		intention: {
			                validators: {
			                    notEmpty: {
			                        message: '求职意向不能为空'
			                    }
			                }
			       		},
			       		profession: {
			                validators: {
			                    notEmpty: {
			                        message: '行业类别不能为空'
			                    }
			                }
			       		},
			       		salary: {
			                validators: {
			                    notEmpty: {
			                        message: '薪资待遇不能为空'
			                    }
			                }
			       		},
			       		introduction: {
			                validators: {
			                    notEmpty: {//非空验证：提示消息
			                        message: '自我介绍不能为空'
			                    }
			                }
			       		}
			        }
				});
			}
		}
	});

	$form
	.on("click", ".btn-submit", function() {
		var bootstrapValidator = $form.data('bootstrapValidator').validate();
		if(bootstrapValidator.isValid()) {
			var formData = new FormData($form[0]); 
			formData.append("userId", userId);
			$.ajax({
				url: "talent/job/add",
				type: "POST",
				data: formData,
				async: false, 
	          	cache: false, 
	          	contentType: false, 
	          	processData: false,  
				success: function(data) {
					if(data.status == 0) {
						$(".add_titile, .add_content").addClass("hidden");
						$(".add_success").removeClass("hidden");
						document.getElementById("top").scrollIntoView();
					}
				},
				error: function(e) {}
			});
		} else {
			return;
		}
	});
})();
</script>
</html>