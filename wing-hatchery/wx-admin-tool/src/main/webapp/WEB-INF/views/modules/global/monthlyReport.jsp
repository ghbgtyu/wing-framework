<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>月数据报表</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/global/dashboard/monthlyReport">月数据报表</a></li>
</ul>
<form id="searchForm" action="${ctx}/global/dashboard/monthlyReport" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <label>时间 ：</label>
    <input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20"
           value="${paramMap.createDateStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}',dateFmt:'yyyy-MM'})">
    -&nbsp;<input type="text" name="createDateEnd" class="input_search" size="10" readonly="readonly"
                  value="${paramMap.createDateEnd}" id="endDatePicker"
                  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}',dateFmt:'yyyy-MM'})">
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
            <th>月份</th>
            <th>月开服数</th>
            <th>月收入</th>
            <th>月新注册</th>
            <th>月活跃</th>
            <th>ACCU</th>
            <th>PCCU</th>
            <th>DT时长</th>
            <th>月老用户数</th>
            <th>月留存率</th>
            <th>月充值用户</th>
            <th>月充值次数</th>
            <th>月付费率</th>
            <th>月ARPU</th>
            <th>月活跃ARPU</th>
            <th>月首充人数</th>
            <th>月首充次数</th>
            <th>月首充金额</th>
            <th>月新新充值人数</th>
            <th>月新新充值次数</th>
            <th>月新新充值金额</th>
            <th>月新新付费率</th>
            <th>月新新ARPU</th>
            <th>月老充值人数</th>
            <th>月老充值次数</th>
            <th>月老充值金额</th>
            <th>月老付费率</th>
            <th>月老ARPU</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="item">
            <tr>
                <td>${item.log_month}</td>
                <td>${item.kaifuNum}</td>
                <td>${item.income}</td>
                <td>${item.dru}</td>
                <td>${item.mau}</td>
                <td>${item.acu}</td>
                <td>${item.pccu}</td>
                <td>${item.dt}</td>
                <td>${item.mou}</td>
                <td>${item.month_remainer}</td>
                <td>${item.mpu}</td>
                <td>${item.dp_times}</td>
                <td><fmt:formatNumber value="${item.pay_rate *100}" pattern="#0.00"/>%</td>
                <td>${item.arpu}</td>
                <td>${item.active_arpu}</td>
                <td>${item.first_pay_user}</td>
                <td>${item.first_pay_times}</td>
                <td>${item.first_pay_value}</td>
                <td>${item.mnn_pa}</td>
                <td>${item.nn_pay_times}</td>
                <td>${item.nn_pay_value}</td>
                <td><fmt:formatNumber value="${item.nn_pay_rate *100}" pattern="#0.00"/>%</td>
                <td>${item.nn_arpu}</td>
                <td>${item.d_n_pa}</td>
                <td>${item.df_times}</td>
                <td>${item.i_f_pay_value}</td>
                <td><fmt:formatNumber value="${item.on_pay_rate *100}" pattern="#0.00"/>%</td>
                <td>${item.on_arpu}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<br/>
<div class="row-fluid">
    <div class="span6 panel panel-primary">
        <div class="panel-heading">多月收入</div>
        <div style="height: 300px;line-height: 300px">
            <div class="highchart-monthsIncome" style="height: 300px"></div>
            <table class="highchart table"
                   data-graph-container=".highchart-monthsIncome" data-graph-type="column" data-graph-xaxis-reversed="1"
                   data-graph-yaxis-1-title-text='收入' data-graph-zoom-type="xy" style="display: none">
                <caption>多月收入</caption>
                <thead>
                <tr>
                    <th>日期</th>
                    <th data-graph-type="column">收入</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td>${item.log_month}</td>
                        <td>${item.income}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="span6 panel panel-primary">
        <div class="panel-heading">多月活跃</div>
        <div style="height: 300px;line-height: 300px">
            <div class="highchart-monthsactive" style="height: 300px"></div>
            <table class="highchart table"
                   data-graph-container=".highchart-monthsactive" data-graph-type="column" data-graph-xaxis-reversed="1"
                   data-graph-yaxis-1-title-text='人数' style="display: none">
                <caption>多月活跃</caption>
                <thead>
                <tr>
                    <th>日期</th>
                    <th data-graph-type="column">人数</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td>${item.log_month}</td>
                        <td>${item.mau}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>


