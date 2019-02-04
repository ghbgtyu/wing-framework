<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>充值区间分布</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/global/rechargeConsume/rechargeDistribution">充值区间分布</a></li>
</ul>
<form id="searchForm" action="${ctx}/global/rechargeConsume/rechargeDistribution" method="post"
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
<div class="container-fluid">
    <div class="row-fluid">
        <div class="panel panel-primary">
            <div class="panel-heading">充值区间分布</div>
            <div style="height: 300px;line-height: 300px">
                <div class="highchart-income" style="height: 300px"></div>
                <table class="highchart table"
                       data-graph-container=".highchart-income" data-graph-type="column"
                       data-graph-yaxis-1-title-text='人数' data-graph-yaxis-2-title-text='总额'
                       data-graph-zoom-type="xy" data-graph-yaxis-2-opposite="1" style="display: none">
                    <caption>充值区间分布</caption>
                    <thead>
                    <tr>
                        <th>区间</th>
                        <th data-graph-type="column">充值用户</th>
                        <th data-graph-type="line" data-graph-yaxis="1">充值总额</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${resultList}" var="item">
                        <tr>
                            <td>${item.section}</td>
                            <td>${item.num}</td>
                            <td>${item.amount}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <div class="panel panel-primary" style="overflow: scroll">
        <div class="panel-heading">充值金额区间分布</div>
        <table id="contentTable" class="datatable table table-striped table-bordered table-condensed"
               style="overflow: scroll">
            <thead>
            <tr>
                <th>日期</th>
                <th>【0,9】</th>
                <th>【10,19】</th>
                <th>【20,29】</th>
                <th>【30,49】</th>
                <th>【50,69】</th>
                <th>【70,99】</th>
                <th>【100,199】</th>
                <th>【200,299】</th>
                <th>【300,399】</th>
                <th>【400,499】</th>
                <th>【500,699】</th>
                <th>【700,999】</th>
                <th>【1000,1499】</th>
                <th>【1500,1999】</th>
                <th>【2000,2499】</th>
                <th>【2500,2999】</th>
                <th>【3000,3999】</th>
                <th>【4000,4999】</th>
                <th>【5000,6999】</th>
                <th>【7000,9999】</th>
                <th>【10000,19999】</th>
                <th>【20000,49999】</th>
                <th>【50000,99999】</th>
                <th>【100000,199999】</th>
                <th>【200000,∞】</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${tableList}" var="item">
                <tr>
                    <td>${item.log_day}</td>
                    <td>${item.amount1}</td>
                    <td>${item.amount2}</td>
                    <td>${item.amount3}</td>
                    <td>${item.amount4}</td>
                    <td>${item.amount5}</td>
                    <td>${item.amount6}</td>
                    <td>${item.amount7}</td>
                    <td>${item.amount8}</td>
                    <td>${item.amount9}</td>
                    <td>${item.amount10}</td>
                    <td>${item.amount11}</td>
                    <td>${item.amount12}</td>
                    <td>${item.amount13}</td>
                    <td>${item.amount14}</td>
                    <td>${item.amount15}</td>
                    <td>${item.amount16}</td>
                    <td>${item.amount17}</td>
                    <td>${item.amount18}</td>
                    <td>${item.amount19}</td>
                    <td>${item.amount20}</td>
                    <td>${item.amount21}</td>
                    <td>${item.amount22}</td>
                    <td>${item.amount23}</td>
                    <td>${item.amount24}</td>
                    <td>${item.amount25}</td>
                </tr>
            </c:forEach>
            <tr>
                <td>总计</td>
                <c:forEach items="${totalAmountList}" varStatus="status">
                    <td>${totalAmountList[status.index]}</td>
                </c:forEach>
            </tr>
            </tbody>
        </table>
    </div>


    <div class="panel panel-primary" style="overflow: scroll">
        <div class="panel-heading">充值人数区间分布</div>
        <table id="contentTable" class="datatable table table-striped table-bordered table-condensed"
               style="overflow: scroll">
            <thead>
            <tr>
                <th>日期</th>
                <th>【0,9】</th>
                <th>【10,19】</th>
                <th>【20,29】</th>
                <th>【30,49】</th>
                <th>【50,69】</th>
                <th>【70,99】</th>
                <th>【100,199】</th>
                <th>【200,299】</th>
                <th>【300,399】</th>
                <th>【400,499】</th>
                <th>【500,699】</th>
                <th>【700,999】</th>
                <th>【1000,1499】</th>
                <th>【1500,1999】</th>
                <th>【2000,2499】</th>
                <th>【2500,2999】</th>
                <th>【3000,3999】</th>
                <th>【4000,4999】</th>
                <th>【5000,6999】</th>
                <th>【7000,9999】</th>
                <th>【10000,19999】</th>
                <th>【20000,49999】</th>
                <th>【50000,99999】</th>
                <th>【100000,199999】</th>
                <th>【200000,∞】</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${tableList}" var="item">
                <tr>
                    <td>${item.log_day}</td>
                    <td>${item.num1}</td>
                    <td>${item.num2}</td>
                    <td>${item.num3}</td>
                    <td>${item.num4}</td>
                    <td>${item.num5}</td>
                    <td>${item.num6}</td>
                    <td>${item.num7}</td>
                    <td>${item.num8}</td>
                    <td>${item.num9}</td>
                    <td>${item.num10}</td>
                    <td>${item.num11}</td>
                    <td>${item.num12}</td>
                    <td>${item.num13}</td>
                    <td>${item.num14}</td>
                    <td>${item.num15}</td>
                    <td>${item.num16}</td>
                    <td>${item.num17}</td>
                    <td>${item.num18}</td>
                    <td>${item.num19}</td>
                    <td>${item.num20}</td>
                    <td>${item.num21}</td>
                    <td>${item.num22}</td>
                    <td>${item.num23}</td>
                    <td>${item.num24}</td>
                    <td>${item.num25}</td>
                </tr>
            </c:forEach>
            <tr>
                <td>总计</td>
                <c:forEach items="${totalNumList}" varStatus="status">
                    <td>${totalNumList[status.index]}</td>
                </c:forEach>
            </tr>
            </tbody>
        </table>
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