<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>日综合报表</title>
    <meta name="decorator" content="default"/>

    <script src="${ctxStatic}/common/fixtable.js" type="text/javascript"></script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/global/dashboard/dailyComprehensiveReport">日综合报表</a></li>
</ul>
<form id="searchForm" action="${ctx}/global/dashboard/dailyComprehensiveReport" method="post"
      class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <label>时间 ：</label>
    <input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20"
           value="${paramMap.createDateStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
    -&nbsp;<input type="text" name="createDateEnd" class="input_search" size="10" readonly="readonly"
                  value="${paramMap.createDateEnd}" id="endDatePicker"
                  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">

    <label>服务器：</label>
    <input id="serverIds" name="serverIds" value="${paramMap.serverIdList}" readonly="readonly"/>
    <input type="button" class="btn btn-primary" value="选择服务器" onclick="openSeverDialog();">
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
                 onclick="return page();"/>
</form>
<tags:message content="${message}"/>
<div style="overflow: scroll">
    <table id="contentTable" class="datatable table table-striped table-bordered table-condensed"
           style="overflow: scroll">
        <thead>
        <tr>
            <th>日期</th>
            <th>开服数</th>
            <th>收入</th>
            <th>新增注册数</th>
            <th>活跃用户</th>
            <th>老用户</th>
            <th>ACCU</th>
            <th>PCCU</th>
            <th>DT时长(分)</th>
            <th>充值人数</th>
            <th>充值次数</th>
            <th>付费率</th>
            <th>ARPU</th>
            <th>活跃ARPU</th>
            <th>首充人数</th>
            <th>首充金额</th>
            <th>日首充次数</th>
            <th flex="true">新新充值人数</th>
            <th flex="true">新新充值金额</th>
            <th flex="true">新新充值次数</th>
            <th flex="true">新新付费率</th>
            <th>新新ARPU</th>
            <th>老新充值人数</th>
            <th>老新充值金额</th>
            <th>老新充值次数</th>
            <th>老新付费率</th>
            <th>老新ARPU</th>
            <th>老老充值人数</th>
            <th>老老充值金额</th>
            <th>老老充值次数</th>
            <th>老老付费率</th>
            <th>老老ARPU</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="item">
            <tr>
                <td>${item.log_day}</td>
                <td>${item.kaifuNum}</td>
                <td>${item.income}</td>
                <td>${item.dru}</td>
                <td>${item.dau}</td>
                <td>${item.dau - item.dru}</td>
                <td>${item.acu}</td>
                <td>${item.pccu}</td>
                <td><fmt:formatNumber value="${item.dt}" pattern="#0.00"/></td>
                <td>${item.dpa}</td>
                <td>${item.dp_times }</td>
                <td><fmt:formatNumber value="${item.pay_rate}" pattern="#0.00"/></td>
                <td><fmt:formatNumber value="${item.arpu}" pattern="#0.00"/></td>
                <td><fmt:formatNumber value="${item.active_arpu}" pattern="#0.00"/></td>
                <td>${item.first_pay_user}</td>
                <td>${item.first_pay_value}</td>
                <td>${item.first_pay_Num }</td>
                <td>${item.nn_pa}</td>
                <td>${item.nn_pay_value}</td>
                <td>${item.nn_pay_times }</td>
                <td>${item.nn_payingrate}</td>
                <td>${item.nn_arpu}</td>
                <td>${item.on_pa}</td>
                <td>${item.on_pay_value}</td>
                <td>${item.on_pay_times }</td>
                <td>${item.on_payingrate}</td>
                <td>${item.on_arpu}</td>
                <td>${item.oo_pa}</td>
                <td>${item.oo_pay_value}</td>
                <td>${item.oo_pay_times }</td>
                <td>${item.oldold_payingrate}</td>
                <td>${item.oldold_arpu}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagination">${page}</div>
</div>
<br/>
<div>
    <table id="weekReport" class="datatable table table-striped table-bordered table-condensed"
           style="overflow: scroll">
        <thead>
        <th>周</th>
        <th>时间段</th>
        <th>周开服</th>
        <th>周收入</th>
        <th>周新增注册</th>
        <th>周活跃</th>
        <th>周老用户</th>
        <th>周充值用户</th>
        <th>付费率</th>
        <th>ARPU</th>
        <th>周活跃ARPU</th>
        <th>新新充值人数</th>
        <th>新新充值金额</th>
        <th>周新新付费率</th>
        <th>周新新ARPU</th>
        <th>周老充值人数</th>
        <th>周老充值金额</th>
        <th>周老付费率</th>
        <th>周老ARPU</th>
        </thead>
        <tbody>
        <c:forEach items="${weekReport}" var="item">
            <tr>
                <td>${item.log_year}年第${item.log_week}周</td>
                <td>${fns:getDayRange(item.log_year, item.log_week)}</td>
                <td>${item.open_num}</td>
                <td>${item.income}</td>
                <td>${item.ru}</td>
                <td>${item.au}</td>
                <td>${item.ou}</td>
                <td>${item.pu}</td>
                <td>${item.wRate}</td>
                <td>${item.wArpu}</td>
                <td>${item.wActiveArpu}</td>
                <td>${item.npu}</td>
                <td>${item.nincome}</td>
                <td>${item.nRate}</td>
                <td>${item.nArpu}</td>
                <td>${item.opu}</td>
                <td>${item.oincome}</td>
                <td>${item.oRate}</td>
                <td>${item.oArpu}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>


<script type="text/javascript">
    //	$(document).ready(function(){
    //		FixTable('contentTable',5,'100%','600px');
    //	});
</script>

</body>
</html>