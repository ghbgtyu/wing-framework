<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>月营收预估</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#content").focus();
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
    <li><a href="${ctx}/tools/config/list">月营收预估</a></li>
    <li class="active"><a href="${ctx}/tools/config/form">新增月营收预估</a></li>
</ul>
<br/>
<form:form id="inputForm" action="${ctx}/tools/config/save" method="post" class="form-horizontal"
           enctype="multipart/form-data">
    <tags:message content="${message}"/>

    <div class="control-group">
        <label class="control-label">月份:</label>
        <div class="controls">
            <input name="month" style="width: 216px" readonly="readonly" value="${mothRevenue.month}"
                   onfocus="WdatePicker({dateFmt:'yyyy-MM'})"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">新注册:</label>
        <div class="controls">
            <input type="hidden" name="id" value="${id}"/>
            <input type="text" id="newUser" name="newUser" value="${mothRevenue.newUser }"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">老用户:</label>
        <div class="controls">
            <input type="text" id="oldUser" name="oldUser" value="${mothRevenue.oldUser }"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">月活跃:</label>
        <div class="controls">
            <input type="text" id="active" name="active" value="${mothRevenue.active }"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">充值人数:</label>
        <div class="controls">
            <input type="text" id="payNum" name="payNum" value="${mothRevenue.chargeNum }"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">收入:</label>
        <div class="controls">
            <input type="text" id="income" name="income" value="${mothRevenue.income }"/>
        </div>
    </div>

    <div class="form-actions">
        <c:if test="${empty id }">
            <input type="hidden" name="type" value="新增"/>
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/></c:if>
        <c:if test="${not empty id }">
            <input type="hidden" name="type" value="修改"/>
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="修改"/></c:if>
        &nbsp;
        <input id="btnCancel" class="btn" type="button" value="返回" onclick="history.go(-1)"/>
    </div>
</form:form>

</body>
</html>