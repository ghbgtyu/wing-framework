<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>


<html>
<head>
    <title>合同创建</title>
    <meta name="decorator" content="default"/>


</head>

<script>


</script>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/bus/file/list">合同处理列表</a></li>
    <li class="active"><a href="${ctx}/bus/file/create">合同创建</a></li>

</ul>

<form:form id="inputForm" modelAttribute="busFile" action="${ctx}/bus/file/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <tags:message content="${message}"/>


    <div class="control-group">
        <label class="control-label">合同号:</label>
        <div class="controls">

            <form:input path="fileId" htmlEscape="false" maxlength="50" class="required fileId"/>
        </div>
    </div>


    <div class="control-group">
        <label class="control-label">合同标题:</label>
        <div class="controls">

            <form:input path="content" htmlEscape="false" maxlength="50" class="required content"/>
        </div>
    </div>


    <div class="control-group">
        <label class="control-label">备注:</label>
        <div class="controls">
            <form:textarea path="uploadDesc" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
        </div>
    </div>


    <div class="form-actions">
        <shiro:hasPermission name="bus:file:manager"><input id="btnSubmit" class="btn btn-primary" type="submit"
                                                            value="创 建"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>
