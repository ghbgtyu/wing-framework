<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>基础信息</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/global/dashboard/baseReport">基础信息</a></li>
</ul>
<form id="searchForm" action="${ctx}/global/dashboard/baseReport" method="post" class="breadcrumb form-search">
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

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span6 panel panel-primary">
            <div class="panel-heading">每日运营数据</div>
            <div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
                <table id="dailyTable" class="table table-striped table-bordered table-condensed">
                    <tr>
                        <th>日期</th>
                        <th>新增注册数</th>
                        <th>活跃用户</th>
                        <th>收入</th>
                        <th>付费人数</th>
                        <th>平均在线</th>
                        <th>最高在线</th>
                        <th>付费率</th>
                        <th>ARPU</th>
                    </tr>
                    <c:forEach items="${list}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.dru}</td>
                            <td>${item.dau}</td>
                            <td>${item.income}</td>
                            <td>${item.dpa}</td>
                            <td>${item.acu}</td>
                            <td>${item.pccu}</td>
                            <td>${item.pay_rate}</td>
                            <td>${item.arpu}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <div class="span6 panel panel-primary">
            <div class="panel-heading">收入</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-income" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-income" data-graph-type="column" data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='人数' data-graph-yaxis-2-title-text='新增充值用户数'
                       data-graph-zoom-type="xy" data-graph-yaxis-2-opposite="1" style="display: none">
                    <caption>收入</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th data-graph-type="column">日充值金额</th>
                        <th data-graph-type="line">充值用户</th>
                        <th data-graph-type="line" data-graph-yaxis="1">新增充值用户</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.income}</td>
                            <td>${item.dpa}</td>
                            <td>${item.nn_pay_value}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <div class="row-fluid">
        <div class="span6 panel panel-primary">
            <div class="panel-heading">整体运营</div>
            <div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
                <table id="overallTable" class="table table-striped table-bordered table-condensed">
                    <tr>
                        <th>日期</th>
                        <th>累计开服</th>
                        <th>累计收入</th>
                        <th>累计新进</th>
                        <th>累计付费人数</th>
                    </tr>
                    <c:forEach items="${hisTotal}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.total_server_count}</td>
                            <td>${item.total_earning}</td>
                            <td>${item.total_registration}</td>
                            <td>${item.total_recharge_user_count}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>

        <div class="span6 panel panel-primary">
            <div class="panel-heading">月总数据</div>
            <div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
                <table id="totalData" class="table table-striped table-bordered table-condensed">
                    <tr>
                        <th>日期</th>
                        <th>收入</th>
                        <th>新注册</th>
                        <th>活跃用户数</th>
                        <th>月留存</th>
                        <th>ACCU</th>
                        <th>PCCU</th>
                        <th>付费人数</th>
                        <th>付费率(%)</th>
                        <th>ARPU</th>
                        <th>活跃ARPU</th>
                    </tr>
                    <c:forEach items="${monthlyTotals }" var="item" varStatus="statu">
                        <tr>
                            <td>${item.log_month}</td>
                            <td>${item.income}</td>
                            <td>${item.dru}</td>
                            <td>${item.mau}</td>
                            <td>${item.month_remainer}</td>
                            <td>${item.acu}</td>
                            <td>${item.pccu}</td>
                            <td>${item.mpu}</td>
                            <td><fmt:formatNumber value="${item.pay_rate *100}" pattern="#0.00"/>%</td>
                            <td>${item.arpu}</td>
                            <td>${item.active_rapu}</td>
                        </tr>
                    </c:forEach>
                    <c:forEach items="${monthlyTotal}" var="item" varStatus="statu">
                        <tr>
                            <td>${item.log_month}</td>
                            <td>${item.income}</td>
                            <td>${item.ru}</td>
                            <td>${item.au}</td>
                            <td>${item.month_remainer}</td>
                            <td>${item.acu}</td>
                            <td>${item.pccu}</td>
                            <td>${item.pa}</td>
                            <td><fmt:formatNumber value="${item.mRate *100}" pattern="#0.00"/>%</td>
                            <td>${item.mArpu}</td>
                            <td>${item.active_arpu}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>

    </div>


    <div class="row-fluid">
        <div class="span6 panel panel-primary">
            <div class="panel-heading">新进及活跃</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-newactive" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-newactive" data-graph-type="spline"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='人数' style="display: none">
                    <caption>新进及活跃</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th>新进人数</th>
                        <th>活跃人数</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.dru}</td>
                            <td>${item.dau}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="span6 panel panel-primary">
            <div class="panel-heading">平均及最高在线</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-accupccu" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-accupccu" data-graph-type="spline" data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='人数' style="display: none">
                    <caption>平均及最高在线</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th>ACCU</th>
                        <th>PCCU</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="item">
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
    </div>

    <div class="row-fluid">
        <div class="span6 panel panel-primary">
            <div class="panel-heading">平台收入比例</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-income-pie" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-income-pie" data-graph-type="pie"
                       data-graph-pie-show-in-legend="1" data-graph-datalabels-enabled="1" style="display: none">
                    <caption>平台收入比例</caption>
                    <thead>
                    <tr>
                        <th data-graph-type="pie">平台</th>
                        <th data-graph-type="pie">占比</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${mapList}" var="item">
                        <tr>
                            <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
                            <td data-graph-name="${fns:getGamePlatformNameById(item.pid,item.pid)} : <fmt:formatNumber type="percent" value="${item.p_income_percent}"/>">
                                <fmt:formatNumber type="percent" value="${item.p_income_percent}"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="span6 panel panel-primary">
            <div class="panel-heading">平台活跃比例</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-active-pie" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-active-pie" data-graph-type="pie"
                       data-graph-pie-show-in-legend="1" data-graph-datalabels-enabled="1" style="display: none">
                    <caption>平台活跃比例</caption>
                    <thead>
                    <tr>
                        <th data-graph-type="pie">平台</th>
                        <th data-graph-type="pie">占比</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${mapList}" var="item">
                        <tr>
                            <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
                            <td data-graph-name="${fns:getGamePlatformNameById(item.pid,item.pid)} : <fmt:formatNumber type="percent" value="${item.p_dau_percent}"/>">
                                <fmt:formatNumber type="percent" value="${item.p_dau_percent}"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <div class="row-fluid">
        <div class="span6 panel panel-primary">
            <div class="panel-heading">平台导量比例</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-new" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-new" data-graph-type="pie" data-graph-pie-show-in-legend="1"
                       data-graph-datalabels-enabled="1" style="display: none">
                    <caption>平台导量比例</caption>
                    <thead>
                    <tr>
                        <th data-graph-type="pie">平台</th>
                        <th data-graph-type="pie">占比</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${mapList}" var="item">
                        <tr>
                            <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
                            <td data-graph-name="${fns:getGamePlatformNameById(item.pid,item.pid)} : <fmt:formatNumber type="percent" value="${item.p_dru_percent}"/>">
                                <fmt:formatNumber type="percent" value="${item.p_dru_percent}"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="span6 panel panel-primary">
            <div class="panel-heading">平台数据</div>
            <div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
                <table id="platformTable" class="table table-striped table-bordered table-condensed">
                    <tr>
                        <th>时间段</th>
                        <th>平台名</th>
                        <th>平台收入</th>
                        <th>占比</th>
                        <th>平台活跃</th>
                        <th>占比</th>
                        <th>平台导量</th>
                        <th>占比</th>
                    </tr>
                    <c:forEach items="${mapList}" var="item">
                        <tr>
                            <td>${paramMap.createDateStart} ~ ${paramMap.createDateEnd}</td>
                            <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
                            <td>${item.income}</td>
                            <td><fmt:formatNumber type="percent" value="${item.p_income_percent}"/></td>
                            <td>${item.dau}</td>
                            <td><fmt:formatNumber type="percent" value="${item.p_dau_percent}"/></td>
                            <td>${item.dru}</td>
                            <td><fmt:formatNumber type="percent" value="${item.p_dru_percent}"/></td>
                        </tr>
                    </c:forEach>
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
</script>

</body>
</html>