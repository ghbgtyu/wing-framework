<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>平台管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>


</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/tools/gamePlatform/">平台列表</a></li>
    <li class="active"><a
            href="${ctx}/tools/gamePlatform/form?id=${gamePlatform.id}">平台${not empty gamePlatform.id?'修改':'添加'}</a>
    </li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="gamePlatform" action="${ctx}/tools/gamePlatform/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <tags:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">平台编号:</label>
        <div class="controls">
            <form:input path="pid" htmlEscape="false" maxlength="50" class="required"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">平台名:</label>
        <div class="controls">
            <input id="oldName" name="oldName" type="hidden" value="${gamePlatform.name}">
            <form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">登陆签名</label>
        <div class="controls">
            <form:input path="signKey" htmlEscape="false" maxlength="50" class="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">描述信息:</label>
        <div class="controls">
            <form:textarea path="description" htmlEscape="false" rows="3" maxlength="100" class="input-xlarge"/>
        </div>
    </div>

    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>