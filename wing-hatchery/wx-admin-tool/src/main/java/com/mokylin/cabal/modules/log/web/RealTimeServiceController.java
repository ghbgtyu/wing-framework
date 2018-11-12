package com.mokylin.cabal.modules.log.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.redis.RedisManager;
import com.mokylin.cabal.common.redis.Server;
import com.mokylin.cabal.common.redis.ServerManager;
import com.mokylin.cabal.common.utils.DateUtils;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.web.BaseController;


@Controller
@RequestMapping(value = "${adminPath}/log/realTimeService")
public class RealTimeServiceController extends BaseController{
    /**
     * 实时分服统计
     */
    @RequestMapping( value =  "realTimeServiceReport")
    public String realTimeServiceReport(HttpServletRequest request,HttpServletResponse response, Model model){
    	MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
    	String createDateStart = MapUtils.getString(parameter, "createDateStart");
    	//如果日期为空,则直接获取当前时间的小时段
    	if (StringUtils.isEmpty(createDateStart)){
    		parameter.put("createDateStart",DateUtils.getDate("yyyy-MM-dd HH"));
    	}
    	Page<Map<String,Object>> page = logPaging(request, response, "statRealTimeService.findRealTimeServiceReport");
    	for (Map<String,Object> map : page.getList()) {
    		String  log_minute = MapUtils.getString(map, "log_minute");
			if(null!=log_minute&&log_minute.length()==12){
				map.put("log_minute", log_minute.substring(0, 4)+"-"+log_minute.substring(4,6)+"-"+log_minute.substring(6, 8)+" "+log_minute.substring(8, 10)+":"+log_minute.substring(10, 12)+":00");
			}
		}
    	model.addAttribute("page",page);
//    	RedisManager redisManager =new RedisManager("192.168.1.27", 6379, 2);
//    	List<Server> ss =redisManager.getServerList("game");
//    	ss.get(0).setStatus(1);
//		parameter.put("server", ss.get(0));
//		toolDaoTemplate.update("gameServer.update",parameter);
    	return "modules/logs/realTimeServiceReport";
    }
}
