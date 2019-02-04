<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>申请充值</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#inputForm").validate({
                submitHandler: function (form) {

                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

        });

    </script>

</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/tools/recharge/">充值列表</a></li>
    <shiro:hasPermission name="game.recharge.apply">
        <li class="active"><a
                href="${ctx}/tools/recharge/form?id=${recharge.id}">${not empty recharge.id?'按角色名修改':'按角色名申请'}充值</a>
        </li>
        <li>
            <a href="${ctx}/tools/recharge/roleIdRechargeForm?id=${recharge.id}">${not empty recharge.id?'按角色ID修改':'按角色ID申请'}充值</a>
        </li>
    </shiro:hasPermission>
</ul>
<br/>
<div class="alert alert-info">
    <strong>注意:</strong>
    这里需要先选择一个服务器，因为这里的玩家需要对应服务器才可充值成功！！！<br/>
    提示1：输入的角色数量和当前数量不一致讲无法充值成功，检查是否有重名或者有玩家不在当前服<br/>
    提示2：当前服查询不到玩家，则表明输入的角色不在当前服中
</div>
<hr class="bs-docs-separator">
<form:form id="inputForm" modelAttribute="recharge" action="${ctx}/tools/recharge/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <tags:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">充值类型:</label>
        <div class="controls">
            <form:select path="rechargeType">
                <form:options items="${fns:getDictList('recharge_type')}" itemLabel="label" itemValue="value"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">角色名:</label>
        <div class="controls">
            <form:textarea path="roleNames" htmlEscape="false" rows="3" maxlength="200" class="input-xxlarge required"/>
            <span class="help-inline label label-info">多个角色以换行分隔</span>
        </div>

    </div>
    <div class="control-group">
        <label class="control-label">货币类型:</label>
        <div class="controls">
            <form:select path="moneyType">
                <form:options items="${fns:getDictList('money_type')}" itemLabel="label" itemValue="value"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">充值数量:</label>
        <div class="controls">
            <input id="moneyNum" name="moneyNum" maxlength="50" value="0" class="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注:</label>
        <div class="controls">
            <form:textarea path="remark" htmlEscape="false" rows="3" maxlength="100" class="input-xxlarge"/>
        </div>
    </div>


    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>