<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>充值列表</title>
    <meta name="decorator" content="default"/>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/log/recharge/">充值列表</a></li>
</ul>
<form id="searchForm" action="${ctx}/log/recharge/" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>角色账号：</label>
    <input name="roleId" maxlength="100" class="input-small"/>
    <label>角色名：</label>
    <input name="roleName" maxlength="100" class="input-small"/>
    <label>时间：</label>
    <input type="text" name="createDateStart" class="input-small" readonly="readonly" maxlength="20"
           value="${paramMap.createDateStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
    -&nbsp;<input type="text" name="createDateEnd" class="input-small" readonly="readonly"
                  value="${paramMap.createDateEnd}" id="endDatePicker"
                  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">

    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
                 onclick="return page();"/>

</form>
<tags:message content="${message}"/>
<form id="tableForm" action="">
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <th width="18px"><input id="checkAllOrNot" name="checkAllOrNot" type="checkbox"></th>
            <th>用户账号</th>
            <th>角色账号</th>
            <th>角色名</th>
            <th>订单号</th>
            <th>充值类型</th>
            <th>货币类型</th>
            <th>充值金额</th>
            <th>充值元宝</th>
            <th>充值状态</th>
            <th>充值时间</th>
        </tr>
        <c:forEach items="${page.list}" var="item">
            <tr>
                <td><input type="checkbox" name="recordIds" value="${item.id}"></td>
                <td>${item.userId}</td>
                <td style="overflow: hidden;white-space: nowrap" title="${item.roleId}">${item.roleId}</td>
                <td style="overflow: hidden;white-space: nowrap" title="${item.roleName}">${item.roleName}</td>
                <td>${item.orderId}</td>
                <td>
                    <c:choose>
                        <c:when test="${item.rechargeType == 2}"><span
                                class="label label-warning">${fns:getDictLabel(item.rechargeType, 'recharge_type', '无')}</span></c:when>
                        <c:when test="${item.rechargeType == 1}"><span
                                class="label label-success">${fns:getDictLabel(item.rechargeType, 'recharge_type', '无')}</span></c:when>
                        <c:when test="${item.rechargeType == 0}"><span
                                class="label label-info">${fns:getDictLabel(item.rechargeType, 'recharge_type', '无')}</span></c:when>
                        <c:otherwise>${fns:getDictLabel(item.rechargeType, 'recharge_type', '无')}</c:otherwise>
                    </c:choose>
                </td>
                <td>${fns:getDictLabel(item.moneyType, 'money_type', '无')}</td>
                <td>${item.rmb_amount}</td>
                <td>${item.treasure_amount}</td>
                <td>${item.is_finish}</td>
                <td>${fns:parseLong(item.recharge_time)}</td>
            </tr>
        </c:forEach>
    </table>
</form>
<div class="pagination">${page}</div>
</body>
</html>