<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>新服道具销售</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
    <script src="${ctxStatic}/common/fixtable.js" type="text/javascript"></script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/global/tradeController/propSale?stype=1">新服道具销售</a></li>
</ul>
<form id="searchForm" action="${ctx}/global/tradeController/propSale?stype=1" method="post"
      class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>日期选择：</label>
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

<table id="active-yb" class="table table-striped table-bordered table-condensed">
    <tr>
        <th>时间段</th>
        <th>商店类型</th>
        <th>物品名称</th>
        <th>物品ID</th>
        <th>数量</th>
        <th>总消耗金额</th>
        <th>占比(%)</th>
        <th>元宝消耗金额</th>
        <th>消费人数</th>
        <th>消费次数</th>
        <th>绑元消费金额</th>
        <th>绑元消费人数</th>
        <th>绑元消费次数</th>
    </tr>
    <c:forEach items="${goodsSalesList}" var="item">
        <tr>
            <td>${createDateStart } ~ ${createDateEnd }</td>
            <td>${item.type }</td>
            <td>${item.itemName }</td>
            <td>${item.itemId }</td>
            <td>${item.itemNum }</td>
            <td>${item.amount }</td>
            <td><fmt:formatNumber value="${item.amount*100/total }" pattern="#0.00"/> %</td>
            <td>${item.consuYb }</td>
            <td>${item.ybPopulation }</td>
            <td>${item.ybNum }</td>
            <td>${item.bindYb }</td>
            <td>${item.bindPopulation }</td>
            <td>${item.bindNum }</td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
</body>
</html>