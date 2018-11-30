var BASE;


$(document).ready(function () {
    //绑定复选框(全选、取消全选)事件
    $("#checkAllOrNot").click(function () {
        var checked = this.checked;
        $(":checkbox[disabled!='disabled']").each(function () {
            $(this).attr("checked", checked);
        });
    });

    //绑定点击复选框，则更改tr背景颜色的事件
    //$(":checkbox[name='recordIds']").each(function (i) {
    //    $(this).click(function () {
    //        var currentTR = $(this).parents("tr");
    //        currentTR.css("background-color", this.checked ? "#F0F0F0" : "#FFF");
    //    });
    //});
});

// 引入js和css文件
function include(id, path, file){
	if (document.getElementById(id)==null){
        var files = typeof file == "string" ? [file] : file;
        for (var i = 0; i < files.length; i++){
            var name = files[i].replace(/^\s|\s$/g, "");
            var att = name.split('.');
            var ext = att[att.length - 1].toLowerCase();
            var isCSS = ext == "css";
            var tag = isCSS ? "link" : "script";
            var attr = isCSS ? " type='text/css' rel='stylesheet' " : " type='text/javascript' ";
            var link = (isCSS ? "href" : "src") + "='" + path + name + "'";
            document.write("<" + tag + (i==0?" id="+id:"") + attr + link + "></" + tag + ">");
        }
	}
}

// 打开一个窗体
function windowOpen(url, name, width, height){
	var top=parseInt((window.screen.height-height)/2,10),left=parseInt((window.screen.width-width)/2,10),
		options="location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,"+
		"resizable=yes,scrollbars=yes,"+"width="+width+",height="+height+",top="+top+",left="+left;
	window.open(url ,name , options);
}

// 显示加载框
function loading(mess){
	top.$.jBox.tip.mess = null;
	top.$.jBox.tip(mess,'loading',{opacity:0});
}

// 确认对话框
function confirmx(mess, href){
	top.$.jBox.confirm(mess,'系统提示',function(v,h,f){
		if(v=='ok'){
			loading('正在提交，请稍等...');
			location = href;
		}
	},{buttonsFocus:1});
	top.$('.jbox-body .jbox-icon').css('top','55px');
	return false;
}


function ajaxRequest(mess, url, params){
    top.$.jBox.confirm(mess,'系统提示',function(v,h,f){
        if(v=='ok'){
            _remoteCall(url,params,function(result){
                if(result.success){
                    tips(result.data)
                }
            })
        }
    },{buttonsFocus:1});
    top.$('.jbox-body .jbox-icon').css('top','55px');
    return false;
}

function tips(msg){
    top.$.jBox.tip(msg, 'success');
}

$(document).ready(function() {
	//所有下拉框使用select2
	$("select").select2();
	$('.fancybox').fancybox();
//    $("#inputForm").validate();
});

function _remoteCall(url, params, callback) {
    $.ajax({
        type : 'POST',
        url: url,
        dataType: 'json',
        data:params,
        before:function(){
          loading("正在提交请稍等...")
        },
        success:function(data){
            callback(data)
        }
    })
}


function page(n,s){
    $("#pageNo").val(n);
    $("#pageSize").val(s);
//    $("#searchForm").attr("action",action);
    $("#searchForm").submit();
    return false;
}


function submitCheckedRecordIds(url){
    var isChecked = false;
    $("input[name='recordIds']").each(function () {
        if (this.checked) {
            isChecked = true;
        }
    });
    if (isChecked == false) {
        tips("至少选中一个数据!");
        return;
    }
    top.$.jBox.confirm("确定?","系统提示",function(v,h,f){
        if(v=="ok"){
            $("#tableForm").attr("action",url);
            $("#tableForm").submit();
        }
    },{buttonsFocus:1});
    top.$('.jbox-body .jbox-icon').css('top','55px');

}

//ajax 提交验证参数
function submitCheckedRecordIdsAjax(url){
    var isChecked = false;
    $("input[name='recordIds']").each(function () {
        if (this.checked) {
            isChecked = true;
        }
    });
    if (isChecked == false) {
        tips("至少选中一个数据!");
        return;
    }
    top.$.jBox.confirm("确定?","系统提示",function(v,h,f){
        if(v=="ok"){
        	_remoteCall(url,$('#tableForm').serialize(),function(result){
        		   if(result.success){
        			   top.$.jBox.tip(result.data);

                   }else{
                	   top.$.jBox.tip(result.data);
                   }
        	});
        }
    },{buttonsFocus:1});
    top.$('.jbox-body .jbox-icon').css('top','55px');

}




