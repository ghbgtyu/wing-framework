package com.mokylin.cabal.modules.global.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mokylin.cabal.common.cache.ICache;
import com.mokylin.cabal.common.config.Global;
import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.persistence.dynamicDataSource.LookupContext;
import com.mokylin.cabal.common.utils.DateUtils;
import com.mokylin.cabal.common.web.BaseController;
import com.mokylin.cabal.modules.tools.entity.mothRevenue;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/12/1 10:17
 * 项目: cabal-tools
 */

@Controller
@RequestMapping(value = "${adminPath}/global/dashboard")
public class DashboardController extends BaseController {

    public static final String MONTHLY_TOTAL_DATA_LIST = "monthlyTotalData";
    public static final String MONTHLY_TOTAL_DATA_LISTS = "monthlyTotalDatas";

    @RequestMapping(value = "baseReport")
    public String baseReport(HttpServletRequest request, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        //默认查询时间范围为7天
        setDefaultTimeRange(parameter);
        setServerIdList(parameter);

        List<Map<String, Object>> list = globalDaoTemplate.selectList("rizonghe.findByTimeRange", parameter);

        //已col开头的字段一共288个，这里取其中最大的值即为pccu
        calculateMaxPCCU(list);
        model.addAttribute("list", list);

        //整体运营报表
        model.addAttribute("hisTotal", globalDaoTemplate.selectList("rizonghe.findHisTotal", parameter));

        //月总数据 ----- 这个数据量较大，后面要做缓存，缓存时间设置为2小时
        ICache<String, Object> cache = ehcacheCacheManager.getCache(MONTHLY_TOTAL_DATA_LIST);
        List<Map<String, Object>> monthlyTotal = (List<Map<String, Object>>) cache.get(MONTHLY_TOTAL_DATA_LIST);
        List<Map<String, Object>>  currentMonthTotal =new ArrayList<Map<String,Object>>() ;
        if (monthlyTotal != null) {
            model.addAttribute("monthlyTotal", monthlyTotal);
        } else {
              String curMonth = DateUtils.getDate().replaceAll("-", "");    //获取当前日期
              String beginMonth = DateUtils.beginMonth();                   //获取当月1号
              parameter.put("curMonth", Integer.valueOf(curMonth)-1);
              parameter.put("beginMonth",beginMonth.replaceAll("-", ""));
            if(DateUtils.isBeginMonth(curMonth)){
            	monthlyTotal = globalDaoTemplate.selectList("monthlyIntegrated.findMonthlyTotalData", parameter);
            }else{
            	monthlyTotal = globalDaoTemplate.selectList("monthlyIntegrated.findMonthlyTotalData", parameter);
            	currentMonthTotal = globalDaoTemplate.selectList("rizonghe.findCurrentMonthlyTotalData", parameter);
            }
            
        
            if(monthlyTotal.size()>0){
            	
            	calculateMaxPCCU(monthlyTotal);
            }
            if(currentMonthTotal.get(0)!=null){
            	 calculateMaxPCCU(currentMonthTotal);
            }else{
            	currentMonthTotal.remove(0);
            }
            model.addAttribute("monthlyTotal", monthlyTotal);
            model.addAttribute("monthlyTotals", currentMonthTotal);
        }

        //按平台分组查询，收入，导量，活跃，等
        List<Map<String, Object>> mapList = globalDaoTemplate.selectList("rizonghe.findByPlatform", parameter);
        model.addAttribute("mapList", mapList);
        // 把serverIdList转成string
        parameter.put("serverIdList", parameter.get("serverIds"));
        return "modules/global/baseReport";
    }

