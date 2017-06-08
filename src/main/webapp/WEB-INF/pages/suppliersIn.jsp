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
<%@ include file="/WEB-INF/template/menu.jsp"%>

<style>
.form-container {
	margin-top: 20px;
}
.form-container .apply {
	width: 35%;
	margin: 0 auto;
	line-height: 50px;
	font-size: 16px;
}
.form-container .apply .title {
	font-weight: bold;
}
.form-container .apply .apply-status {
	margin: 0 10px 20px;
}
.form-container .apply .apply-status.applied {
	color: #3b8cff;
}
.form-container .apply .apply-status.unapplied {
	color: #fd5f39;
}
.in_bg {
	margin: 20px 0;
}
.in_bg img{
	width: 1000px;
	height: 120px;
}
.in_process {
	padding: 40px 70px;
    border: 1px solid #ddd;
    background-color: #fff;
}
.in_step_line {
	position: absolute;
    z-index: 10;
    top: 40px;
    width: 858px;
    height: 3px;
    background-color: #dadada;
}
.in_step_line span {
    display: block;
    overflow: hidden;
    position: absolute;
    z-index: 11;
    width: 72%;
    height: 3px;
    background-color: #76aedf;
}
.in_step_01 .in_step_line span {
    width: 25%;
}
.in_step_02 .in_step_line span {
    width: 55%;
}
.in_step_03 .in_step_line span {
    width: 80%;
}
.in_step_04 .in_step_line span {
    width: 100%;
}
.in_step {
    width: 858px;
    height: 110px;
    overflow: hidden;
    position: relative;
}
.in_step_group {
    position: absolute;
    z-index: 20;
    width: 1100px;
}
.in_step_item {
    float: left;
    margin-right: 178px;
    background-color: #fff;
    text-align: center;
}
.icon_in_step_01, .icon_in_step_02, .icon_in_step_03, .icon_in_step_04 {
    background-image: url(/service/img/icon-in.png);
    background-repeat: no-repeat;
    display: block;
    margin-left: auto;
    margin-right: auto;
    width: 80px;
    height: 84px;
}
.icon_in_step_02 {
    background-position: -90px -90px;
}
.icon_in_step_03 {
    background-position: -180px -90px;
}
.icon_in_step_04 {
    background-position: -270px -90px;
}
.in_step_02 .icon_in_step_02, .in_step_03 .icon_in_step_02,
.in_step_04 .icon_in_step_02 {
    background-position: -90px top;
}
.in_step_03 .icon_in_step_03, .in_step_04 .icon_in_step_03 {
    background-position: -180px top;
}
.in_step_04 .icon_in_step_04 {
    background-position: -270px top;
}
</style>

</head>
<body>
	<div id="page">
		<div id="top">
			<div class="top"></div>
			<div class="menu"></div>
		</div>
		
		<div class="content-container">
		    <div class="main_container">
		    	<div class="in_bg"></div>
		    	<div class="in_process">
		    		<div class="in_step in_step_01">
		    			<div class="in_step_line"><span></span></div>
		    			<ul class="in_step_group">
	                        <li class="in_step_item">
	                            <i class="icon_in_step_01"></i>
	                            <span>公司基本信息</span>
	                        </li>
	                        <li class="in_step_item">
	                            <i class="icon_in_step_02"></i>
	                            <span>上传材料</span>
	                        </li>
	                        <li class="in_step_item">
	                            <i class="icon_in_step_03"></i>
	                            <span>等待审核</span>
	                        </li>
	                        <li class="in_step_item">
	                            <i class="icon_in_step_04"></i>
	                            <span>申请服务</span>
	                        </li>
	                    </ul>
		    		</div>
		    		<div class="form-container">
		                <form id="add-form" class="form-horizontal" role="form">
		                </form>
		              </div>
		    	</div>
		    </div>
		</div>
		<div id="footer">
		</div>
	</div>
</body>