function submitCheckedRecordIdsWithPrompt(url){
    var isChecked = false;
    $("input[name='recordIds']").each(function () {
        if (this.checked) {
            isChecked = true;
        }
    });
    if (isChecked == false) {
        tips("至少选中一个数据!");
        return;
    }
    top.$.jBox.confirm("确定?","系统提示",function(v,h,f){
        if(v=="ok"){
            var html = "<div style='padding:10px;'>理由：<input type='text' id='reason' name='reason' class='required' /></div>";
            var submit = function (v, h, f) {
                if (f.reason == '') {
                    top.$.jBox.tip("请输入理由 !!!", 'error', { focusId: "reason" }); // 关闭设置 reason 为焦点
                    return false;
                }

                var form = $("#tableForm");
                form.attr('action', url);
                var msg = $("#msg").val(encodeURI(f.reason));
                form.attr('msg', msg);
                form.submit();

                return true;
            };

            top.$.jBox(html, { title: "输入理由", submit: submit });

        }
    },{buttonsFocus:1});
    top.$('.jbox-body .jbox-icon').css('top','55px');

}


function doExport(action){
    top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
        if(v=="ok"){
            $("#searchForm").attr("action",action);
            $("#searchForm").submit();
        }
    },{buttonsFocus:1});
    top.$('.jbox-body .jbox-icon').css('top','55px');
}

//多选服务器弹窗，去掉了合过服的服
function openSeverDialog(){
    top.$.jBox.open("iframe:"+BASE+"/tools/gameArea/openGameServerDialog", "选择游戏服务器(多选)",1000,$(top.document).height()-240,{
        buttons:{"确定":"ok", "关闭":true}, bottomText:"多选服务器弹窗。",submit:function(v, h, f){
            if (v=="ok"){
                h.find("iframe")[0].contentWindow.sure();
                var selectedGameServerId = h.find("iframe")[0].contentWindow.selectedGameServerIds;
                $("#serverIds").val(selectedGameServerId);
                return true;
            }
        }, loaded:function(h){
            $(".jbox-content", top.document).css("overflow-y","hidden");
        }
    });
}


function selectSingleServer(){
    top.$.jBox.open("iframe:"+BASE+"/tools/gameArea/selectSingleGameServer", "选择游戏服务器(单选)",810,$(top.document).height()-240,{
        buttons:{"确定":"ok", "关闭":true}, bottomText:"通过选择平台，查询出游戏服务器。",submit:function(v, h, f){
            var selectedGameServerId = h.find("iframe")[0].contentWindow.selectedGameServerId;
            var selectedGameServerName = h.find("iframe")[0].contentWindow.selectedGameServerName;
            var selectedGamePlatformName = h.find("iframe")[0].contentWindow.selectedGamePlatformName;
            if (v=="ok"){

                $("#serverIds").val(selectedGameServerId);
                $("#platformName").val(selectedGamePlatformName);
                return true;
            }
        }, loaded:function(h){
            $(".jbox-content", top.document).css("overflow-y","hidden");
        }
    });
}

function openGameUserDialog(){
    top.$.jBox.open("iframe:"+BASE+"/game/role/gameRoleDialog", "游戏角色列表",810,$(top.document).height()-240,{
        buttons:{"确定":"ok", "关闭":true},bottomText:"查询条件至少输入一项才可以查询",submit:function(v, h, f){

            if (v=="ok"){

                h.find("iframe")[0].contentWindow.sure();
                var roleIds = h.find("iframe")[0].contentWindow.roleIds;
                var roleNames = h.find("iframe")[0].contentWindow.roleNames;

                $("#receiverNames").val(roleNames);
                $("#receiverUserIds").val(roleIds);

                return true;
            }
        }, loaded:function(h){
            $(".jbox-content", top.document).css("overflow-y","hidden");
        }
    });
}


function openGoodsDialog(targetId){
    top.$.jBox.open("iframe:"+BASE+"/tools/gameEmail/goodsDialog?targetId="+targetId, "物品列表",1200,$(top.document).height()-240,{
        buttons:{"确定":"ok", "关闭":true},bottomText:"查询条件必须填写",submit:function(v, h, f){

            if (v=="ok"){

                var goodsId = h.find("iframe")[0].contentWindow.goodsId;
                var goodsName = h.find("iframe")[0].contentWindow.goodsName;

                $("#" + targetId).val(goodsName);
                $("#id" + targetId).val(goodsId);


                return true;
            }
        }, loaded:function(h){
            $(".jbox-content", top.document).css("overflow-y","hidden");
        }
    });
}


function info(data){
    top.$.jBox.info(data, '内容');
}


//导出xls文件
function exportXls(url) {
    if (url == null || url == "") {
        url = "xls";
    }
    var oldUrl = $("form:first").attr("action");
    $("form:first").attr("action", url);
    $("form:first").submit();
    $("form:first").attr("action", oldUrl);
}