    //日综合报表
    @RequestMapping(value = "dailyComprehensiveReport")
    public String dailyComprehensiveReport(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        setDefaultTimeRange(parameter);
        setServerIdList(parameter);
        List<Map<String, Object>> list = globalDaoTemplate.selectList("rizonghe.findDailyReport", parameter);
        //得出列five_minutes_count中最大值即为pccu
        calculateMaxPCCU(list);
        model.addAttribute("list", list);
        //根据查询条件中的开始时间、结束时间计算出开始时间、结束时间所在的周,作为查询条件
        setDefaultWeekRange(parameter);
        List<Map<String, Object>> weekReport = globalDaoTemplate.selectList("rizonghe.findWeekReport", parameter);
        model.addAttribute("weekReport", weekReport);

        // 把serverIdList转成string
        parameter.put("serverIdList", parameter.get("serverIds"));
        return "modules/global/dailyComprehensiveReport";
    }

    @RequestMapping(value = "serverDailyReport")
    public String serverDailyReport(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        setDefaultTimeRange(parameter);
        //setServerIdList(parameter); // TODO 只能选择单服
        parameter.put("areaId", LookupContext.getCurrentServerId());
        Page<Map<String, Object>> page = globalPaging(request, response, "rizonghe.findServerDailyReport");
        model.addAttribute("page", page);
        return "modules/global/serverDailyReport";
    }
    
    @RequestMapping( value =  "gunfuUserStatReport")
    public String gunfuUserStatReport(HttpServletRequest request,HttpServletResponse response, Model model){
    	MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
    	setDefaultTimeRange(parameter);
    	setServerIdList(parameter);
       /*globalPaging(request, response, "rizonghe.findGunfuUserStatReport");*/
    	model.addAttribute("list",globalDaoTemplate.selectList("rizonghe.findGunfuUserStatReport", parameter));
    	// 把serverIdList转成string
    	parameter.put("serverIdList", parameter.get("serverIds"));
    	return "modules/global/gunfuUserStatReport";
    }
    /**
     * 日活跃用户统计
     * @throws ParseException 
     */
    @RequestMapping( value =  "dayActiveUserReport")
    public String dayActiveUserReport(HttpServletRequest request,HttpServletResponse response, Model model) throws ParseException{
    	MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
    	setDefaultTimeRange(parameter);
    	setServerIdList(parameter);
    	//日活跃用户统计
    	List<Map<String, Object>> dayActive = findDayActiveUserReport(request,response, model);
    	//日查询统计
    	statisticsDayActive(request, response, model);
    	//服务器日活跃数统计
    	dayServerActive(request, response, model);
    	//周活跃对比图,获取日活跃对应的前一周的数据
    	weekComparison(request, response, model,dayActive);
    	//月活跃对比图,获取日活跃对应的前一周的数据
    	monthComparison(request, response, model,dayActive);
    	//重置parameter中的日期值,因为要提供给jsp页面的日期控件显示
    	parameter.put("createDateStart", MapUtils.getString(model.asMap(),"createDateStart"));
    	parameter.put("createDateEnd", MapUtils.getString(model.asMap(), "createDateEnd"));
    	// 把serverIdList转成string
    	parameter.put("serverIdList", parameter.get("serverIds"));
    	return "modules/global/dayActiveUserReport";
    }

    /**
     * 月活跃对比图
     */
	private void monthComparison(HttpServletRequest request, HttpServletResponse response, Model model,List<Map<String, Object>> dayActive) throws ParseException {
		MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
		String createDateStart = MapUtils.getString(parameter, "createDateStart");
    	String createDateEnd = MapUtils.getString(parameter, "createDateEnd");
		parameter.put("createDateStart",  DateUtils.formatDate(DateUtils.addMonths(DateUtils.parseDate(createDateStart), -1)));
    	parameter.put("createDateEnd", DateUtils.formatDate(DateUtils.addMonths(DateUtils.parseDate(createDateEnd), -1)));
    	List<Map<String,Object>> monthComparison = globalDaoTemplate.selectList("rizonghe.findMonthComparison",parameter);
    	for (Map<String,Object> mapBef : monthComparison) {
    		String day =  MapUtils.getString(mapBef,"log_day");
    		for (Map<String,Object> mapNow : dayActive) {
    			String dayNow = MapUtils.getString(mapNow,"log_day");
    			if(DateUtils.getMonthSpace(day, dayNow, "yyyyMMdd")==1){
    				mapBef.put("now_sum_dau", MapUtils.getInteger(mapNow, "sum_dau"));
    			}
    		}
    	}
    	model.addAttribute("monthComparison",monthComparison);
	}

