package com.mokylin.cabal.modules.global.web;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.utils.DateUtils;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.web.BaseController;

@Controller
@RequestMapping(value = "${adminPath}/global/newRegisterStatistics")
public class NewRegisterStatisticsController extends BaseController{
    @RequestMapping( value =  "newRegisterStatisticsReport")
    public String newRegisterStatisticsReport(HttpServletRequest request,HttpServletResponse response, Model model){
    	//新注册总量时点分布
    	MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
    	String createDateStart = MapUtils.getString(parameter, "createDateStart");
    	if (StringUtils.isEmpty(createDateStart)) {
    		parameter.put("createDateStart", DateUtils.formatDate(DateUtils.addDays(new Date(), -1)));
    	}
    	setServerIdList(parameter);
    	List<Map<String,Object>> newRegister = logDaoTemplate.selectList("statRealTimeService.findNewRegister",parameter);
    	model.addAttribute("newRegister", newRegister);
    	//服务器新注册统计
    	List<Map<String,Object>> serverNewRegister = logDaoTemplate.selectList("statRealTimeService.findServerNewRegister", parameter);
    	model.addAttribute("serverNewRegister", serverNewRegister);
    	//服务器新注册统计汇总
    	Set pidNum=new HashSet();
    	Set serverNum=new HashSet();
    	int sumRu=0;
    	for (Map<String,Object> map : serverNewRegister) {
    		pidNum.add(MapUtils.getString(map, "pid"));
    		serverNum.add(MapUtils.getString(map, "area_id"));
    		sumRu+=MapUtils.getIntValue(map, "sum_register");
		}
    	model.addAttribute("pidNum", pidNum.size());
    	model.addAttribute("serverNum", serverNum.size());
    	model.addAttribute("sumRu", sumRu);
    	//周对比
    	createDateStart = MapUtils.getString(parameter, "createDateStart");
    	parameter.put("createDateStart",  DateUtils.formatDate(DateUtils.addDays(DateUtils.parseDate(createDateStart), -7)));
    	Page<Map<String,Object>> newRegisterWeekBefore = logPaging(request, response, "statRealTimeService.findNewRegister");
    	for (Map<String,Object> map : newRegister) {
    		for (Map<String,Object> mapWeekBefore : newRegisterWeekBefore.getList()) {
    			if(MapUtils.getInteger(map, "log_hour").intValue()==MapUtils.getInteger(mapWeekBefore, "log_hour").intValue()){
    				map.put("sum_register_weekbefore", MapUtils.getInteger(mapWeekBefore, "sum_register"));
    				break;
    			}else{
    				map.put("sum_register_weekbefore", "0");
    			}
    		}
		}
    	//重置时间
    	parameter.put("createDateStart",  createDateStart);
    	// 把serverIdList转成string
    	parameter.put("serverIdList", parameter.get("serverIds"));
    	return "modules/global/newRegisterStatisticsReport";
    }
}
