<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>回复玩家</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#title").focus();
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
    <li class="active"><a href="${ctx}/tools/feedback/feedbackForm/">回复玩家</a></li>
</ul>
<br/>
<form id="inputForm" action="${ctx}/tools/feedback/send" method="post" class="form-horizontal">
    <input hidden="hidden" style="display: none" id="id" name="id" value="${map.id}">
    <input hidden="hidden" style="display: none" id="roleId" name="roleId" value="${map.roleId}">
    <tags:message content="${message}"/>

    <div class="control-group">
        <label class="control-label">角色名:</label>
        <div class="controls">
            <input type="text" name="roleName" id="roleName" readonly value="${fns:urlDecode(map.roleName)}"
                   class="input-xlarge required"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">标题:</label>
        <div class="controls">
            <input type="text" name="title" class="input-xlarge required"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">内容:</label>
        <div class="controls">
            <textarea id="content" rows="3" name="content" class="input-xxlarge required"></textarea>
        </div>
    </div>

    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form>

</body>
</html>