<div class="row-fluid">
    <div class="span6 panel panel-primary">
        <div class="panel-heading">多月新用户</div>
        <div style="height: 300px;line-height: 300px">
            <div class="highchart-newplayer" style="height: 300px"></div>
            <table class="highchart table"
                   data-graph-container=".highchart-newplayer" data-graph-type="spline" data-graph-xaxis-reversed="1"
                   data-graph-yaxis-1-title-text='人数' style="display: none">
                <caption>多月新用户</caption>
                <thead>
                <tr>
                    <th>日期</th>
                    <th>新进人数</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td>${item.log_month}</td>
                        <td>${item.dru}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="span6 panel panel-primary">
        <div class="panel-heading">多月留存率</div>
        <div style="height: 300px;line-height: 300px">
            <div class="highchart-monthremainer" style="height: 300px"></div>
            <table class="highchart table"
                   data-graph-container=".highchart-monthremainer" data-graph-type="spline"
                   data-graph-xaxis-reversed="1"
                   data-graph-yaxis-1-title-text='留存' style="display: none">
                <caption>多月留存率</caption>
                <thead>
                <tr>
                    <th>日期</th>
                    <th>留存</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td>${item.log_month}</td>
                        <td>${item.month_remainer}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="row-fluid">
    <div class="span6 panel panel-primary">
        <div class="panel-heading">多月平均在线</div>
        <div style="height: 300px;line-height: 300px">
            <div class="highchart-dt" style="height: 300px"></div>
            <table class="highchart table"
                   data-graph-container=".highchart-dt" data-graph-type="spline" data-graph-xaxis-reversed="1"
                   data-graph-yaxis-1-title-text='dt' style="display: none">
                <caption>多月平均在线</caption>
                <thead>
                <tr>
                    <th>日期</th>
                    <th>DT时长</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td>${item.log_month}</td>
                        <td>${item.dt}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="span6 panel panel-primary">
        <div class="panel-heading">多月充值人数</div>
        <div style="height: 300px;line-height: 300px">
            <div class="highchart-recharger" style="height: 300px"></div>
            <table class="highchart table"
                   data-graph-container=".highchart-recharger" data-graph-type="column" data-graph-xaxis-reversed="1"
                   data-graph-yaxis-1-title-text='人数' data-graph-zoom-type="xy" style="display: none">
                <caption>多月充值人数</caption>
                <thead>
                <tr>
                    <th>日期</th>
                    <th data-graph-type="column">人数</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td>${item.log_month}</td>
                        <td>${item.mpu}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

</div>


<%--<table id="contentTable" class="table table-striped table-bordered table-condensed">--%>
<%--<tr><th>日期</th><th>开服数</th><th>收入</th><th>新增注册数</th><th>活跃用户</th><th>老用户</th><th>ACCU</th><th>PCCU</th><th>DT时长(分)</th><th>充值人数</th>--%>
<%--<th>付费率</th><th>ARPU</th><th>活跃ARPU</th><th>首充人数</th><th>首充金额</th><th>新新充值人数</th><th>新新充值金额</th><th>新新付费率</th><th>新新ARPU</th>--%>
<%--<th>老新充值人数</th>老新充值金额<th>老新付费率</th><th>老新ARPU</th><th>老新充值人数</th><th>老老充值金额</th><th>老老付费率</th><th>老老ARPU</th></tr>--%>
<%--<c:forEach items="${page.list}" var="item">--%>
<%--<tr>--%>

<%--</tr>--%>
<%--</c:forEach>--%>
<%--</table>--%>
<%--<div class="pagination">${page}</div>--%>

<script type="text/javascript">
    $(document).ready(function () {
        $('table.highchart').highchartTable();
    });

    function selectMonth() {
        WdatePicker({dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false});
    }
</script>

</body>
</html>