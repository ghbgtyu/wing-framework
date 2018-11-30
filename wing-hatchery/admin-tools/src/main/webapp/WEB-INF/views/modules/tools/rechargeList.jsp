<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>元宝充值</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/tools/recharge/">充值列表</a></li>
		<shiro:hasPermission name="game.recharge.apply">
			<li><a href="${ctx}/tools/recharge/form">按角色名申请充值</a></li>
			<li><a href="${ctx}/tools/recharge/roleIdRechargeForm">按角色ID申请充值</a></li>
		</shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="recharge" action="${ctx}/tools/recharge/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>审批状态：</label>
		<form:select path="rechargeStatus" >
			<form:option value="" label="请选择"></form:option>
			<form:options items="${fns:getDictList('recharge_status')}" itemLabel="label" itemValue="value"/>
		</form:select>
		<label>角色名：</label>
		<form:input path="roleNames" htmlEscape="false" maxlength="100" class="input-small"/>
		<label>服务器：</label>
		<form:input path="serverId" htmlEscape="false" maxlength="100" class="input-small"/>
		<label>充值类型：</label>
		<form:select path="rechargeType">
			<form:option value="" label="请选择"></form:option>
			<form:options items="${fns:getDictList('recharge_type')}" itemLabel="label" itemValue="value"/>
		</form:select>
		<label>货币类型：</label>
		<form:select path="moneyType">
			<form:option value="" label="请选择"></form:option>
			<form:options items="${fns:getDictList('money_type')}" itemLabel="label" itemValue="value"/>
		</form:select>
		<label>申请时间：</label>
		<input type="text" name="createTimeStart" class="input-small" readonly="readonly" maxlength="20" value="${paramMap.createTimeStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createTimeEnd"   class="input-small" readonly="readonly" value="${paramMap.createTimeEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">		
		<div class="">
			<br/>
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
		<shiro:hasPermission name="game.recharge.batchadd">
			&nbsp;<input id="batchAdd" class="btn btn-primary" type="button" value="审核" onclick="submitCheckedRecordIds('${ctx}/tools/recharge/batchAdd')"/>
		</shiro:hasPermission>
		<shiro:hasPermission name="game.recharge.batchcancel">
			&nbsp;<input id="batchCancel" class="btn btn-primary" type="button" value="取消" onclick="submitCheckedRecordIdsAjax('${ctx}/tools/recharge/batchCancel')"/>
		</shiro:hasPermission>
		<shiro:hasPermission name="game.recharge.batchrecover">
			&nbsp;<input id="batchRecover" class="btn btn-primary" type="button" value="恢复" onclick="submitCheckedRecordIdsAjax('${ctx}/tools/recharge/batchRecover')"/>
		</shiro:hasPermission>
		</div>
	</form:form>
	<tags:message content="${message}"/>
	<form id="tableForm" action="">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr><th width="18px"><input id="checkAllOrNot" name="checkAllOrNot" type="checkbox"></th><th>服务器</th><th>用户账户</th><th>角色名</th><th>充值类型</th><th>货币类型</th><th>数量</th><th>充值时间</th><th>申请者</th><th>审批者</th><th>备注</th><th>审批状态</th></tr>
		<c:forEach items="${page.list}" var="item">
			<tr>
				<td><input type="checkbox" name="recordIds" value="${item.id}"></td>
				<td>${item.serverId}</td>
				<td style="overflow: hidden;white-space: nowrap" title="${item.roleIds}">${item.roleIds}</td>
				<td style="overflow: hidden;white-space: nowrap" title="${item.roleNames}">${item.roleNames}</td>
				<td>
					<c:choose>
						<c:when test="${item.rechargeType == 2}"><span class="label label-warning">${fns:getDictLabel(item.rechargeType, 'recharge_type', '无')}</span></c:when>
						<c:when test="${item.rechargeType == 1}"><span class="label label-success">${fns:getDictLabel(item.rechargeType, 'recharge_type', '无')}</span></c:when>
						<c:when test="${item.rechargeType == 0}"><span class="label label-info">${fns:getDictLabel(item.rechargeType, 'recharge_type', '无')}</span></c:when>
						<c:otherwise>${fns:getDictLabel(item.rechargeType, 'recharge_type', '无')}</c:otherwise>
					</c:choose>
				</td>
				<td>${fns:getDictLabel(item.moneyType, 'money_type', '无')}</td>
				<td>${item.moneyNum}</td>
				<td><fmt:formatDate value="${item.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
				<td>${item.createName} </td>
				<td>${item.approveName} </td>
				<td><div title="${item.remark}">${item.remark}</div> </td>
				<td>
					<c:choose>
						<c:when test="${item.rechargeStatus == 2}"><span class="label label-warning">${fns:getDictLabel(item.rechargeStatus, 'recharge_status', '无')}</span></c:when>
						<c:when test="${item.rechargeStatus == 1}"><span class="label label-success">${fns:getDictLabel(item.rechargeStatus, 'recharge_status', '无')}</span></c:when>
						<c:when test="${item.rechargeStatus == 0}"><span class="label label-info">${fns:getDictLabel(item.rechargeStatus, 'recharge_status', '无')}</span></c:when>
						<c:otherwise>${fns:getDictLabel(item.rechargeStatus, 'email_status', '无')}</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</table>
	</form>
	<div class="pagination">${page}</div>
</body>
</html>