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
<link type="text/css" rel="stylesheet" href="vendor/local/css/logistics.css" />

</head>
<body>
	<div id="page">
		<div id="top">
			</div>
			
			<div class="add_titile">
				<div style="line-height: 50px;">
					<span>您正在发布货源信息...</span>
				</div>
			</div>
			
			<div class="add_content">
				<form id="add-supply-form" class="form-horizontal" role="form">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-info-circle fa-fw"></i>货源信息
						</div>
						<div class="panel-body">
							<div class='form-group'>
		   						<label for='origin' class='col-sm-2 control-label'><span class="form-required">*</span>发货地:</label>
		    					<div class='col-sm-5'>
		      						<input type='text' class='form-control citypicker' name='origin' id='origin'>
		    					</div>
		      				</div>
							<div class='form-group'>
		   						<label for='destination' class='col-sm-2 control-label'><span class="form-required">*</span>收货地:</label>
		    					<div class='col-sm-5'>
		      						<input type='text' class='form-control citypicker' name='destination' id='destination'>
		    					</div>
		      				</div>
							<div class="form-group">
								<label for="description" class="col-sm-2 control-label"><span class="form-required">*</span>货源描述</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="description" name="description">
								</div>
							</div>
							<div class="form-group">
								<label for="supplyType" class="col-sm-2 control-label"><span class="form-required">*</span>货物类型</label>
								<div class="col-sm-5">
									<select class="form-control" id="supplyType" name="supplyType">
								      <option value="">请选择</option>
								      <option value="0">重货</option>
								      <option value="1">轻货</option>
								    </select>
								</div>
							</div>
							<div class="form-group">
								<label for="validDate" class="col-sm-2 control-label"><span class="form-required">*</span>信息有效期</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="validDate" data-date-format="yyyy-mm-dd">
								</div>
							</div>
							<div class="form-group">
								<label for="remark" class="col-sm-2 control-label">备注</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="remark" name="remark">
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-info-circle fa-fw"></i>联系人信息
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label for="contactUser" class="col-sm-2 control-label"><span class="form-required">*</span>联系人</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="contactUser" name="contactUser">
								</div>
							</div>
							<div class="form-group">
								<label for="contact" class="col-sm-2 control-label"><span class="form-required">*</span>联系电话</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="contact" name="contact">
								</div>
							</div>
							<div class="form-group">
								<label for="address" class="col-sm-2 control-label"><span class="form-required">*</span>接货地点</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="address" name="address">
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-6 col-sm-6">
							<button  class="btn btn-default btn-submit">保存</button>
						</div>
					</div>
				</form>
			</div>
			
			<div class="add_success hidden">
				<i class="glyphicon glyphicon-ok-circle"></i>
				<span>发布成功</span>
				<div style="margin-top: 10px;"><a href="supply"><button class="btn btn-default">返回首页</button></a></div>
			</div>
			
			<div id="footer">
			</div>
	</div>
</body>
<script>
;(function() {
	new $k.proto.Top().init($("#top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	var $form = $('#add-supply-form');
	
	var user = $k.session.get();
	if(user == undefined) {
		window.location.href = "login";
	}
	var	userId = user.id;
	
	$form.find('.citypicker').citypicker($k.config.initCityPicker);

	$form.find('#validDate').datetimepicker({
		language: 'zh-CN',
		format: 'yyyy-mm-dd',
		minView: "month",
		autoclose: true
	});
	
    $form
    .bootstrapValidator({
        feedbackIcons: {/*input状态样式图片*/
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        excluded:[":disabled"],
        fields: {/*验证：规则*/
        	origin: {//验证input项：验证规则
        		trigger:"change",
                 validators: {
                     notEmpty: {//非空验证：提示消息
                         message: '发货地不能为空'
                     }
                 }
        	},
        	destination: {
        		trigger:"change",
        		validators: {
                    notEmpty: {
                        message: '收货地不能为空'
                    }
                }
        	},
        	description: {
                validators: {
                    notEmpty: {
                        message: '货源描述不能为空'
                    }
                }
       		},
       		supplyType: {
                validators: {
                    notEmpty: {
                        message: '货物类型不能为空'
                    }
                }
       		},
       		validDate: {
       			selector: '#validDate',
       			trigger:"change",
                validators: {
                    notEmpty: {
                        message: '信息有效期不能为空'
                    }
	            }
	       	},
       		contact: {
                validators: {
                    notEmpty: {
                        message: '联系电话不能为空'
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
       		contactUser: {
                validators: {
                    notEmpty: {
                        message: '联系人不能为空'
                    }
                }
       		},
       		address: {
                validators: {
                    notEmpty: {
                        message: '接货地址不能为空'
                    }
                }
       		}
        }
	})
	.on("click", ".btn-submit", function(e) {
		var bootstrapValidator = $form.data('bootstrapValidator').validate();
		if(bootstrapValidator.isValid()) {
			$.ajax({
				url: "logistics/company/findByUserId",
				type: "POST",
				data: {
					userId: userId
				},
				success: function(data) {
					if(data.status == 0) {
						if(data.data == null || (data.data != null && data.data.statusLogistics == 0)) {
							alert("您还没有入驻物流服务，不能发布货源信息！");
							return;
						}
						var formData = new FormData($form[0]); 
						formData.append("userId", userId);
						formData.append("validDate", new Date(Date.parse($form.find("#validDate").val())));
						$.ajax({
							url: "logistics/supply/add",
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