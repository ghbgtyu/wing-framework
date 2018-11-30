<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>聊天监控</title>
    <meta name="decorator" content="default"/>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/game/chat/monitor">玩家聊天监控</a></li>
</ul>
<form id="searchForm"  action="${ctx}/game/chat/monitor" method="post" class="breadcrumb form-search">

    <div>
        <label>服务器:</label>
        <input id="serverIds" name="serverIds" readonly/><input type="button" class="btn btn-primary" value="选择服务器" onclick="openSeverDialog();"/>
		<shiro:hasPermission name="game.chatmonitor.monitor">
        &nbsp;<input id="btnMonitor" class="btn btn-primary" type="button" value="开始监控" onclick="monitor();"/>		
        &nbsp;<input id="btnCancelMonitor" class="btn btn-danger" type="button" value="取消监控" onclick="cancelMonitor();"/>
		</shiro:hasPermission>
		<shiro:hasPermission name="game.chatmonitor.keyWordsEdit">
        &nbsp;<input id="addkeyWords" class="btn btn-primary" type="button" value="添加关键字" onclick="addKeyWords();"/>
		</shiro:hasPermission>
     </div>
</form>
<div id="keyword" class="row-fluid span12">
    <div class="span4 panel panel-primary">
        <div class="panel-heading">当前监控关键字</div>
        <%--<div class="panel-body">--%>
        <table id="contentTable" class="table table-striped table-bordered table-condensed">

            <%--<tr>--%>
                <%--<th>关键字</th><td>keyword_01</td><td><a href="${ctx}/game/chat/deleteKey?keyword=keyword_1" onclick="return confirmx('确认要删除该关键字吗？', this.href)">删除</a></td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th>关键字</th><td>keyword_01</td><td><a href="${ctx}/game/chat/deleteKey?keyword=keyword_1" onclick="return confirmx('确认要删除该关键字吗？', this.href)">删除</a></td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th>关键字</th><td>keyword_01</td><td><a href="${ctx}/game/chat/deleteKey?keyword=keyword_1" onclick="return confirmx('确认要删除该关键字吗？', this.href)">删除</a></td>--%>
            <%--</tr>--%>
            <c:forEach var="keyword" items="${keywords}">
                <tr id="${keyword.key}">
                    <th>关键字</th><td>${keyword.value}</td>
					<shiro:hasPermission name="game.chatmonitor.keyWordsEdit">
					<td><a href="#" onclick="deleteKey('确认要删除该关键字吗？', '${ctx}/game/chat/deleteKey?keyword=${keyword.key}', ${keyword.key})">删除</a></td>
					</shiro:hasPermission>
                </tr>
            </c:forEach>

        </table>
        <%--</div>--%>
    </div>
    <div class="span8 alert alert-warning">
        1、监控服务器选择请不要大于5<br/>
        2、添加关键字，删除关键字系统将自动取消监控，重新监控需要重新点击"开始监控"按钮
        3、点击监控窗口2的角色名，可以禁言角色<br/>
        4、监控关键字可随时添加<br/>
        5、聊天监控封禁的记录在 禁言封号日志中统一显示为“监控封禁”
    </div>
</div>

<div id="monitor" class="row-fluid span8">
    <div class="panel panel-primary span4">
        <div class="panel-heading">监控窗口1</div>
        <div class="panel-body">
            <div id = "content_1" style = "overflow:scroll; height: 300px; width: 100%;"></div>
        </div>
    </div>

    <div class="panel panel-primary span4">
        <div class="panel-heading">监控窗口2</div>
        <div class="panel-body">
            <div id = "content_2" style = "overflow:scroll; height: 300px; width: 100%; "></div>
        </div>
    </div>

</div>

<div class="pagination">${page}</div>

