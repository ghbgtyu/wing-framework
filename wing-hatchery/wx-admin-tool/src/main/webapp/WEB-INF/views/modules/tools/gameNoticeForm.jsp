<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>新增公告</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#content").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {

                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

        });

    </script>
    <style type="text/css">
        td#cke_contents_content {
            height: 158px !important;
        }

        span#cke_content {
            width: 60% !important;
            /* height: 200px; */
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/tools/gameNotice/">公告列表</a></li>
    <shiro:hasPermission name="game.notice.edit">
        <li class="active"><a
                href="${ctx}/tools/gameNotice/form?id=${gameNotice.id}">${not empty gameNotice.id?'修改':'添加'}公告</a></li>
    </shiro:hasPermission>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="gameNotice" action="${ctx}/tools/gameNotice/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <tags:message content="${message}"/>

    <div class="control-group">
        <label class="control-label">公告类型:</label>
        <div class="controls">
            <form:select path="noticeType">
                <form:options items="${fns:getDictList('notice_type')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">公告内容:</label>
        <div class="controls">
            <form:textarea path="content" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge required"/>
            <tags:ckeditor replace="content"/>
        </div>
    </div>
    <%--<div class="control-group">--%>
    <%--<label class="control-label">公告超链接:</label>--%>
    <%--<div class="controls">--%>
    <%--<input id="content.href" name="content.href" class="input-small"/>--%>
    <%--</div>--%>
    <%--</div>--%>
    <div class="control-group">
        <label class="control-label">有效时间:</label>
        <div class="controls">
            <input name="startTime" id="startTime" maxlength="50" class="input-small required" readonly="readonly"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"/>
            -
            <input name="finishTime" maxlength="50" class="input-small required" readonly="readonly"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'startTime\')}'})"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">间隔时间:</label>
        <div class="controls">
            <input name="stepTime" id="stepTime" htmlEscape="false" class="digits required"/>
            <span class="label badge-info help-inline">单位为分钟</span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">区服:</label>
        <div class="controls">
            <shiro:hasGlobalRoleTag>
                <input type="radio" name="isGlobal" value="1" onclick="$('#gameServerTreeDiv').hide()">全部服务器
            </shiro:hasGlobalRoleTag>
            <input type="radio" name="isGlobal" value="0" checked="checked" onclick="$('#gameServerTreeDiv').show()">指定服务器

        </div>
        <div class="controls" id="gameServerTreeDiv">
            <input id="serverIds" name="serverIds" readonly/><input type="button" class="btn btn-primary" value="选择服务器"
                                                                    onclick="openSeverDialog()"></button>
        </div>
    </div>

    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>

</body>
</html>