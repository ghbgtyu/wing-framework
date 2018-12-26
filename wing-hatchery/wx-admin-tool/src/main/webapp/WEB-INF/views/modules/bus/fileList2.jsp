<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>




<html>
<head>
	<title>归档合同列表</title>
	<meta name="decorator" content="default"/>

	<%@include file="/WEB-INF/views/include/dialog.jsp" %>
	<style type="text/css">.sort{color:#0663A2;cursor:pointer;}</style>
	<script type="text/javascript">
        $(document).ready(function() {
            // 表格排序
            var orderBy = $("#orderBy").val().split(" ");
            $("#contentTable th.sort").each(function(){
                if ($(this).hasClass(orderBy[0])){
                    orderBy[1] = orderBy[1]&&orderBy[1].toUpperCase()=="DESC"?"down":"up";
                    $(this).html($(this).html()+" <i class=\"icon icon-arrow-"+orderBy[1]+"\"></i>");
                }
            });
            $("#contentTable th.sort").click(function(){
                var order = $(this).attr("class").split(" ");
                var sort = $("#orderBy").val().split(" ");
                for(var i=0; i<order.length; i++){
                    if (order[i] == "sort"){order = order[i+1]; break;}
                }
                if (order == sort[0]){
                    sort = (sort[1]&&sort[1].toUpperCase()=="DESC"?"ASC":"DESC");
                    $("#orderBy").val(order+" DESC"!=order+" "+sort?"":order+" "+sort);
                }else{
                    $("#orderBy").val(order+" ASC");
                }
                page();
            });
            $("#btnExport").click(function(){
                top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
                    if(v=="ok"){
                        $("#searchForm").attr("action","${ctx}/sys/user/export");
                        $("#searchForm").submit();
                    }
                },{buttonsFocus:1});
                top.$('.jbox-body .jbox-icon').css('top','55px');
            });
            $("#btnImport").click(function(){
                $.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
                    bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
            });
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctx}/sys/user/");
            $("#searchForm").submit();
            return false;
        }
	</script>


</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/bus/file/list2">归档合同列表</a></li>

	</ul>
	<tags:message content="${message}"/>

	<form id="searchForm" action="${ctx}/bus/file/list2" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>合同标题 ：</label>
		<input id="file-content" name="file-content" type="text" />
		<label>合同号 ：</label>
		<input id="file-fileId" name="file-fileId" type="text" />
		<label>时间 ：</label>
		<input type="text" name="createDateStart" class="input-small" readonly="readonly" maxlength="20"  id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createDateEnd"   class="input-small" readonly="readonly"  id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
		&nbsp;

		<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" />
	</form>


	<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover">
		<thead>
		<tr>

			<th class="sort title">合同标题</th>
			<th>合同号</th>
			<th>备注</th>
			<th>创建日期</th>
			<th>创建者</th>
			<th>预览</th>
<shiro:hasPermission name="bus:file:upload"><th>操作</th></shiro:hasPermission>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="busFile">
			<tr>
				<td>${busFile.content}</td>
				<td>${busFile.fileId}</td>
				<td>${busFile.uploadDesc}</td>
				<td><fmt:formatDate value="${busFile.createDate}" type="both"/></td>
				<td>${busFile.createBy.name}</td>


				<th>
					<a href="#" onclick="return openUploadViewDialog2('${busFile.id}','${busFile.fileId}')"> 预览合同文件</a>

				</th>
				<shiro:hasPermission name="bus:file:upload"><td>

					<a href="${ctx}/bus/file/remove?id=${busFile.id}&fileId=${busFile.fileId}" onclick="return confirmx('移除后合同将变为预处理状态，确认要把合同移除吗？', this.href)">移除</a>
				</td>
				</shiro:hasPermission>



			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>

<script>



</script>