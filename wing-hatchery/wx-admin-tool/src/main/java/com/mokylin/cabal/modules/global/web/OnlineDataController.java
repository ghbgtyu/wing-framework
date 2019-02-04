package com.mokylin.cabal.modules.global.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.utils.DateUtils;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.web.BaseController;
import com.mokylin.cabal.common.utils.Collections3;

/**
 * 在线数据
 *
 * @author ln
 */
@Controller
@RequestMapping(value = "${adminPath}/global/onlinedata")
public class OnlineDataController extends BaseController {

    /**
     * 在线数据分布
     */
    @RequestMapping(value = "onlineDataStatistics")
    public String onlineDataStatistics(HttpServletRequest request, HttpServletResponse response, Model model) {

        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        //默认查询时间范围为7天
        setDefaultTimeRange(parameter);
        setServerIdList(parameter);
//	      if(!parameter.containsKey("serverIdList")){
//	    	  list.add(parameter.get("currentServerId"));
//	    	  parameter.put("serverIdList", list);
//	      }
        model.addAttribute("list", globalDaoTemplate.selectList("rizonghe.onlineDataList", parameter));
        // 把serverIdList转成string
        parameter.put("serverIdList", parameter.get("serverIds"));
        return "modules/global/onlineDataStatistics";
    }

    /**
     * 在线数据时点分布
     */
    @RequestMapping(value = "onlinePointDisList")
    public String onlinePointDistributionList(HttpServletRequest request, HttpServletResponse response, Model model) {

        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        setServerIdList(parameter);
        String day = parameter.containsKey("paday") ? parameter.get("paday").toString() : DateUtils.addDays(DateUtils.getDate(), -1);
        parameter.put("paday", day);
        parameter.put("after", DateUtils.addDays(day, -7));
        parameter.put("afterDay", DateUtils.addDays(day, -7).replace("-", ""));
        parameter.put("day", day.replace("-", ""));
        List<Map> result = logDaoTemplate.selectList("statRealTimeService.onlinePointDis", parameter);
        for (Map map : result) {
            map.put("logHour", getHour(map.get("logHour").toString()) + ":00");
        }

        List<Map<Object, Object>> compare = logDaoTemplate.selectList("statRealTimeService.onlinePointCompare", parameter);

        String[] row = {"h0", "h1", "h2", "h3", "h4", "h5", "h6", "h7", "h8", "h9", "h10", "h11", "h12", "h13", "h14", "h15", "h16", "h17", "h18", "h19", "h20", "h21", "h22", "h23"};
        String[] col = {parameter.get("after").toString(), parameter.get("paday").toString()};
        String[] rep = {"befor", "after"};
        model.addAttribute("paday", parameter.get("paday"));
        model.addAttribute("after", parameter.get("after"));
        model.addAttribute("compare", Collections3.invert(compare, row, col, rep, "log_day"));

        model.addAttribute("list", result);
        // 把serverIdList转成string
        parameter.put("serverIdList", parameter.get("serverIds"));
        return "modules/global/onlinePointDistribution";
    }

    /**
     * 截取小时
     */
    public String getHour(String time) {
        String hour = time.substring(time.length() - 2, time.length());
        return hour;
    }
}
