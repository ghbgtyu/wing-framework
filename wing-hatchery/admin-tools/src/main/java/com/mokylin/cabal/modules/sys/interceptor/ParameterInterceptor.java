package com.mokylin.cabal.modules.sys.interceptor;

import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.dynamicDataSource.LookupContext;
import com.mokylin.cabal.common.utils.Encodes;
import com.mokylin.cabal.common.utils.IdGen;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.modules.sys.entity.User;
import com.mokylin.cabal.modules.sys.utils.ConfigConstants;
import com.mokylin.cabal.modules.sys.utils.UserUtils;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.Date;
import java.util.Map;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/10/23 11:29
 * 项目: cabal-tools
 * 封装查询参数为Map
 */
public class ParameterInterceptor extends HandlerInterceptorAdapter {

    protected final Logger log = LoggerFactory.getLogger(getClass());

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        MybatisParameter paramMap = new MybatisParameter();
        Map requestParameterMap = request.getParameterMap();
        for (Object key : requestParameterMap.keySet()) {
            String[] array = (String[])requestParameterMap.get(key);
            String value = StringUtils.join(array, ",");
            if (StringUtils.isBlank(value)) {
                continue;
            }
            paramMap.put(key, Encodes.urlDecode(StringUtils.trim(value)));
            //如果参数名是serverIds,则split向paramMap放一个List集合以便mybatis foreach标签处理
            if ("serverIds".equals(key) && StringUtils.isNotBlank(value)) {
                paramMap.put("serverIdList", Arrays.asList(StringUtils.split(value, ",")));
            }
            else if (StringUtils.endsWith((String)key, "_list")) {//如果name以"_list"结尾
                String keyStr = (String)key;
                paramMap.put(keyStr.replaceFirst("_list", "List"), Arrays.asList(array));
            }
            else if (array.length > 1) {//多个
                paramMap.put(key + "List", Arrays.asList(array));
            }
            // 批量提交
            if("recordIds".equals(key) && StringUtils.isNotBlank(value)){
                paramMap.put("recordIdList", Arrays.asList(StringUtils.split(value,",")));
            }
        }

        User user = UserUtils.getUser();

        paramMap.put("currentUser", user);
        paramMap.put("isGlobalPlatformPermission",UserUtils.hasAllPlatformPermission(user));
        //paramMap.put("theSameRoleUserIdList",UserUtils.getTheSameRoleUserIds(user));
        paramMap.put("roleUserIdList",UserUtils.getTheSameRoleUserIds(user));

        //取出当前登陆服务器ID
        String serverId = LookupContext.getCurrentServerId();
        if (StringUtils.isBlank(serverId)) {
            serverId = (String)request.getSession().getAttribute(ConfigConstants.SELECTED_SERVER_KEY);
        }

        paramMap.put("currentServerId", serverId);
        log.debug("paramMap:" + paramMap);

        paramMap.put("nowTime", new Date());    //当前时间

        //默认实体主见都是id，如果创建一条记录，则前端不会传递ID，这里我们默认自动生成一个，否则ID就为原来的值
        String id = MapUtils.getString(paramMap,"id");
        if(StringUtils.isEmpty(id) || StringUtils.isBlank(id)){
            paramMap.put("id", IdGen.uuid());       //新增记录时，通常需要一个id
        }


        //paramMap.setPage(new Page(request,response));
        request.setAttribute("paramMap", paramMap);
        return true;
    }
}