<script type="text/javascript">

    $(document).ready(function() {
        $('#btnCancelMonitor').hide();
    })

    function jinYan(serverId,roleId){
        ajaxRequest("确认禁言该角色?","${ctx}/game/role/jinYan",{serverId:serverId,roleId:roleId});
    }

    function getDate(serverIds){
        _remoteCall("${ctx}/game/chat/fetchData",{serverIds:serverIds},function(result){
            if(result.success){
            	
                var obj = result.data;
                var content1_his = $("#content_1").html();
                var content2_his = $("#content_2").html();

                $("#content_1").html(content1_his + obj.monitor1);
                $("#content_2").html(content2_his + obj.monitor2);

            }else{
                top.$.jBox.tip("后台报错啦！找管理员问问", 'error');
            }
        })
    }

    function monitor(){
        $('#btnMonitor').val('监控中...').attr({"disabled":"disabled"});
        $("#btnCancelMonitor").show();
        var serverIds = $('#serverIds').val();

        if(serverIds == null){
            top.$.jBox.tip("请先选择服务器！", 'error');
            return;
        }
        //告知游戏开始监控啦
        startMonitor(serverIds);
        setInterval(startMonitor,6000*10*10,serverIds);    //10分钟通知游戏监控

        setInterval(getDate,1000,serverIds)       //5秒循环执行一次,获取监控数据
    }


    function startMonitor(serverIds){
        _remoteCall("${ctx}/game/chat/startMonitor",{serverIds:serverIds},function(result){
            if(result.success){
               top.$.jBox.tip("已经通知游戏服开始监控", 'success');
            }
        })
    }

    function cancelMonitor(){

        var serverIds = $('#serverIds').val();
        _remoteCall("${ctx}/game/chat/cancelMonitor",{serverIds:serverIds},function(result){
            if(result.success){
                top.$.jBox.tip('取消监控成功!', 'success');
            }else{

                top.$.jBox.tip(result.data, 'error');
                return false;
            }
        })

        $('#btnCancelMonitor').hide();
        $('#btnMonitor').val('开始监控').removeAttr("disabled");

    }


    function deleteKey(msg,href,id){

        var submit = function (v, h, f) {
            if (v == 'ok') {
                _remoteCall(href,null,function(result) {
                    if (result.success) {
                        top.$.jBox.tip('删除关键字成功', 'success');
                        $("#"+id).remove();
                        //删除关键字成功之后应该取消监控,因为关键字发生变化，游戏服不会重新抓取新的关键字列表
                        //cancelMonitor();
                    }
                });
            }
            else if (v == 'cancel') {
                top.jBox.tip(v, 'info');
            }
            return true; //close
        };

        top.$.jBox.confirm(msg, "系统提示", submit);
    }

    function addKeyWords(){
        var value = '';
        top.$.jBox.confirm("确定添加?","系统提示",function(v,h,f){
            if(v=="ok"){
                var html = "<div style='padding:10px;'>关键字：<input type='text' id='keyword_value' name='keyword_value' class='required' /></div>";
                var submit = function (v, h, f) {
                    if (f.keyword_value == '') {
                        top.$.jBox.tip("请输入关键字!!!", 'error', { focusId: "keyword_value" }); // 关闭设置 reason 为焦点
                        return false;
                    }
                    value = f.keyword_value;

                    var dateIndex = $('#contentTable tr').length + 1;
                    var keyword_key = ('keyword_'+dateIndex+Math.random()).replace('.','');

                    //$('#contentTable').append("<tr><th>关键字</th><td>"+value+"</td><td><a href=\"${ctx}/game/chat/deleteKey?keyword="+keyword_key+"\" onclick=\"return confirmx('确认要删除该关键字吗？', this.href)\">删除</a></td></tr>");

                    _remoteCall("${ctx}/game/chat/addKeyword",{key:keyword_key,keyword:value},function(result){
                        if(result.success){
                            $('#contentTable').append("<tr id="+keyword_key+"><th>关键字</th><td>"+value+"</td><td><a href='#' onclick=\"deleteKey('确认要删除该关键字吗？', \'${ctx}/game/chat/deleteKey?keyword="+keyword_key+"\',\'"+keyword_key+"\')\">删除</a></td></tr>");
                            top.$.jBox.tip('添加关键字成功', 'success');
//                            if($('#btnMonitor').isDisabled) {
//                                cancelMonitor();
//                            }
                        }
                    })

                    return true;
                };

                top.$.jBox(html, { title: "添加关键字", submit: submit });
            }
        },{buttonsFocus:1});
        top.$('.jbox-body .jbox-icon').css('top','55px');

    }
</script>

</body>
</html>
