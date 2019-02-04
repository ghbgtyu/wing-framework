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
    <li class="active"><a href="${ctx}/global/dashboard/serverDailyReport">日运营详细数据</a></li>
</ul>
<form id="searchForm" action="${ctx}/global/dashboard/serverDailyReport" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <label>时间 ：</label>
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
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>日期</th>
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
        <th>首充次数</th>
        <th>首充金额</th>
        <th>新注册次日留存</th>
        <th>新注册3日留存</th>
        <th>新注册7日留存</th>
        <th>新注册双周留存</th>
        <th>新注册月留存</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="item">
        <tr>
            <td>${item.log_day}</td>
            <td>${item.income}</td>
            <td>${item.dru}</td>
            <td>${item.dau}</td>
            <td>${item.dau_sub_dru}</td>
            <td>${item.acu}</td>
            <td>${item.pcu}</td>
            <td>${item.dt}</td>

            <td>${item.dpa}</td>
            <td>${item.dp_times}</td>
            <td><fmt:formatNumber value="${item.dpa_dau}" type="percent"/></td>
            <td><fmt:formatNumber value="${item.income_pa}" type="percent"/></td>
            <td><fmt:formatNumber value="${item.income_dau_duplicate}" type="percent"/></td>
            <td>${item.first_pay_user}</td>
            <td>${item.first_pay_times}</td>
            <td>${item.first_pay_value}</td>
            <td>${item.second_remainer}</td>

            <td>${item.third_remainer}</td>
            <td>${item.seventh_remainer}</td>
            <td>${item.doubleweek_remainer}</td>
            <td>${item.month_remainer}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span6 panel panel-primary">
            <div class="panel-heading">多日收入柱形图</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-daysIncome" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-daysIncome" data-graph-type="column"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='收入' data-graph-zoom-type="xy" style="display: none">
                    <caption>多日收入柱形图</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th data-graph-type="column">收入</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${page.list}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.income}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="span6 panel panel-primary">
            <div class="panel-heading">多日活跃柱形图</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-daysActive" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-daysActive" data-graph-type="column"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='人数' data-graph-zoom-type="xy" data-graph-yaxis-2-opposite="1"
                       style="display: none">
                    <caption>多日活跃柱形图</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th data-graph-type="column">活跃人数</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${page.list}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.dau}</td>
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
            <div class="panel-heading">多日平均/最高在线柱形图</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-daysOnlines" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-daysOnlines" data-graph-type="column"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='平均在线人数' data-graph-yaxis-2-title-text='最高在线人数'
                       data-graph-zoom-type="xy" data-graph-yaxis-2-opposite="1" style="display: none">
                    <caption>多日平均/最高在线柱形图</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th data-graph-type="column">平均在线人数</th>
                        <th data-graph-type="line">最高在线人数</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${page.list}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.acu}</td>
                            <td>${item.pcu}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="span6 panel panel-primary">
            <div class="panel-heading">多日充值人数柱形图</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-daysRecharger" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-daysRecharger" data-graph-type="column"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='人数1' data-graph-yaxis-2-title-text='新增充值用户数1'
                       data-graph-zoom-type="xy" data-graph-yaxis-2-opposite="1" style="display: none">
                    <caption>多日充值人数柱形图</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th data-graph-type="column">充值人数</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${page.list}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.dpa}</td>
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