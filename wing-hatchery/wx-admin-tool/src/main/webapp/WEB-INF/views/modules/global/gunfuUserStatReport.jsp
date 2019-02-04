<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>日运营详细数据</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/global/dashboard/gunfuUserStatReport">日运营详细数据</a></li>
</ul>
<form id="searchForm" action="${ctx}/global/dashboard/gunfuUserStatReport" method="post" class="breadcrumb form-search">
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
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th></th>
        <th colspan="8" style="text-align: center;">每日数据</th>
        <th colspan="8" align="center" style="text-align: center;">滚服用户数据</th>
    </tr>
    <tr>
        <th>日期</th>
        <th>收入</th>
        <th>总新注册数</th>
        <th>总活跃用户</th>
        <th>ACCU</th>
        <th>DT时长(分)</th>
        <th>充值人数</th>
        <th>付费率</th>
        <th>ARPU</th>
        <th>收入</th>
        <th>总新注册数</th>
        <th>总活跃用户</th>
        <th>ACCU</th>
        <th>DT时长(分)</th>
        <th>充值人数</th>
        <th>付费率</th>
        <th>ARPU</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="item">
        <tr>
            <td>${item.log_day}</td>
            <td>${item.income}</td>
            <td>${item.dru}</td>
            <td>${item.dau}</td>
            <td>${item.acu}</td>
            <td>${item.dt}</td>

            <td>${item.dpa}</td>
            <td><fmt:formatNumber value="${item.dpa_dau_duplicate}" pattern="0.00"/></td>
            <td><fmt:formatNumber value="${item.income_dpa}" pattern="0.00"/></td>
            <td><fmt:formatNumber value="${item.on_pay_value}" pattern="0.00"/></td>
            <td>${item.dru_gunfu}</td>
            <td>${item.rdau}</td>

            <td>${item.gunfu_acu}</td>
            <td>${item.gunfu_dt}</td>
            <td>${item.on_pa}</td>
            <td><fmt:formatNumber value="${item.gunfu_dpa_rdau}" pattern="0.00"/></td>
            <td><fmt:formatNumber value="${item.gunfu_income_gunfu_dpa}" pattern="0.00"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span6 panel panel-primary">
            <div class="panel-heading">收入</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-daysIncome" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-daysIncome" data-graph-type="column"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='每日数据' data-graph-yaxis-2-title-text='滚服数据'
                       data-graph-zoom-type="xy" data-graph-yaxis-2-opposite="1" style="display: none">
                    <caption>每日数据vs滚服数据</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th data-graph-type="line">每日数据</th>
                        <th data-graph-type="line" data-graph-yaxis="1">滚服数据</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${page.list}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.income}</td>
                            <td>${item.gunfu_income}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="span6 panel panel-primary">
            <div class="panel-heading">新注册</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-daysActive" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-daysActive" data-graph-type="column"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='每日数据' data-graph-yaxis-2-title-text='滚服数据'
                       data-graph-zoom-type="xy" data-graph-yaxis-2-opposite="1" style="display: none">
                    <caption>每日数据vs滚服数据</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th data-graph-type="line">每日数据</th>
                        <th data-graph-type="line" data-graph-yaxis="1">滚服数据</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${page.list}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.dru}</td>
                            <td>${item.dru_gunfu}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span6 panel panel-primary">
            <div class="panel-heading">活跃</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-daysOnlines" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-daysOnlines" data-graph-type="column"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='每日数据' data-graph-yaxis-2-title-text='滚服数据'
                       data-graph-zoom-type="xy" data-graph-yaxis-2-opposite="1" style="display: none">
                    <caption>每日数据vs滚服数据</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th data-graph-type="line">每日数据</th>
                        <th data-graph-type="line" data-graph-yaxis="1">滚服数据</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${page.list}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.dau}</td>
                            <td>${item.rdau}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="span6 panel panel-primary">
            <div class="panel-heading">充值人数</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-daysRecharger" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-daysRecharger" data-graph-type="column"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='每日数据' data-graph-yaxis-2-title-text='滚服数据'
                       data-graph-zoom-type="xy" data-graph-yaxis-2-opposite="1" style="display: none">
                    <caption>每日数据vs滚服数据</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th data-graph-type="line">每日数据</th>
                        <th data-graph-type="line" data-graph-yaxis="1">滚服数据</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${page.list}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.dpa}</td>
                            <td>${item.gunfu_dpa}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('table.highchart').highchartTable();
    });
</script>

</body>
</html>