<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>公告管理</title>
	<meta name="decorator" content="default"/>
    <script type="text/javascript">
//       $(function(){
//           $('.tooltip-demo').tooltip({
//               selector: "a[data-toggle=tooltip]"
//           })
//       });

    </script>
    <style type="text/css">
        table{table-layout: fixed;}
    </style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/tools/gameEmail/">邮件列表</a></li>
		<shiro:hasPermission name="game.email.edit">
			<li><a href="${ctx}/tools/gameEmail/form">申请邮件</a></li>
		</shiro:hasPermission>
        <shiro:hasPermission name="game.email.batchadd">
            <li><a href="${ctx}/tools/gameEmail/batchAdd">申请补偿</a></li>
        </shiro:hasPermission>
	</ul>
    <form:form id="searchForm" modelAttribute="gameEmail" action="${ctx}/tools/gameEmail/" method="post" class="breadcrumb form-search">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <label>邮件标题：</label>
        <form:input path="title" htmlEscape="false" maxlength="100" class="input-small"/>
        <label>内容：</label>
        <form:input path="content" htmlEscape="false" maxlength="100" class="input-small"/>
        <label>状态：</label>
        <form:select path="emailStatus">
            <form:option value="" label="请选择"></form:option>
            <form:options items="${fns:getDictList('email_status')}" itemLabel="label" itemValue="value"/>
        </form:select>
        <label>申请时间：</label>
         <input type="text" name="createTimeStart" class="input_search" size="10" readonly="readonly" maxlength="20" value="${paramMap.createTimeStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
				-&nbsp;<input type="text" name="createTimeEnd"   class="input_search" size="10" readonly="readonly" value="${paramMap.createTimeEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
        &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
        <shiro:hasPermission name="game.email.batchcancel">
        &nbsp;<input id="batchCancel" class="btn btn-primary" type="button" value="取消" onclick="submitCheckedRecordIds('${ctx}/tools/gameEmail/batchCancel')"/>
        </shiro:hasPermission>
        <shiro:hasPermission name="game.email.batchrecover">
        &nbsp;<input id="batchRecover" class="btn btn-primary" type="button" value="恢复" onclick="submitCheckedRecordIds('${ctx}/tools/gameEmail/batchRecover')"/>
        </shiro:hasPermission>
        </div>
    </form:form>
	<tags:message content="${message}"/>
    <form id="tableForm" action="">
	<table id="contentTable" class="table table-striped table-bordered table-condensed tooltip-demo">
		<tr><th width="18px"><input id="checkAllOrNot" name="checkAllOrNot" type="checkbox"></th></td><th>邮件标题</th><th>邮件内容</th><th>发送方式</th><th>邮件附件内容</th><th>发送服务器</th><th>发送角色名列表</th><th>发送角色ID列表</th><th>申请人</th><th>审批人</th><th>时间</th><th>状态</th><th>操作</th></tr>
		<c:forEach items="${page.list}" var="gameEmail">
			<tr>
                <td><input type="checkbox" name="recordIds" value="${gameEmail.id}"></td>
                <td>${gameEmail.title}</td>
                <td>${gameEmail.content}</td>
                <td>
                    <c:if test="${gameEmail.isGlobal == 1}">全部服务器</c:if>
                    <c:if test="${gameEmail.isGlobal == 0}">指定服务器</c:if>
                </td>
                <td style="overflow:hidden;white-space:nowrap;"><a title="${fn:replace(gameEmail.attachments,"\"","")}">${gameEmail.attachments}</a> </td>
                <td>${gameEmail.serverIds}</td>
                <td style="overflow:hidden;white-space:nowrap;"><a title="${gameEmail.receiverNames}">${gameEmail.receiverNames}</a> </td>
                <td style="overflow:hidden;white-space:nowrap;"> <a title="${gameEmail.receiverUserIds}">${gameEmail.receiverUserIds}</a> </td>
                <td>${gameEmail.createName}</td>
                <td>${gameEmail.approveName}</td>
                <td><fmt:formatDate value="${gameEmail.createTime}" type="both"/></td>
                <td>
                    <c:choose>
                        <c:when test="${gameEmail.emailStatus == 2}"><span class="label label-warning">${fns:getDictLabel(gameEmail.emailStatus, 'email_status', '无')}</span></c:when>
                        <c:when test="${gameEmail.emailStatus == 1}"><span class="label label-success">${fns:getDictLabel(gameEmail.emailStatus, 'email_status', '无')}</span></c:when>
                        <c:when test="${gameEmail.emailStatus == 0}"><span class="label label-info">${fns:getDictLabel(gameEmail.emailStatus, 'email_status', '无')}</span></c:when>
                        <c:otherwise>${fns:getDictLabel(gameEmail.emailStatus, 'email_status', '无')}</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${gameEmail.emailStatus == 0}">
					<shiro:hasPermission name="game.email.send">
                        <a href="${ctx}/tools/gameEmail/send?id=${gameEmail.id}" onclick="return confirmx('确认要发送邮件吗？', this.href)">发送</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="game.email.cancel">
                        <a href="${ctx}/tools/gameEmail/cancel?id=${gameEmail.id}" onclick="return confirmx('确认要取消该邮件吗？', this.href)">取消</a>
					</shiro:hasPermission>
                    </c:if>
                    <c:if test="${gameEmail.emailStatus == 2}">
                        <a href="${ctx}/tools/gameEmail/recover?id=${gameEmail.id}" onclick="return confirmx('确认要恢复该邮件吗？', this.href)">恢复</a>
                    </c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
    </form>
    
</body>
</html>