	/**
	 * 周活跃对比图
	 */
	private void weekComparison(HttpServletRequest request, HttpServletResponse response, Model model,List<Map<String, Object>> dayActive) throws ParseException {
		MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
		String createDateStart = MapUtils.getString(parameter, "createDateStart");
    	String createDateEnd = MapUtils.getString(parameter, "createDateEnd");
		parameter.put("createDateStart",  DateUtils.formatDate(DateUtils.addDays(DateUtils.parseDate(createDateStart), -7)));
    	parameter.put("createDateEnd", DateUtils.formatDate(DateUtils.addDays(DateUtils.parseDate(createDateEnd), -7)));
    	List<Map<String,Object>> weekComparison = globalDaoTemplate.selectList("rizonghe.findWeekComparison",parameter);
    	for (Map<String,Object> mapBef : weekComparison) {
    		String day =  MapUtils.getString(mapBef,"log_day");
			for (Map<String,Object> mapNow : dayActive) {
				String dayNow = MapUtils.getString(mapNow,"log_day");
				if(DateUtils.getDateSpace(day, dayNow, "yyyyMMdd")==7){
					mapBef.put("now_sum_dau", MapUtils.getInteger(mapNow, "sum_dau"));
				}
			}
			mapBef.put("log_day", DateUtils.formatDate(DateUtils.parseDate(MapUtils.getString(mapBef,"log_day"), "yyyyMMdd"),"E"));
		}
    	model.addAttribute("weekComparison",weekComparison);
	}

	/**
	 * 服务器日活跃统计
	 */
	private void dayServerActive(HttpServletRequest request,HttpServletResponse response, Model model) {
		MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
		List<Map<String,Object>> dayServerActive = globalDaoTemplate.selectList("rizonghe.findDayServerActiveReport",parameter);
    	model.addAttribute("dayServerActive",dayServerActive);
	}

	/**
	 * 日查询统计
	 */
	private void statisticsDayActive(HttpServletRequest request,HttpServletResponse response,Model model) throws ParseException {
		MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
		String createDateStart = MapUtils.getString(parameter, "createDateStart");
    	String createDateEnd = MapUtils.getString(parameter, "createDateEnd");
		model.addAttribute("createDateStart",createDateStart);
    	model.addAttribute("createDateEnd",createDateEnd);
    	model.addAttribute("betweenDays",DateUtils.getDateSpace(createDateStart, createDateEnd, "yyyy-MM-dd"));
    	model.addAttribute("serverNum",((HashMap<String, Object>) globalDaoTemplate.selectList("rizonghe.findServerNum",parameter).get(0)).get("server_num"));
    	//特殊处理,这里的查询日期的开始时间需要往前推一天,原因是查询时间段的活跃总数包含了开始时间的当天时间的
    	parameter.put("createDateStart",  DateUtils.formatDate(DateUtils.addDays(DateUtils.parseDate(createDateStart), -1)));
    	List<Map<String, Object>> page = globalDaoTemplate.selectList("rizonghe.findActiveNum",parameter);
    	int activeNum=0;
    	if(null!=page){
    		Map<String, Object> findActiveNum = page.get(0);
    		if(null!=findActiveNum){
    			activeNum =MapUtils.getIntValue(findActiveNum, "active_num");
    		}
    	}
    	model.addAttribute("activeNum",activeNum);
	}

