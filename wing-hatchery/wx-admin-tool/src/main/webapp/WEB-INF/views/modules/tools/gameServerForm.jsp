<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>游戏服管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>


</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/tools/gameServer/">游戏服列表</a></li>
    <li class="active"><a href="${ctx}/tools/gameServer/form?id=${gameServer.id}">${not empty gamePlatform.id?'修改':'添加'}游戏服</a>
    </li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="gameServer" action="${ctx}/tools/gameServer/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <tags:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">服务器编号:</label>
        <div class="controls">
            <form:input path="serverId" htmlEscape="false" maxlength="50" class="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">服务器名称:</label>
        <div class="controls">
            <form:input path="serverName" htmlEscape="false" maxlength="50" class="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">描述信息:</label>
        <div class="controls">
            <form:textarea path="description" htmlEscape="false" rows="3" maxlength="100" class="input-xlarge"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">所属平台:</label>
        <div class="controls">
            <form:select path="gamePlatform.id">
                <form:options items="${fns:getGamePlatformList()}" itemLabel="name" itemValue="id" htmlEscape="false"/>
            </form:select>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">是否测试服:</label>
        <div class="controls">
            <form:select path="isTest">
                <form:option value="0">否</form:option>
                <form:option value="1">是</form:option>
            </form:select>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">服务器状态:</label>
        <div class="controls">
            <form:select path="serverStatus">
                <form:option value="1">开启</form:option>
                <form:option value="0">关闭</form:option>
            </form:select>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">是否合服:</label>
        <div class="controls">
            <form:select path="isHefu">
                <form:option value="0">否</form:option>
                <form:option value="1">是</form:option>
            </form:select>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">游戏数据库:</label>
        <div class="controls">
            <form:input path="gameDbUrl" htmlEscape="false" maxlength="150" class="required" cssClass="input-xxlarge"/>
            <a class="alert alert-danger">*(格式:192.168.1.1:3306/dbName;username;passwd)</a>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">日志数据库:</label>
        <div class="controls">
            <form:input path="LogDbUrl" htmlEscape="false" maxlength="150" class="required" cssClass="input-xxlarge"/>
            <a class="alert alert-danger">*(格式:192.168.1.1:3306/dbName;username;passwd)</a>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">游戏入口:</label>
        <div class="controls">
            <form:input path="gateUrl" htmlEscape="false" maxlength="150" class="required" cssClass="input-xxlarge"/>
            <a class="alert alert-danger">*(例:http://192.168.1.111:8080/servlet)</a>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">接口地址:</label>
        <div class="controls">
            <form:input path="gameServerRemoteUrl" htmlEscape="false" maxlength="150" class="required"
                        cssClass="input-xxlarge"/>
            <a class="alert alert-danger">*(例:http://192.168.1.111:9999)</a>
        </div>
    </div>


    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>