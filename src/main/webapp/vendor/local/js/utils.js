;(function() {
	
	$k.util.encrptByDES = function(pwd) {
		var key = new Date().format("yyyymmdd");
		var keyHex = CryptoJS.enc.Utf8.parse(key);
	    var encrypted = CryptoJS.DES.encrypt(pwd, keyHex, {
	        mode: CryptoJS.mode.ECB,
	        padding: CryptoJS.pad.Pkcs7
	    });
	    return encrypted.ciphertext.toString(CryptoJS.enc.Base64);
	}
	
	$k.util.decryptByDES = function(pwd) {
		var key = new Date().format("yyyyMMdd");
		var keyHex = CryptoJS.enc.Utf8.parse(key);
		var decrypted = CryptoJS.DES.decrypt({
		    ciphertext: CryptoJS.enc.Base64.parse(pwd)
		}, keyHex, {
		    mode: CryptoJS.mode.ECB,
		    padding: CryptoJS.pad.Pkcs7
		});
		return decrypted.toString(CryptoJS.enc.Utf8);
	}
	
	$k.util.getDateString = function(data) {
		if (data) {
			if (data.$data) {
				return Date.init(data).format("yyyy-mm-dd HH:MM"); 
			}
			return Date.init(data).format("yyyy-mm-dd HH:MM");
		}
		return "";
	}
	
	$k.util.getDateString2 = function(data) {
		if (data) {
			if (data.$date) {
				return Date.init(data.$date).format("yyyy-mm-dd");
			}
			return Date.init(data).format("yyyy-mm-dd");
		}
		return "";
	};
	
	$k.util.fileinput = function($input, parm) {
		var options = $.extend({
			language: 'zh', // 显示移除按钮设置语言
			maxFileCount: 1,
		    allowedFileExtensions : [ 'jpg', 'png', 'gif' ],
		    showUpload: false, // 是否显示上传按钮
		    showRemove: false, // 显示显示移除按钮
		    showPreview : true, // 是否显示预览
		   // showCaption: false,//是否显示标题
		    browseClass: "btn btn-hm", //按钮样式     
		    dropZoneEnabled: false,// 是否显示拖拽区域
		}, parm);
		$input.fileinput(options);
	}
	
	$k.util.fileinputDisabled = function($input, parm) {
		var options = $.extend({
			language: 'zh', //设置语言
			maxFileCount: 1,
		    allowedFileExtensions : [ 'jpg', 'png', 'gif' ],
		    showUpload: false, //是否显示上传按钮
		    showPreview : true,
		    dropZoneEnabled: true,//是否显示拖拽区域
		    showUpload: false, // 是否显示上传按钮
			showRemove: false, // 显示移除按钮
			showCaption: false, // 是否显示标题
		}, parm);
		$input.fileinput(options);
		$input.closest('.file-input').find('.btn-file, .fileinput-remove').hide();
	}
	
	$k.util.dataTable = function($table, parm) {
		var defaultParm = $.extend( $.fn.dataTable.defaults, {
			"lengthChange": false,
			"responsive": true,
			//"ordering": false,
			//"searching": false,
			"autoWidth": false,
			"info": false,
			"displayLength": 10,
			//"paging": false,
			"language": {
				"emptyTable": "暂无数据！",
				"zeroRecords": "没有找到记录！",
				"search": "搜索:",
				"paginate": {
					"first": "首页",
					"last": "最后一页",
					"next": "下一页",
					"previous": "上一页",
				}
			},
			"columnDefs": [ 
			    { "orderable": false , "targets": [ 0 ]}
			],
		}, parm);
		
		var ret = $table.DataTable(defaultParm);
		return ret;
	}
	
	$k.util.getInfoId = function($a) {
		return $a.closest('.table-tr').attr('id');
	}
	
	$k.util.disabled = function($dialog) {
		// hide footer button
		$dialog.find('.modal-footer').hide();
		
		// input select textarea disabled
		$dialog.find('input').attr('disabled', 'disabled');
		$dialog.find('select').attr('disabled', 'disabled');
		$dialog.find('textarea').attr('disabled', 'disabled');
		
		// ueditor
		$dialog.find('.btn-toolbar').hide();
		$dialog.find('#editor').attr('contenteditable', false);
		
		// select 
		$dialog.find('.btn-default').attr('disabled', 'disabled');
	}
	
	$k.util.getIds = function($tar) {
		var ids = new Array();
		
		$tar.find('.check').each(function() {
			if ($(this).prop("checked") == true) {
				var $tr = $(this).closest(".table-tr");
				ids.push($tr.attr('id'));
			}
		});
		
		return ids.toString();
	}
	
	$k.util.getRoleList = function(options) {
		this.options = $.extend({}, DEFAULTS, options || {});
		var DEFAULTS = {
			success: function() {},
			error: function() {},
		};
		
		$.ajax({
			url: "role/list",
			type: "POST",
			success: function(data) {
				$.Callbacks().add(options.success).fire(data);
			},
			error: function(err) {
				$.Callbacks().add(options.error).fire(err);
			} 
		});
	};
	
	$k.util.getAreaList = function(options) {
		this.options = $.extend({}, DEFAULTS, options || {});
		var DEFAULTS = {
			success: function() {},
			error: function() {},
		};
		
		$.ajax({
			url: "area/list",
			type: "POST",
			success: function(data) {
				$.Callbacks().add(options.success).fire(data);
			},
			error: function(err) {
				$.Callbacks().add(options.error).fire(err);
			} 
		});
	};
	
	$k.util.filter = function() {
		$(".select-dl dd").click(function () {
			var $this = $(this);
			if($this.hasClass("selected")) {
				return;
			}
			var selectAttr = $(this).closest("dl").attr("select");
			$this.closest("dl").find(".select-all").removeClass("selected");
			$this.addClass("selected");
			if ($this.hasClass("select-all")) {
				$this.siblings().removeClass("selected");
				$("dd[select='"+ selectAttr +"']").remove();
			} else {
				var copyThis = $(this).clone();
				$(".select-result dl").append(copyThis.attr("select", selectAttr));
			}
		});
		
		$(".select-result").on("click", ".selected", function () {
			var $this = $(this);
			var selectAtrr = $(this).attr("select");
			$this.remove();
			if($(".select-result").find("[select='"+ selectAtrr +"']").length == 0) {
				$("dl[select='"+ selectAtrr +"']").find(".select-all").addClass("selected");
			}
			$("dl[select='"+ selectAtrr +"']").find("dd[data-val="+$this.attr("data-val")+"]").removeClass("selected");
			if ($(".select-result dd").length > 1) {
				$(".select-no").hide();
			} else {
				$(".select-no").show();
			}
		});
		$(".select dd").on("click", function () {
			if ($(".select-result dd").length > 1) {
				$(".select-no").hide();
			} else {
				$(".select-no").show();
			}
		});
		$(".select").on("click", ".show-more", function () {
			$(this).closest("li").addClass("expand-mode");
			$(this).addClass("hidden");
			$(this).next().removeClass("hidden");
		});
		$(".select").on("click", ".show-less", function () {
			$(this).closest("li").removeClass("expand-mode");
			$(this).addClass("hidden");
			$(this).prev().removeClass("hidden");
		});
	}
	
	$k.util.getRequestParam = function(paras) {
		/** 从url中获取参数 **/
		var url = location.href;
		var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
		var paraObj = {};
		for ( var i = 0; j = paraString[i]; i++) {
			paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j
					.indexOf("=") + 1, j.length);
		}
		var returnValue = paraObj[paras.toLowerCase()];
		if (typeof (returnValue) == "undefined") {
			return "";
		} else {
			return returnValue;
		}
	}
	
	$k.util.getCompanyByUserId = function(userId, options) {
		this.options = $.extend({}, DEFAULTS, options || {});
		var DEFAULTS = {
			success: function() {},
			error: function() {},
		};
		$.ajax({
			url: "company/findByUserId",
			type: "POST",
			data: {userId: userId},
			success: function(data) {
				$.Callbacks().add(options.success).fire(data);
			},
			error: function(err) {
				$.Callbacks().add(options.error).fire(err);
			} 
		});
	}
	
	$k.util.getClazz = function(subClazz) {
		var clazz = subClazz.toString().substr(0, 1);
		return clazz;
	}
	
	$k.util.cutString = function(str, len) {
		//length属性读出来的汉字长度为1
		 if(str.length*2 <= len) {
		  return str;
		 }
		 var strlen = 0;
		 var s = "";
		 for(var i = 0;i < str.length; i++) {
			  s = s + str.charAt(i);
			  if (str.charCodeAt(i) > 128) {
			   strlen = strlen + 2;
			   if(strlen >= len){
			    return s.substring(0,s.length-1) + "...";
			   }
			  } else {
			   strlen = strlen + 1;
			   if(strlen >= len){
			    return s.substring(0,s.length-2) + "...";
			   }
			  }
		 }
		 return s;
	}
	
	$k.util.getAllValue = function(constant) {
		var list = [];
		$.each(constant, function(index, obj) {
			list.push(obj.value);
		});
		return list.join('-');
	}
	
})();