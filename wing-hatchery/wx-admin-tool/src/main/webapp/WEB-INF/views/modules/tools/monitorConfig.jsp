<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>用户管理</title>
    <meta name="decorator" content="default"/>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/tools/monitorConfig/monitorConfig">预警监控</a></li>
</ul>
<br/>
<form:form id="searchForm" action="${ctx}/tools/monitorConfig/addMonitorConfig" method="post" class="form-horizontal">
    <tags:message content="${message}"/>
    <input value="${monitorConfig.id}" name="currentId" type="hidden"/>
    <div class="control-group">
        <label class="control-label">登入预警天数:</label>
        <div class="controls">
            <input name="warnLogin" value="${monitorConfig.warn_login}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">支付预警天数:</label>
        <div class="controls">
            <input name="warnCharge" value="${monitorConfig.warn_charge}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label"></label>
        <div class="controls">
            <input type="submit" value="提交"/>
        </div>
    </div>
</form:form>
</body>
</html>