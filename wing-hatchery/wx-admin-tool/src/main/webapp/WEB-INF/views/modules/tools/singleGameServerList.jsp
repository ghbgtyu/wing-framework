<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>游戏服务器列表</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">
        function page(){
            $("#searchForm").attr("action","${ctx}/tools/gameServer/selectSingleGameServer");
            $("#searchForm").submit();
            return false;
        }
    </script>
    <style>
        .selected{background-color:#ae0!important}
    </style>
</head>
<body>
    <form:form id="searchForm" modelAttribute="gameServer" action="${ctx}/tools/gameServer/selectSingleGameServer" method="post" class="breadcrumb form-search">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <label>游戏平台：</label>
        <form:select path="gamePlatform.id">
            <%--<form:option value="" label="Please Select"/>--%>
            <form:options items="${fns:getGamePlatformList()}" itemLabel="name" itemValue="id" htmlEscape="false" cssClass="required"/>
        </form:select>
        <label>服务器编号</label>
        <form:input path="serverId" htmlEscape="false" class="input-small"/>

        &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
    </div>
    </form:form>
    <table id="contentTable" class="table table-bordered table-condensed">
        <thead><tr><th hidden="hidden"><input type="checkbox" id="selectall" name="selectall"/></th><th>所属平台</th><th>服务器编号</th><th>服务器名称</th><th>描述</th><th>开服时间</th></tr></thead>
        <tbody>
        <c:forEach items="${page.list}" var="gameServer" varStatus="status">
            <tr>
                <td align="center" hidden="hidden"><input type="checkbox" class="case" name="case" value="${status.index + 1}"/></td>
                <td>${gameServer.gamePlatform.name}</td>
                <td>${gameServer.serverId}</td>
                <td>${gameServer.serverName}</td>
                <td>${gameServer.description}</td>
                <td>${gameServer.serverOpenTime}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagination">${page}</div>

<script type="text/javascript">

    var selectedGameServerId;
    var selectedGameServerName;
    var selectedGamePlatformName;

    $(function(){

        $("#contentTable > tbody > tr").click(function(){
            removeAllSelected();
            $(this).addClass("selected");
            selectedGamePlatformName = $(this).children("td").get(1).innerHTML;
            selectedGameServerId = $(this).children("td").get(2).innerHTML;
            selectedGameServerName = $(this).children("td").get(3).innerHTML + '【'+selectedGameServerId+'】';
        });


//        // add multiple select / deselect functionality
//        $("#selectall").click(function () {
//            $('.case').attr('checked', this.checked);
//        });
//
//        $(".case").click(function(){
//            if($(".case").length == $(".case:checked").length) {
//                $("#selectall").attr("checked", "checked");
//            } else {
//                $("#selectall").removeAttr("checked");
//            }
//
//        });
    });

    function removeAllSelected(){
        $("#contentTable > tbody > tr").each(function(){
            $(this).removeClass("selected");
        });
    }

</script>
</body>
</html>
