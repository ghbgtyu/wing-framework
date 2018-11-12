<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')}</title>
	<%@include file="/WEB-INF/views/include/dialog.jsp" %>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		#main {padding:0;margin:0;} #main .container-fluid{padding:0 7px 0 10px;}
		#header {margin:0 0 10px;position:static;} #header li {font-size:14px;_font-size:12px;}
		#header .brand {font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:26px;padding-left:43px;}
		#footer {margin:8px 0 0 0;padding:3px 0 0 0;font-size:11px;text-align:center;border-top:2px solid #0663A2;}
		#footer, #footer a {color:#999;}
        .btn_private {
            background: linear-gradient(to bottom, #ff782c 0%, #f86325 100%) repeat scroll 0 0 rgba(0, 0, 0, 0);
            color: #fff;
            font: bold 12px/32px "microsoft yahei";
            text-align: center;
            border-radius:3px;
            margin: 4px;
            cursor: pointer;
			padding: 2px 2px;
        }
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#menu a.menu").click(function(){
				$("#menu li.menu").removeClass("active");
				$(this).parent().addClass("active");
				if(!$("#openClose").hasClass("close")){
					$("#openClose").click();
				}
			});
		});
        function selectServer(){
            top.$.jBox.open("iframe:${ctx}/tools/gameArea/selectSingleGameServer", "选择游戏服务器(单选)",810,$(top.document).height()-240,{
                buttons:{"确定":"ok", "关闭":true}, bottomText:"通过选择平台，查询出游戏服务器。",submit:function(v, h, f){
                    var selectedGameServerId = h.find("iframe")[0].contentWindow.selectedGameServerId;
                    var selectedGameServerName = h.find("iframe")[0].contentWindow.selectedGameServerName;

                    if (v=="ok"){
                        //loading('正在提交，请稍等...');
                        //$("#changeGameServerForm").attr('action','${ctx}/tools/gameArea/changeGameServer?gameServerId='+selectedGameServerId+"&gameSeverName="+selectedGameServerName).submit();
                        _remoteCall("${ctx}/tools/gameArea/changeGameServer",{gameServerId:selectedGameServerId,gameServerName:selectedGameServerName},function(result){
                                if(result.success){
									top.$.jBox.tip('切换服务器成功', 'success');
                                    $("#currentGameServer").html(result.data)
                                }
                        });

                        return true;
                    }
                }, loaded:function(h){
                    $(".jbox-content", top.document).css("overflow-y","hidden");
                }
            });
        }
	</script>
