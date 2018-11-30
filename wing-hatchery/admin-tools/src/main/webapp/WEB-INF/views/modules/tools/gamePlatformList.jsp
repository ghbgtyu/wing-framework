<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>平台管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/tools/gamePlatform/">平台列表</a></li>
		<li><a href="${ctx}/tools/gamePlatform/form">添加平台</a></li>
	</ul>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr><th>平台名称</th><th>平台编号</th><th>描述信息</th><th>登陆签名</th><th>创建人</th><th>创建日期</th><th>操作</th></tr>
		<c:forEach items="${list}" var="gamePlatform">
			<tr>
				<td><a href="form?id=${gamePlatform.id}">${gamePlatform.name}</a></td>
				<td>${gamePlatform.pid}</td>
				<td>${gamePlatform.description}</td>
				<td>${gamePlatform.signKey}</td>
				<td>${gamePlatform.createBy.loginName}</td>
                <td><fmt:formatDate value="${gamePlatform.createDate}" type="both"/></td>
				<td>
					<a href="${ctx}/tools/gamePlatform/form?id=${gamePlatform.id}">修改</a>
					<a href="${ctx}/tools/gamePlatform/delete?id=${gamePlatform.id}" onclick="return confirmx('确认要删除该平台吗？', this.href)">删除</a>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>