<script class="template InStep1" type="text/x-jquery-t">
<div class="form-group">
	<label for="" class="col-sm-4 control-label"><i class="form-required">*</i>公司名称:</label>
	<div class="col-sm-5">
		<input type="text" class="form-control" id="name" name="name">
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-4 control-label"><i class="form-required">*</i>公司logo:</label>
	<div class="col-sm-5">
		<input type="file" class="form-control file-loading" id="uploadImage" name="uploadImage">
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-4 control-label"><i class="form-required">*</i>行业类别:</label>
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
	<label for="" class="col-sm-4 control-label"><i class="form-required">*</i>公司性质:</label>
	<div class="col-sm-5">
		<select class="form-control" id="property" name="property">
	      <option value="">请选择</option>
		  {{~ $k.constant.property: property}}
			<option value="{{=property.value}}">{{=property.name}}</option>
		  {{~}}
	    </select>
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-4 control-label"><i class="form-required">*</i>公司规模:</label>
	<div class="col-sm-5">
		<select class="form-control" id="scale" name="scale">
	      <option value="">请选择</option>
		  {{~ $k.constant.scale: scale}}
				<option value="{{=scale.value}}">{{=scale.name}}</option>
		  {{~}}
	    </select>
	</div>
</div>
<div class="form-group">
<label for="" class="col-sm-4 control-label"><i class="form-required">*</i>公司地点:</label>
	<div class="col-sm-5">
		<select class="form-control" id="areaId" name="areaId">
	      <option value="">请选择</option>
		  {{~ it.area : area}}
		  	<option value="{{=area.id}}">{{=area.name}}</option>
		  {{~}}
	    </select>
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-4 control-label"><i class="form-required">*</i>公司详细地址:</label>
	<div class="col-sm-5">
		<input type="text" class="form-control" id="address" name="address">
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-4 control-label"><i class="form-required">*</i>座机号码:</label>
	<div class="col-sm-5">
		<input type="text" class="form-control" id="phone" name="phone">
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-4 control-label"><i class="form-required">*</i>联系人:</label>
	<div class="col-sm-5">
		<input type="text" class="form-control" id="contactUser" name="contactUser">
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-4 control-label"><i class="form-required">*</i>联系方式:</label>
	<div class="col-sm-5">
		<input type="text" class="form-control" id="contact" name="contact">
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-4 control-label">公司传真号:</label>
	<div class="col-sm-5">
		<input type="text" class="form-control" id="fax" name="fax">
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-4 control-label">公司网站:</label>
	<div class="col-sm-5">
		<input type="text" class="form-control" id="website" name="website">
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-4 control-label">公司简介:</label>
	<div class="col-sm-5">
		<textarea class="form-control" rows="5" id="introduction" name="introduction"></textarea>
	</div>
</div>
<div class="form-group">
	<div class="col-sm-offset-6 col-sm-6">
		<button id="addCompany-btn" class="btn btn-default btn-submit">下一步</button>
	</div>
</div>
</script>

<script class="template InStep2" type="text/x-jquery-t">
	{{?it.status == 3}}<div style="text-align: center; color: #fd5f39; margin-bottom: 20px;">您提交的信息未通过审核，请重新上传！</div>{{?}}
	<div class="form-group">
		<label for="" class="col-sm-4 control-label"><i class="form-required">*</i>营业执照号:</label>
		<div class="col-sm-5">
			<input type="text" class="form-control" id="license" name="license" placeholder="请输入">
		</div>
	</div>
	<div class="form-group">
	    <label class="col-sm-4 control-label" for="">附件上传</label>
	    <div class="col-sm-5">
			<input type="file" class="form-control" id="attachment" name="attachment">
		</div>
	</div>
	<div class="form-group">
	    <div class="col-sm-offset-4 col-sm-5">
			<div><i class="form-required">*</i>请上传企业的最新营业执照扫描件</div>
		</div>
	</div>
	/*<div class="form-group">
	    <label class="col-sm-4 control-label" for="">上传协议</label>
	    <div class="col-sm-5">
			<input type="file" class="form-control" id="protocol" name="protocol">
		</div>
	</div>
	<div class="form-group">
	    <div class="col-sm-offset-4 col-sm-6">
			<div><i class="form-required">*</i>请先下载企业申请表,打印后填写并加盖公章后上传扫描件</div>
		</div>
	</div>*/
	<div class="form-group">
		<div class="col-sm-offset-6 col-sm-6">
			<button id="uploadData-btn" class="btn btn-default btn-submit">提交</button>
		</div>
	</div>
