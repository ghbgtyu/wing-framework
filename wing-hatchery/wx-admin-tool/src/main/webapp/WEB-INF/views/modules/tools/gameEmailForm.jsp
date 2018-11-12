<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新增公告</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
    <script type="text/javascript">

        $(document).ready(function() {
            $("#title").focus();
            $("#inputForm").validate({
                submitHandler: function(form){

                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

        });

        function toggleTrReceiverNames(){
            if ($("#isGlobal").val() == "1") {
                $('#trReceiverNames').hide();
                $('#receiverNames').val("");
            } else {
                $('#trReceiverNames').show();
            }
            $("#serverIds").val("");
        }

        function openServer(){
            $("#serverIds").val("");
            $("#receiverNames").val("");
            if ($("#isGlobal").val() == "1") {
                openSeverDialog();
            } else {
                selectSingleServer();
            }
        }


        function openGameUser(){
            var serverId =$("#serverIds").val();
            if (serverId == "") {
                alert("Please select the server");
                return;
            }

            openGameUserDialog(serverId);
        }


        function openGoods(targetId){
            openGoodsDialog(targetId);
        }

    </script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/tools/gameEmail/">邮件列表</a></li>
		<shiro:hasPermission name="game.email.edit">
			<li class="active"><a href="${ctx}/tools/gameEmail/form?id=${gameEmail.id}">${not empty gameEmail.id?'修改':'申请'}邮件</a></li>
		</shiro:hasPermission>
        <shiro:hasPermission name="game.email.batchadd">
            <li><a href="${ctx}/tools/gameEmail/batchAdd">申请补偿</a></li>
        </shiro:hasPermission>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="gameEmail" action="${ctx}/tools/gameEmail/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>

        <div class="control-group">
            <label class="control-label">发放方式:</label>
            <div class="controls">
                <select id="isGlobal" name="isGlobal" onchange="toggleTrReceiverNames()">
                    <option value="1">全服发送</option>
                    <option value="0">指定用户发送</option>
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">服务器:</label>
            <div class="controls">
                <input id="serverIds" name="serverIds" readonly/><input type="button" class="btn btn-primary" value="选择服务器" onclick="openServer()"></button>
            </div>
        </div>

        <div class="control-group" style="display: none" id="trReceiverNames">
            <label class="control-label">选择用户:</label>
            <div class="controls">
                <button type="button" onclick="openGameUser()">选择用户</button><br>
                <textarea id="receiverNames" rows="3" name="receiverNames" class="input-xxlarge required"></textarea>
                <span style="color:#FF003A;"> * </span>

                <textarea id="receiverUserIds" style="display:none" name="receiverUserIds" class="required"></textarea>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">标题:</label>
            <div class="controls">
                <form:input path="title" htmlEscape="false"  class="input-xxlarge required"/>
            </div>
        </div>
		<div class="control-group">
			<label class="control-label">内容:</label>
			<div class="controls">
                <form:textarea path="content" htmlEscape="false" rows="3"  class="input-xxlarge required"/>
			</div>
		</div>
        <div class="control-group">
            <label class="control-label">附加金币数量:</label>
            <div class="controls">
                <form:input path="jb" htmlEscape="false" cssClass="input-large"></form:input><span class="help-inline">(上线:9亿)</span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">附加元宝数量:</label>
            <div class="controls">
                <form:input path="yb" htmlEscape="false" cssClass="input-large"></form:input><span class="help-inline">(上线:9亿)</span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">延迟发送小时:</label>
            <div class="controls">
                <form:input path="delayHours" htmlEscape="false" cssClass="input-large"></form:input>
            </div>
        </div>

        <div class="control-group">

            <label class="control-label">附加物品列表:</label>
            <div class="controls">
                <input onclick="openGoodsDialog(0)" id="0" readonly="readonly"> <input type="hidden" name="goodsList[0].id" id="id0">
                <select name="goodsList[0].binding" >
                    <option value="1" >绑定</option>
                    <option value="0" >不绑定</option>
                </select>
                数量:<input name="goodsList[0].count" id="count0"> (可选)
                有效期:<input name="goodsList[0].expireTime" id="expireTime0" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss'})">(可选)<br/>

                <input onclick="openGoodsDialog(1)" id="1" readonly="readonly"> <input type="hidden" name="goodsList[1].id" id="id1">
                <select name="goodsList[1].binding" >
                    <option value="1" >绑定</option>
                    <option value="0" >不绑定</option>
                </select>
                数量:<input name="goodsList[1].count" id="count1"> (可选)
                有效期:<input name="goodsList[1].expireTime" id="expireTime1" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss'})">(可选)<br/>

                <input onclick="openGoodsDialog(2)" id="2" readonly="readonly"> <input type="hidden" name="goodsList[2].id" id="id2">
                <select name="goodsList[2].binding" >
                    <option value="1" >绑定</option>
                    <option value="0" >不绑定</option>
                </select>
                数量:<input name="goodsList[2].count" id="count2"> (可选)
                有效期:<input name="goodsList[2].expireTime" id="expireTime2" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss'})">(可选)<br/>

                <input onclick="openGoodsDialog(3)" id="3" readonly="readonly"> <input type="hidden" name="goodsList[3].id" id="id3">
                <select name="goodsList[3].binding" >
                    <option value="1" >绑定</option>
                    <option value="0" >不绑定</option>
                </select>
                数量:<input name="goodsList[3].count" id="count3"> (可选)
                有效期:<input name="goodsList[3].expireTime" id="expireTime3" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss'})">(可选)<br/>

                <input onclick="openGoodsDialog(4)" id="4" readonly="readonly"> <input type="hidden" name="goodsList[4].id" id="id4">
                <select name="goodsList[4].binding" >
                    <option value="1" >绑定</option>
                    <option value="0" >不绑定</option>
                </select>
                数量:<input name="goodsList[4].count" id="count4"> (可选)
                有效期:<input name="goodsList[4].expireTime" id="expireTime4" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss'})">(可选)<br/>
            </div>
        </div>

		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>

</body>
</html>