	/**
	 * 日活跃用户统计
	 */
	private List<Map<String, Object>> findDayActiveUserReport(HttpServletRequest request, HttpServletResponse response,Model model) {
		MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
		List<Map<String,Object>> dayActive = globalDaoTemplate.selectList("rizonghe.findDayActiveUserReport",parameter);
		model.addAttribute("dayActive",dayActive);
		return dayActive;
	}
	
    /**
     * 月数据报表
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "monthlyReport")
    public String monthlyReport(HttpServletRequest request, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        //默认查询时间范围为7天
        setDefaultMonthlyRange(parameter);
        setServerIdList(parameter);
        List<Map<String, Object>> list = globalDaoTemplate.selectList("monthlyIntegrated.findMonthlyReport", parameter);

//        //已col开头的字段一共288个，这里取其中最大的值即为pccu
        calculateMaxPCCU(list);
        model.addAttribute("list", list);

        // 把serverIdList转成string
        parameter.put("serverIdList", parameter.get("serverIds"));
        return "modules/global/monthlyReport";
    }
    
    /**
     * 计算PCCU值-即取的所有已col开头的字段的最大值
     *
     * @param list
     */
    public void calculateMaxPCCU(List<Map<String, Object>> list) {
        for (Map<String, Object> map : list) {
            int max = 0;
            for (int i = 1; i <= 288; i++) {
                max = max > MapUtils.getIntValue(map, "col" + i, 0) ? max : MapUtils.getIntValue(map, "col" + i, 0);
            }
            map.put("pccu", max);
        }
    }
    
    /**
     * 月营指标模型分析
     */
    @RequestMapping(value="monthSalesReport")
    public String monthSalesReport(mothRevenue mothRevenue, HttpServletRequest request,HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) throws IOException{
    	MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
    	if (!parameter.containsKey("month")) {
    		parameter.put("month", DateUtils.getYear()+"-"+DateUtils.getMonth());
    	}
    	    PrintWriter out = response.getWriter();
    		int days = DateUtils.getDayNum(parameter.get("month").toString()); //当月天数
    		int now =Integer.valueOf(DateUtils.getDay()); //当前天数
    		model.addAttribute("month", parameter.get("month"));
    		mothRevenue revenue = toolDaoTemplate.selectOne("monthRevenue.selectMonth", parameter);
    		if(revenue==null){
    			addMessage(model,"请到 游戏配置-预估配置中 设置 月营收预估");
    			
    		}else{
    			 model.addAttribute("revenue",revenue);
    			 parameter.put("months", parameter.get("month").toString().replace("-", ""));
    			 mothRevenue real = globalDaoTemplate.selectOne("rizonghe.monthRevenus", parameter);
    			if(real!=null){
    					double arpu =real.getChargeNum()>0?real.getIncome()/real.getChargeNum() : 0;
    	    	 		double payrate =real.getActive()>0? real.getChargeNum()*100/real.getActive() : 0;
    	    	 		real.setArpu(arpu);
    	    	 		real.setPayrate(payrate);
    				}
    			int income = Integer.valueOf(revenue==null? "0" : revenue.getIncome().toString());
    			int newUser = Integer.valueOf(revenue==null? "0" : revenue.getNewUser().toString());
    			model.addAttribute("real",real);
    			model.addAttribute("speed", now*100/days); //时间进度
    			model.addAttribute("surplus", days-now);   //后续每日需完成
    			model.addAttribute("redayincome",income/days);  //预估日收入
    			model.addAttribute("redayuser", newUser/days);  //预估日新注册
    			String operator = Global.getCommonMap().get("operator").toString();
    			String [] opera = operator.split(",");
    			for (int i = 0; i < opera.length; i++) {
					parameter.put("pid"+(i+1), opera[i]);
				}
    			model.addAttribute("realDayList", globalDaoTemplate.selectList("rizonghe.dateTarget", parameter)); //实际日收入、日注册
    		  }
    		   return "modules/global/monthSalesReport";
      }
}