</script>

<script class="template InStep3" type="text/x-jquery-t">
<div style="text-align: center; color:#fd5f39; font-size: 16px;">
	<div>正在审核......</div>
	<div>请耐心等待！</div>
	<div>审核成功后可前来申请服务！</div>
</div>
</script>

<script class="template InStep4" type="text/x-jquery-t">
<div class="apply">
	<span class="title">企业推介:</span>
	{{? it.data.statusRecommend == 0}}
	<button class="btn btn-hm apply-btn" applyType="1" style="margin-left: 10px;">申请服务</button>
	{{??}}
	<span class="apply-status applied">已申请</span>
	{{?}}
</div>
<div class="apply">
	<span class="title">智能制造:</span>
	{{? it.data.statusManufacture == 0}}
	<button class="btn btn-hm apply-btn" applyType="2" style="margin-left: 10px;">申请服务</button>
	{{??}}
	<span class="apply-status applied">已申请</span>
	{{?}}
</div>
<div class="apply">
	<span class="title">人才服务:</span>
	{{? it.data.statusTalent == 0}}
	<button class="btn btn-hm apply-btn" applyType="3" style="margin-left: 10px;">申请服务</button>
	{{??}}
	<span class="apply-status applied">已申请</span>
	{{?}}
</div>
<div class="apply">
	<span class="title">融资服务:</span>
	{{? it.data.statusFinancing == 0}}
	<button class="btn btn-hm apply-btn" applyType="4" style="margin-left: 10px;">申请服务</button>
	{{??}}
	<span class="apply-status applied">已申请</span>
	{{?}}
</div>
<div class="apply">
	<span class="title">物流服务:</span>
	{{? it.data.statusLogistics == 0}}
	<button class="btn btn-hm apply-btn" applyType="5" style="margin-left: 10px;">申请服务</button>
	{{??}}
	<span class="apply-status applied">已申请</span>
	{{?}}
</div>
</script>

