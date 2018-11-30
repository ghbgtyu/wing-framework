<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新增公告</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
    <script type="text/javascript">

        $(document).ready(function() {
            $("#content").focus();
            $("#inputForm").validate({
                submitHandler: function(form){

                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

        });
  </script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li>
		<a href="${ctx}/tools/gameConfig/">配置列表</a></li>
		<li class="active"><a href="${ctx}/tools/gameConfig/form?id=${configFile.id}">${not empty configFile.id?'修改':'添加'}配置</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="configFile" action="${ctx}/tools/gameConfig/save" method="post" class="form-horizontal" enctype="multipart/form-data">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>

		<div class="control-group">
			<label class="control-label">文件:</label>
			<div class="controls">
                <input type="file" name="file" class="required"/>
			</div>
		</div>
        
        <div class="control-group">
            <label class="control-label">配置文件名:</label>
            <div class="controls">
                <select name="fileName">
                    <c:forEach items="${fileMap}" var="map" varStatus="status">
                       <option value="${map.key}"
                         <c:if test="${map.key == configFile.newName }"> 
                         selected="selected"</c:if>
                         
                       >${map.value}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">描述信息:</label>
            <div class="controls">
                <form:textarea path="fileDesc" htmlEscape="false" rows="3" maxlength="100" class="input-xlarge"/>
            </div>
        </div>


		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit"  value="${empty configFile.id?'保存':'修改'}"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>

</body>
</html>