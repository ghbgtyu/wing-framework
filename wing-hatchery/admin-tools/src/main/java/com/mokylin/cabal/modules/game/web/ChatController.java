package com.mokylin.cabal.modules.game.web;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.persistence.Result;
import com.mokylin.cabal.common.redis.RedisManager;
import com.mokylin.cabal.common.web.BaseController;
import com.mokylin.cabal.modules.game.entity.ChatRecord;
import com.mokylin.cabal.modules.sys.entity.User;
import com.mokylin.cabal.modules.sys.utils.UserUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/11/21 16:39
 * 项目: cabal-tools
 */
@Controller
@RequestMapping(value = "${adminPath}/game/chat")
public class ChatController extends BaseController {

    @Resource
    private RedisManager redisManager;

    private static ConcurrentHashMap<String, Date> concurrentHashMap = new ConcurrentHashMap<String, Date>();

    @RequestMapping(value = {"list", ""})
    public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.setPage(new Page(request, response));
        Page<Map<String, Object>> page = logDaoTemplate.paging("chat.paging", parameter);

        model.addAttribute("page", page);

        return "modules/logs/chatList";
    }

    @RequestMapping(value = "monitor")
    public String monitor(Model model) {
        model.addAttribute("keywords", redisManager.getKeywords());

        return "modules/game/chatmonitor";
    }

    @RequiresPermissions("game.chatmonitor.keyWordsEdit")
    @RequestMapping(value = "addKeyword")
    @ResponseBody
    public Result addKeyword(HttpServletRequest request, Model model){
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        redisManager.addKeyword(MapUtils.getString(parameter,"key"),MapUtils.getString(parameter,"keyword"));
        return new Result(true);
    }

    @RequiresPermissions("game.chatmonitor.monitor")
    @RequestMapping(value = "fetchData")
    @ResponseBody
    public Result fetchData(HttpServletRequest request, Model model){
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        String template = "<a href=\"#\" onclick=\"jinYan(#{serverId},#{roleId})\">#{roleName}</a></br>";
        List<String> roleIdList = Lists.newArrayList();
        StringBuffer monitor1 = new StringBuffer();     //监控窗口1
        StringBuffer monitor2 = new StringBuffer();     //监控窗口2
        User user = UserUtils.getUser();
        Date before = concurrentHashMap.get(user.getId());
        Date after = new Date();
        //获取聊天记录并进行解析
        Map<String,String> keywords = redisManager.getKeywords();
        List<String> chatRecords = redisManager.getChatContent();
        JSONArray array = JSON.parseArray(JSON.toJSONString(chatRecords));
        for(int i = 0; i < array.size(); i ++){
            ChatRecord chatRecord = JSON.parseObject(array.get(i).toString(),ChatRecord.class);

            if(before == null){
                monitor1.append("【"+chatRecord.getChatTime()+"】"+chatRecord.getRoleName()+":"+chatRecord.getContent()+"</br>");
                for(String key : keywords.keySet()){
                	String keyword = keywords.get(key);
                	if(chatRecord.getContent().indexOf(keyword) != -1){
                		if(!roleIdList.contains(chatRecord.getRoleId())){
                            monitor2.append(template.replace("#{serverId}",chatRecord.getServerId()).replace("#{roleId}",chatRecord.getRoleId()).replace("#{roleName}",chatRecord.getRoleName()));
                            roleIdList.add(chatRecord.getRoleId());
                        }
                	}
                }
                continue;
            }

            if(before != null && (Long.parseLong(String.valueOf(chatRecord.getChatTime())) > before.getTime())) {
                monitor1.append("【"+chatRecord.getChatTime()+"】"+chatRecord.getRoleName()+":"+chatRecord.getContent()+"</br>");
                for(String key : keywords.keySet()){
                	String keyword = keywords.get(key);
                	if(chatRecord.getContent().indexOf(keyword) != -1){
                		 if(!roleIdList.contains(chatRecord.getRoleId())){
                             monitor2.append(template.replace("#{serverId}",chatRecord.getServerId()).replace("#{roleId}",chatRecord.getRoleId()).replace("#{roleName}",chatRecord.getRoleName()));
                             roleIdList.add(chatRecord.getRoleId());
                         }
                	}
                }
            }
        }

        concurrentHashMap.put(user.getId(),after);
        JSONObject ret = new JSONObject();
        ret.put("monitor1",monitor1.toString());
        ret.put("monitor2",monitor2.toString());

        return new Result(true).data(ret);
    }

    @RequiresPermissions("game.chatmonitor.keyWordsEdit")
    @RequestMapping(value = "deleteKey")
    @ResponseBody
    public Result deleteKey(String keyword,HttpServletRequest request, Model model){

        redisManager.deleteKeyword(keyword);
        return new Result(true);
    }

    @RequiresPermissions("game.chatmonitor.monitor")
    @RequestMapping(value = "startMonitor")
    public Result startMonitor(HttpServletRequest request, Model model){
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        List<String> serverIdList = (List<String>) MapUtils.getObject(parameter,"serverIdList");

        gameTemplate.monitorOperation().chatMonitor(serverIdList);

        return new Result(true);
    }

    @RequiresPermissions("game.chatmonitor.monitor")
    @RequestMapping(value = "cancelMonitor")
    public Result cancelMonitor(HttpServletRequest request, Model model){
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        List<String> serverIdList = (List<String>) MapUtils.getObject(parameter,"serverIdList");

        gameTemplate.monitorOperation().cancelMonitor(serverIdList);

        return new Result(true);
    }
}
