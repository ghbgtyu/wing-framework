<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>充值统计</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        //       $(function(){
        //           $("#tipDiv").tooltip('show');
        //       });

    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/log/recharge/chargeStatistics">充值统计</a></li>
</ul>
<form id="searchForm" action="${ctx}/log/recharge/chargeStatistics" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>角色名：</label>
    <input type="text" id="roleName" name="roleName" class="input-small" value="${paramMap.roleName}"/>
    <label>玩家账号：</label>
    <input type="text" id="userId" name="userId" class="input-small" value="${paramMap.userId}"/>
    <label>角色账号：</label>
    <input type="text" id="roleId" name="roleId" class="input-small" value="${paramMap.roleId}"/>
    <label>时间：</label>
    <input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20"
           value="${paramMap.createDateStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
    -&nbsp;<input type="text" name="createDateEnd" class="input_search" size="10" readonly="readonly"
                  value="${paramMap.createDateEnd}" id="endDatePicker"
                  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">

    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
                 onclick="return page();"/>

</form>
<tags:message content="${message}"/>
<form id="tableForm" action="">
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <input type="text" style="display: none" hidden="hidden" name="msg" id="msg">
        <tr>
            <th width="18px"><input id="checkAllOrNot" name="checkAllOrNot" type="checkbox"></th>
            <th>用户账号</th>
            <th>角色账号</th>
            <th>角色名</th>
            <th>等级</th>
            <th>总充值金额</th>
            <th>充值次数</th>
            <th>最大充值金额</th>
            <th>目前剩余元宝</th>
            <th>最后充值时间</th>
            <th>最后登陆时间</th>
            <th>充值流失</th>
            <th>登陆流流失</th>
        </tr>
        <c:forEach items="${page.list}" var="role">
            <tr>
                <td><input type="checkbox" name="recordIds" value="${role.id}"></td>
                <td>${role.user_id}</td>
                <td>${role.role_id}</td>
                <td>${role.role_name}</td>
                <td>${role.level}</td>
                <td>${role.total_rmb_amount}</td>
                <td>${role.recharge_count}</td>
                <td>${role.max_rmb_amount}</td>
                <td>${role.surplus_treasure}</td>
                <td>${role.lastChargeTime}</td>
                <td>${role.last_login_time}</td>
                <td>${fns:getPastDays(role.lastChargeTime)}</td>
                <td>${fns:getPastDays(role.last_login_time)}</td>
                <td></td>
            </tr>
        </c:forEach>
    </table>
</form>
<div class="pagination">${page}</div>
</body>
</html>