<script>
;(function() {
	
	new $k.proto.Top().init($("#top .top")).draw();
	new $k.proto.Footer().init($("#footer")).draw();
	new $k.proto.Menu().init($("#top .menu")).draw();
	var $container = $(".main_container");
	
	var user = $k.session.get();
	var	userId = user.id;
	
	$k.util.getCompanyByUserId(userId, {
		success: function(companyData) {
			if(companyData.status == 0) {
				if(companyData.data == null) {
					$k.util.getAreaList({
						success: function(data) {
							if(data.status == 0) {
								$container.find("#add-form").html($(".template.InStep1").doT({
									area: data.data
								}));
								$k.util.fileinput($('#uploadImage'));
								$container.find("#add-form").bootstrapValidator({
							        feedbackIcons: {/*input状态样式图片*/
							            valid: 'glyphicon glyphicon-ok',
							            invalid: 'glyphicon glyphicon-remove',
							            validating: 'glyphicon glyphicon-refresh'
							        },
							        fields: {/*验证：规则*/
							        	name: {
							        		validators: {
							                    notEmpty: {
							                        message: '公司名称不能为空'
							                    }
							                }
							        	},
							        	address: {
							        		validators: {
							                    notEmpty: {
							                        message: '公司详细地址不能为空'
							                    }
							                }
							        	},
							        	areaId: {
							        		validators: {
							                    notEmpty: {
							                        message: '公司地点不能为空'
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
							        	property: {
							        		validators: {
							                    notEmpty: {
							                        message: '公司性质不能为空'
							                    }
							                }
							        	},
							        	scale: {
							        		validators: {
							                    notEmpty: {
							                        message: '公司规模不能为空'
							                    }
							                }
							        	},
							        	phone: {
							        		validators: {
							                    notEmpty: {
							                        message: '座机号码不能为空'
							                    },
							                    regexp: {
							                    	regexp: /^(\d{3,4}-?)?\d{7,9}$/g,
							                    	message: '请输入正确的座机号码'
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
				} else if(companyData.data.status == 2) {
					$(".in_step").addClass("in_step_04");
					$container.find("#add-form").html($(".template.InStep4").doT({
						data: companyData.data
					}));
					$container.on("click", ".apply-btn", function() {
						var $this = $(this);
						var type = $this.attr("applyType");
						$.ajax({
							url: "company/apply",
							type: "POST",
							data: {
								companyId: companyData.data.id,
								type: type
							},
							success: function(data) {
								if(data.status == 0) {
								}
							},
							error: function(err) {}
						});
					});
				} else if(companyData.data.status == 1) {
					$(".in_step").addClass("in_step_03");
					$container.find("#add-form").html($(".template.InStep3").doT());
				}  else if(companyData.data.status == 0 || companyData.data.status == 3) {
					$(".in_step").addClass("in_step_02");
					$container.find("#add-form").html($(".template.InStep2").doT({
						status: status
					}));
					var $form = $container.find("form");
					//$k.util.fileinput($form.find('#protocol'));
					$k.util.fileinput($form.find('#attachment'));
					$form.
					bootstrapValidator({
				        feedbackIcons: {/*input状态样式图片*/
				            valid: 'glyphicon glyphicon-ok',
				            invalid: 'glyphicon glyphicon-remove',
				            validating: 'glyphicon glyphicon-refresh'
				        },
				        fields: {/*验证：规则*/
				        	license: {//验证input项：验证规则
				                 validators: {
				                     notEmpty: {//非空验证：提示消息
				                         message: '入驻类型不能为空'
				                     }
				                 }
				        	},
				        	attachment: {
				        		validators: {
				                    notEmpty: {
				                        message: '请上传营业执照'
				                    }
				                }
				        	}
				        }
					});
				}
				
				$container
				.on("click", "#addCompany-btn", function() {
					var bootstrapValidator = $container.find("form").data('bootstrapValidator').validate();
					if(bootstrapValidator.isValid()) {
						var formData = new FormData($container.find("form")[0]); 
						formData.append("userId", userId);
						$.ajax({
							url: "company/add",
							type: "POST",
							data: formData,
							async: false, 
				          	cache: false, 
				          	contentType: false, 
				          	processData: false,  
				 			success: function(data) {
								if(data.status == 0) {
									$(".in_step").addClass("in_step_02");
									$container.find(".form-container form").html($(".template.InStep2").doT({status: "-1"}));
									var $form = $container.find("form");
									//$k.util.fileinput($form.find('#protocol'));
									$k.util.fileinput($form.find('#attachment'));
									$form.
									bootstrapValidator({
								        feedbackIcons: {/*input状态样式图片*/
								            valid: 'glyphicon glyphicon-ok',
								            invalid: 'glyphicon glyphicon-remove',
								            validating: 'glyphicon glyphicon-refresh'
								        },
								        fields: {/*验证：规则*/
								        	license: {//验证input项：验证规则
								                 validators: {
								                     notEmpty: {//非空验证：提示消息
								                         message: '入驻类型不能为空'
								                     }
								                 }
								        	},
								        	attachment: {
								        		validators: {
								                    notEmpty: {
								                        message: '请上传营业执照'
								                    }
								                }
								        	}
								        }
									});
								}
							},
							error: function(e) {}
						});
					} else {
						return;
					}
				})
				.on("click", "#uploadData-btn", function() {
					var bootstrapValidator = $container.find("form").data('bootstrapValidator').validate();
					if(bootstrapValidator.isValid()) {
						var formData = new FormData($container.find("form")[0]); 
						formData.append("companyId", companyData.data.id);
						$.ajax({
							url: "company/uploadData",
							type: "POST",
							data: formData,
							async: false, 
				          	cache: false, 
				          	contentType: false, 
				          	processData: false,  
				 			success: function(data) {
								if(data.status == 0) {
									$(".in_step").addClass("in_step_03");
									$container.find("#add-form").html($(".template.InStep3").doT());
								}
							},
							error: function(e) {}
						});
					} else {
						return;
					}
				});
			}
		}
	});
	
})();
</script>
</html>