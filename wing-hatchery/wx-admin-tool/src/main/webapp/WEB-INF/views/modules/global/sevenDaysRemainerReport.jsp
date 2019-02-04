<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>日活跃总数</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/global/sevenDaysRemainer/sevenDaysRemainerReport">新注册统计</a></li>
</ul>
<form id="searchForm" action="${ctx}/global/sevenDaysRemainer/sevenDaysRemainerReport" method="post"
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
<div class="panel panel-primary">
    <div class="panel-heading">新注册用户7日留存率</div>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th>注册日期</th>
            <th>注册用户数</th>
            <th>次日用户</th>
            <th>次日留存</th>
            <th>3日用户</th>
            <th>3日留存</th>
            <th>4日用户</th>
            <th>4日留存</th>
            <th>5日用户</th>
            <th>5日留存</th>
            <th>6日用户</th>
            <th>6日留存</th>
            <th>7日用户</th>
            <th>7日留存</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${sevenDaysRemainer}" var="item">
            <tr>
                <td>${item.log_day}</td>
                <td>${item.sum_dru}</td>
                <td>${item.sum_2}</td>
                <td><fmt:formatNumber value="${item.sum_2_dru}" type="percent"/></td>
                <td>${item.sum_3}</td>
                <td><fmt:formatNumber value="${item.sum_3_dru}" type="percent"/></td>
                <td>${item.sum_4}</td>
                <td><fmt:formatNumber value="${item.sum_4_dru}" type="percent"/></td>
                <td>${item.sum_5}</td>
                <td><fmt:formatNumber value="${item.sum_5_dru}" type="percent"/></td>
                <td>${item.sum_6}</td>
                <td><fmt:formatNumber value="${item.sum_6_dru}" type="percent"/></td>
                <td>${item.sum_7}</td>
                <td><fmt:formatNumber value="${item.sum_7_dru}" type="percent"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="panel panel-primary">
    <div class="panel-heading">新注册分服7日留存率</div>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th>注册日期</th>
            <th>新服用户</th>
            <th>次日留存率</th>
            <th>3日留存率</th>
            <th>4日留存率</th>
            <th>5日留存率</th>
            <th>6日留存率</th>
            <th>7日留存率</th>
            <th>老服用户</th>
            <th>次日留存率</th>
            <th>3日留存率</th>
            <th>4日留存率</th>
            <th>5日留存率</th>
            <th>6日留存率</th>
            <th>7日留存率</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${sevenDaysRemainer}" var="item">
            <tr>
                <td>${item.log_day}</td>
                <td>${item.sum_dru}</td>
                <td><fmt:formatNumber value="${item.sum_2_dru_new}" type="percent"/></td>
                <td><fmt:formatNumber value="${item.sum_3_dru_new}" type="percent"/></td>
                <td><fmt:formatNumber value="${item.sum_4_dru_new}" type="percent"/></td>
                <td><fmt:formatNumber value="${item.sum_5_dru_new}" type="percent"/></td>
                <td><fmt:formatNumber value="${item.sum_6_dru_new}" type="percent"/></td>
                <td><fmt:formatNumber value="${item.sum_7_dru_new}" type="percent"/></td>
                <td>${item.sum_dru_old}</td>
                <td><fmt:formatNumber value="${item.sum_2_dru_old}" type="percent"/></td>
                <td><fmt:formatNumber value="${item.sum_3_dru_old}" type="percent"/></td>
                <td><fmt:formatNumber value="${item.sum_4_dru_old}" type="percent"/></td>
                <td><fmt:formatNumber value="${item.sum_5_dru_old}" type="percent"/></td>
                <td><fmt:formatNumber value="${item.sum_6_dru_old}" type="percent"/></td>
                <td><fmt:formatNumber value="${item.sum_7_dru_old}" type="percent"/></td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="panel panel-primary">
    <div class="panel-heading">曲线图 （总和，新服，老服）</div>
    <div style="height: 300px;line-height: 300px">
        <div class="highchart-daysActive" style="height: 300px"></div>
        <table class="highchart table"
               data-graph-container=".highchart-daysActive" data-graph-type="line" data-graph-xaxis-reversed="1"
               data-graph-yaxis-1-title-text='注册人数' data-graph-zoom-type="xy" style="display: none">
            <caption>曲线图 （总和，新服，老服）</caption>
            <thead>
            <tr>
                <th>日期</th>
                <th>总留存率</th>
                <th>新服留存率</th>
                <th>老服留存率</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${sevenDaysRemainer}" var="item">
                <tr>
                    <td>${item.log_day}</td>
                    <td>${item.sum_dru}</td>
                    <td>${item.sum_dru_new}</td>
                    <td>${item.sum_dru_old}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>


<script type="text/javascript">
    $(document).ready(function () {
        $('table.highchart').highchartTable();
    });
</script>

</body>
</html>