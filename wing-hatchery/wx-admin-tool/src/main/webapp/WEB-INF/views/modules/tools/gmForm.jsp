<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>新增公告</title>
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

        function openServer() {

            selectSingleServer();
        }

    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/game/role/gmList/">指导员列表</a></li>
    <shiro:hasPermission name="game.gm.edit">
        <li class="active"><a
                href="${ctx}/game/role/gmForm?id=${paramMap.roleName}">${not empty paramMap.roleName?'修改':'添加'}指导员</a>
        </li>
    </shiro:hasPermission>
    <li><a href="${ctx}/game/role/gmPublish">禁言封号列表</a></li>
</ul>
<br/>
<form id="inputForm" action="${ctx}/game/role/saveGm" method="post" class="form-horizontal">
    <input hidden="hidden" style="display: none" id="id" name="id" value="${paramMap.id}">
    <tags:message content="${message}"/>

    <div class="control-group">
        <label class="control-label">服务器:</label>
        <div class="controls">
            <input id="serverIds" name="serverIds" value="${paramMap.serverIds}" readonly/><input type="button"
                                                                                                  class="btn btn-primary"
                                                                                                  value="选择服务器"
                                                                                                  onclick="openServer()"></button>
            <input style="display: none" id="platformName" name="platformName" value="${paramMap.platformName}"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">角色名:</label>
        <div class="controls">
            <input type="text" name="roleName" id="roleName" value="${paramMap.roleName}"
                   class="input-xlarge required"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">类型:</label>
        <div class="controls">
            <select id="roleType" name="roleType">
                <c:forEach items="${fns:getDictList('role_type')}" var="roleType">
                    <option value="${roleType.value}" name="roleType">${roleType.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form>

</body>
</html>