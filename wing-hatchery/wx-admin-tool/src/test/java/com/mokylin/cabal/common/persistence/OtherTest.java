package com.mokylin.cabal.common.persistence;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.mokylin.cabal.common.utils.DateUtils;
import com.mokylin.cabal.common.utils.URIBuilder;
import org.apache.commons.collections.MapUtils;
import org.apache.ibatis.ognl.Ognl;
import org.hibernate.annotations.SourceType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import javax.xml.bind.SchemaOutputResolver;
import java.net.URI;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/11/5 15:11
 * 项目: cabal-tools
 */
public class OtherTest {

    public static void main(String[] args) {
//        List<String> list = new ArrayList<String>();
//        list.add("1");
//        list.add("2");
//        list.add("3");
//        list.add("4");
//        list.remove("1");
//        System.out.println(JSON.toJSONString(list));

//        RestTemplate restTemplate = new RestTemplate();
//        MultiValueMap parameter = new LinkedMultiValueMap();
//        parameter.set("a","1");
//        parameter.set("b","2");
//        restTemplate.postForObject("http://192.168.2.146:10086",parameter,Result.class);

//        MybatisParameter parameter = new MybatisParameter();
//        parameter.put("isGlobalPlatformPermission",true);
//        System.out.println(parameter.get("isGlobalPlatformPermission"));
//        boolean flag = true;
//        Map<String,Object> map = new HashMap<String, Object>();
//        map.put("id","123123");
//        String id = MapUtils.getString(map,"id");
//        if(StringUtils.isNullOrEmpty(id)){
//            System.out.println("嗯嗯嗯呢");
//        }

//        System.out.println(System.currentTimeMillis());
//        //1416813462783
        System.out.println(DateUtils.parseLong("1416449219695"));
//        System.out.println(TimeZone.getDefault().getRawOffset());
//        System.out.println(DateUtils.pastDays("1416813462783"));
        //System.out.println("<th>关键字</th><td>"+keywords+"</td><td><a href=\"${ctx}/game/chat/deleteKey?keyword="+keywords+"\" onclick=\"return confirmx('确认要删除该关键字吗？', this.href)\">删除</a></td>");

//        ConcurrentHashMap<String, Date> concurrentHashMap = new ConcurrentHashMap<String, Date>();
//        concurrentHashMap.put("123",new Date());
//        System.out.println(concurrentHashMap.get("123"));
//        concurrentHashMap.put("123", DateUtils.addDays(new Date(), 1));
//        System.out.println(concurrentHashMap.get("123"));
//        Date before = concurrentHashMap.get("111");
//        if(before == null){
//            System.out.println("=================");
//        }

//        List<String> roleIds = Lists.newArrayList();
//        roleIds.add("123123123");
//        System.out.println(JSON.toJSONString(roleIds));
//
//        String str = "[\"123123123\"]";
//        JSONArray array = JSON.parseArray(str);
//        System.out.println(array.get(0));

//        JSONObject object = new JSONObject();
//        object.put("a",1231);
//        object.put("a",123);
//        System.out.println(JSON.toJSONString(object));

//        System.out.println(DateUtils.getDayRange(2015,1));

//        Calendar calendar = Calendar.getInstance();
//
//        int yearWeek = calendar.get(Calendar.WEEK_OF_YEAR);
//        int weekDay = calendar.getMaximum(Calendar.DAY_OF_WEEK);
//        int yearDay = calendar.getActualMaximum(Calendar.DAY_OF_YEAR);
//        System.out.println(weekDay+"=="+yearDay);System.out.println(DateUtils.getDayRange(2014,53));
        Calendar calendar = Calendar.getInstance();
//        calendar.setFirstDayOfWeek(Calendar.MONDAY);
//        calendar.set(Calendar.WEEK_OF_YEAR,-1);
//        calendar.add(Calendar.WEEK_OF_YEAR,-1);
//        int a= calendar.get(Calendar.WEEK_OF_YEAR);
        String month = (calendar.get(Calendar.MONTH) + 1) + "";
        if (month.length() == 1) {
            month = "0" + month;
        }
        String day = calendar.get(Calendar.DAY_OF_MONTH) + "";
        if (day.length() == 1) {
            day = "0" + day;
        }
        System.out.println(month + "-----------" + day);


    }

    protected static URI buildUri(String path, MultiValueMap<String, String> parameters) {
        return URIBuilder.fromUri(path).queryParams(parameters)
                .build();
    }
}