</head>
<body>
	<div id="main">
		<div id="header" class="navbar navbar-fixed-top">
		  <%--<div class="navbar-inner navbar-black">--%>
			  <%--<img src="${ctxStatic}/images/lingyu-logo.jpg" width="246px" height="103px"/>--%>
		  <%--</div>--%>
	      <div class="navbar-inner">
			  <div class="brand"><img src="${ctxStatic}/images/logo.png"/></div>
			 <%--<div class="brand">${fns:getConfig('productName')}</div>--%>
	         <div class="nav-collapse">
	           <ul id="menu" class="nav">
				 <c:set var="firstMenu" value="true"/>
				 <c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
					<c:if test="${menu.parent.id eq '1' && menu.isShow eq '1'}">
						<li class="menu ${firstMenu ? ' active' : ''}"><a class="menu" href="${ctx}/sys/menu/tree?parentId=${menu.id}" target="menuFrame" ><spring:message code="${menu.internationalKey}"/></a></li>
						<c:if test="${firstMenu}">
							<c:set var="firstMenuId" value="${menu.id}"/>
						</c:if>
						<c:set var="firstMenu" value="false"/>
					</c:if>
				 </c:forEach>
				 <%--<shiro:hasPermission name="cms:site:select">--%>
					<%--<li class="dropdown">--%>
						<%--<a class="dropdown-toggle" data-toggle="dropdown" href="#">${fnc:getSite(fnc:getCurrentSiteId()).name}<b class="caret"></b></a>--%>
						<%--<ul class="dropdown-menu">--%>
						<%--<c:forEach items="${fnc:getSiteList()}" var="site"><li><a href="${ctx}/cms/site/select?id=${site.id}&flag=1">${site.name}</a></li></c:forEach>--%>
						<%--</ul>--%>
					<%--</li>--%>
				 <%--</shiro:hasPermission>--%>
	           </ul>
	           <ul class="nav pull-right">

                   <%--<li id="lanSwitch" class="dropdown">--%>
                       <%--<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="<spring:message code='language.change'/>"><spring:message code='language'/></a>--%>
                       <%--<ul class="dropdown-menu">--%>
                           <%--<li><a href="?locale=zh_CN">中文</a></li>--%>
                           <%--<li><a href="?locale=en_US">English</a></li>--%>
                       <%--</ul>--%>
                 <%--</li>--%>
                       <li>
                 <div class="btn_private" style="width:120px" onclick="selectServer()" id="currentGameServer"><c:choose><c:when test="${not empty currentGameServerName}">${currentGameServerName}</c:when><c:otherwise>游戏服务器</c:otherwise></c:choose></div>
                       </li>
                 

			  	 <li id="themeSwitch" class="dropdown">
			       	<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="<spring:message code='theme.switch'/>"><i class="icon-th-large"></i></a>
				    <ul class="dropdown-menu">
				      <c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
				    </ul>
				    <!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]-->
			     </li>
			  	 <li class="dropdown">
				    <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="个人信息"><spring:message code="Hello"/> , <shiro:principal property="loginName"/></a>
				    <ul class="dropdown-menu">
				      <li><a href="${ctx}/sys/user/info" target="mainFrame"><i class="icon-user"></i>&nbsp; <spring:message code="person.info"/></a></li>
				      <li><a href="${ctx}/sys/user/modifyPwd" target="mainFrame"><i class="icon-lock"></i>&nbsp;  <spring:message code="modify.passwod"/></a></li>
				    </ul>
			  	 </li>
			  	 <li><a href="${ctx}/logout" title="<spring:message code="logout"/>">Logout</a></li>
			  	 <li>&nbsp;</li>
	           </ul>
	         </div><!--/.nav-collapse -->
	      </div>
	    </div>
        <tags:message content="${message}"/>
        <form id="changeGameServerForm" action="" method="post" class="hide"></form>
	    <div class="container-fluid">
			<div id="content" class="row-fluid">
				<div id="left">
					<iframe id="menuFrame" name="menuFrame" src="${ctx}/sys/menu/tree?parentId=${firstMenuId}" style="overflow:visible;"
						scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
				</div>
				<div id="openClose" class="close">&nbsp;</div>
				<div id="right">
					<iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;"
						scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
				</div>
			</div>
		    <div id="footer" class="row-fluid">
	            Copyright &copy; 2012-${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')} - Powered By <a href="https://github.com/mokylin/cabal" target="_blank">Cabal</a> ${fns:getConfig('version')}
                <div class="pull-right">
                    <a href="?locale=zh_CN">中文</a> |
                    <a href="?locale=en_US">English</a>
                </div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var leftWidth = "180"; // 左侧窗口大小
		function wSize(){
			var minHeight = 500, minWidth = 980;
			var strs=getWindowSize().toString().split(",");
			$("#menuFrame, #mainFrame, #openClose").height((strs[0]<minHeight?minHeight:strs[0])-$("#header").height()-$("#footer").height()-32);
			$("#openClose").height($("#openClose").height()-5);
			if(strs[1]<minWidth){
				$("#main").css("width",minWidth-10);
				$("html,body").css({"overflow":"auto","overflow-x":"auto","overflow-y":"auto"});
			}else{
				$("#main").css("width","auto");
				$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
			}
			$("#right").width($("#content").width()-$("#left").width()-$("#openClose").width()-5);
		}

        function changeGamePlatform(name){
            $("#current_game_platform").html('<spring:message code='platform'/>:'+name);
        }
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>