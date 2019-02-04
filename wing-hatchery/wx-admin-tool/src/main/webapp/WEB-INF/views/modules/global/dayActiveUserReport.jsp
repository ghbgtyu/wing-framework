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
    <li class="active"><a href="${ctx}/global/dashboard/dayActiveUserReport">日活跃总数</a></li>
</ul>
<form id="searchForm" action="${ctx}/global/dashboard/dayActiveUserReport" method="post" class="breadcrumb form-search">
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
            <div class="panel-heading">日活跃总数</div>
            <div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
                <table id="contentTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th>服务器总数</th>
                        <th>活跃总数</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${dayActive}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.sum_servernum}</td>
                            <td>${item.sum_dau}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <table class="table table-striped table-bordered table-condensed">
                <tr>
                    <td>总计:</td>
                    <td>所选时间段:${createDateStart}至${createDateEnd}</td>
                    <td>日期数:${betweenDays}天</td>
                    <td>服务器总数:${serverNum}个</td>
                    <td>活跃用户总数:${activeNum}</td>
                </tr>
            </table>
        </div>

        <div class="span6 panel panel-primary">
            <div class="panel-heading">服务器日活跃数统计</div>
            <div class="" style="width:100%;height:325px;line-height:300px;overflow:auto;overflow-x:hidden;">
                <table id="contentTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th>平台名</th>
                        <th>服务器</th>
                        <th>日活跃用户数</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${dayServerActive}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
                            <td>${item.area_id}</td>
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
            <div class="panel-heading">日活跃条形图</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-daysActive" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-daysActive" data-graph-type="column"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='人数' data-graph-zoom-type="xy" style="display: none">
                    <caption>日活跃</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th data-graph-type="line">人数</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${dayActive}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.sum_dau}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="span6 panel panel-primary">
            <div class="panel-heading">日活跃周对比条形图</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-weekComActive" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-weekComActive" data-graph-type="line"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='活跃人数' style="display: none">
                    <caption>日活跃周对比</caption>
                    <thead>
                    <tr>
                        <th>星期</th>
                        <th>本周活跃人数</th>
                        <th>上周活跃人数</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${weekComparison}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.now_sum_dau}</td>
                            <td>${item.sum_dau}</td>
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
            <div class="panel-heading">日活跃月对比条形图</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-monthActive" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-monthActive" data-graph-type="spline"
                       data-graph-xaxis-reversed="1"
                       data-graph-yaxis-1-title-text='活跃人数' style="display: none">
                    <caption>日活跃月对比</caption>
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th>本月活跃人数</th>
                        <th>上月活跃人数</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${monthComparison}" var="item">
                        <tr>
                            <td>${item.log_day}</td>
                            <td>${item.now_sum_dau}</td>
                            <td>${item.sum_dau}</td>
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