<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--[if lt IE 9]>
  <script src="vendor/html5shiv/r29/html5.min.js"></script>
  <script src="vendor/respond/1.4.2/respond.min.js"></script>
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
				<span>您正在发布招聘信息...</span>
			</div>
		</div>
		
		<div class="add_content">
			<form id="add-recruitment-form" class="form-horizontal" role="form">
			</form>
		</div>
		<div class="add_success hidden">
			<i class="glyphicon glyphicon-ok-circle"></i>
			<span>发布成功</span>
			<div style="margin-top: 10px;"><a href="recruitment"><button class="btn btn-default">返回首页</button></a></div>
		</div>
		<div id="footer">
		</div>
	</div>
</body>

<script class='template RecruitmentDialog' type='text/x-jquery-tmpl'>
<div class="panel panel-default">
	<div class="panel-heading">
		<i class="fa fa-info-circle"></i> 招聘信息
	</div>
	<div class="panel-body">

		<div class="form-group">
			<label for="position" class="col-sm-2 control-label"><span class="form-required">*</span>招聘职位</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="position" name="position">
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
			<label for="salary" class="col-sm-2 control-label"><span class="form-required">*</span>薪资待遇</label>
			<div class="col-sm-5">
				<select class="form-control" id="salary" name="salary">
			      <option value="">请选择</option>
				  {{~ $k.constant.salary: salary}}
					<option value="{{=salary.value}}">{{=salary.name}}</option>
				  {{~}}
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
			<label for="education" class="col-sm-2 control-label"><span class="form-required">*</span>学历要求</label>
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
			<label for="number" class="col-sm-2 control-label"><span class="form-required">*</span>招聘人数</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="number" name="number">
			</div>
		 </div>

		<div class="form-group">
			<label for="responsibilities" class="col-sm-2 control-label"><span class="form-required">*</span>岗位职责</label>
			<div class="col-sm-7">
				<textarea class="form-control" rows="3" id="responsibilities" name="responsibilities"></textarea>
			</div>
		</div>

		<div class="form-group">
			<label for="requirements" class="col-sm-2 control-label"><span class="form-required">*</span>任职要求</label>
			<div class="col-sm-7">
				<textarea class="form-control" rows="3" id="requirements" name="requirements"></textarea>
			</div>
		 </div>

		 <div class="form-group">
			<label for="areaId" class="col-sm-2 control-label"><span class="form-required">*</span>工作地点</label>
			<div class="col-sm-7">
				<select class="form-control" id="areaId" name="areaId">
			      <option value="">请选择</option>
				  {{~ it.area: area}}
					<option value="{{=area.id}}">{{=area.name}}</option>
				  {{~}}
			    </select>
			</div>
		 </div>

		 <div class="form-group">
			<label for="address" class="col-sm-2 control-label"><span class="form-required">*</span>详细地址</label>
			<div class="col-sm-7">
				<textarea class="form-control" id="address" name="address" rows="3"></textarea>
			</div>
		 </div>

		 <div class="form-group">
			<label for="workingHours" class="col-sm-2 control-label"><span class="form-required">*</span>工作时间</label>
			<div class="col-sm-7">
				<input type="text" class="form-control" id="workingHours" name="workingHours">
			</div>
		 </div>

		 <div class="form-group">
			<label for="contact" class="col-sm-2 control-label"><span class="form-required">*</span>联系方式</label>
			<div class="col-sm-7">
				<input type="text" class="form-control" id="contact" name="contact">
			</div>
		 </div>

	</div>
</div>
<div class="form-group">
	<div class="col-sm-offset-6 col-sm-6">
		<button class="btn btn-default btn-submit">保存</button>
	</div>
</div>
</script>

<script>
;(function() {
	new $k.proto.Top().init($("#top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	var $form = $('#add-recruitment-form');

	var user = $k.session.get();
	if(user == undefined) {
		window.location.href = "login";
	}
	var	userId = user.id;
	
	$k.util.getAreaList({
		success: function(data) {
			if(data.status == 0) {
				$form.html(self.$(".template.RecruitmentDialog").doT({
					area: data.data
				}));
				$form.bootstrapValidator({
					message: 'This value is not valid',
			        feedbackIcons: {/*input状态样式图片*/
			            valid: 'glyphicon glyphicon-ok',
			            invalid: 'glyphicon glyphicon-remove',
			            validating: 'glyphicon glyphicon-refresh'
			        },
			        fields: {/*验证：规则*/
			        	position: {//验证input项：验证规则
			                 validators: {
			                     notEmpty: {
			                         message: '招聘职位不能为空'
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
			                        message: '学历要求不能为空'
			                    }
			                }
			       		},
			       		number: {
			                validators: {
			                    notEmpty: {
			                        message: '招聘人数不能为空'
			                    },
			                    digits: {
			                    	message: '必须为整数'
			                    }
			                }
			       		},
			       		responsibilities: {
			                validators: {
			                    notEmpty: {
			                        message: '岗位职责不能为空'
			                    }
			                }
			       		},
			       		requirements: {
			                validators: {
			                    notEmpty: {
			                        message: '任职要求不能为空'
			                    }
			                }
			       		},
			       		areaId: {
			                validators: {
			                    notEmpty: {
			                        message: '工作地点不能为空'
			                    }
			                }
			       		},
			       		address: {
			                validators: {
			                    notEmpty: {
			                        message: '工作地址不能为空'
			                    }
			                }
			       		},
			       		workingHours: {
			                validators: {
			                    notEmpty: {
			                        message: '工作时间不能为空'
			                    }
			                }
			       		},
			       		contact: {
			                validators: {
			                    notEmpty: {
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
			       		}
			        }
				});
			}
		}
	});
	
	$form.on("click", ".btn-submit", function() {
		var bootstrapValidator = $form.data('bootstrapValidator').validate();
		if(bootstrapValidator.isValid()) {
			$.ajax({
				url: "talent/company/findByUserId",
				type: "POST",
				data: {
					userId: userId
				},
				success: function(data) {
					if(data.status == 0) {
						if(data.data == null || (data.data != null && data.data.statusTalent == 0)) {
							alert("您还没有入驻人才服务，不能发布招聘信息！");
							return;
						}
						var dataParam = $form.serializeArray();
						dataParam.push({"name": "companyId", "value": data.data.id});
						$.ajax({
							url: "talent/recruitment/add",
							type: "POST",
							data: dataParam,
							success: function(data) {
								if(data.status == 0) {
									$(".add_titile, .add_content").addClass("hidden");
									$(".add_success").removeClass("hidden");
									document.getElementById("top").scrollIntoView();
								}
							},
							error: function(e) {}
						});
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