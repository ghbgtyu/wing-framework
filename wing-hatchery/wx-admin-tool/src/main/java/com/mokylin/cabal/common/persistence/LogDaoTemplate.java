package com.mokylin.cabal.common.persistence;

import com.mokylin.cabal.common.persistence.dynamicDataSource.LookupContext;
import com.mokylin.cabal.common.utils.DbConnectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.StopWatch;
import org.apache.poi.ss.formula.functions.T;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/10/23 11:18
 * 项目: cabal-tools
 */
@Component
public class LogDaoTemplate {

    private final Logger log = LoggerFactory.getLogger(getClass());

    //    @Resource private SqlSessionTemplate toolSqlSession;
    @Resource
    private SqlSessionTemplate logSqlSession;

    private static ExecutorService exec = Executors.newFixedThreadPool(50);

    public <E> Page<E> paging(String statement, MybatisParameter<E> parameter) {
        Page<E> page = parameter.getPage();
        List<E> dataList = selectList(statement, parameter);
        page.setList(dataList);
        return page;
    }

    public <E> List<E> selectList(String statement) {
        return logSqlSession.selectList(statement);
    }

    public <E> List<E> selectList(String statement, Object parameter) {
        return logSqlSession.selectList(statement, parameter);
    }

//    public <T> T selectOneByServerId(String serverId, String statement) {
//        return this.selectOneByServerId(serverId, statement, null);
//    }
//
//    public <T> T selectOneByServerId(String serverId, String statement, Object parameter) {
//        try{
//            if (DbConnectionUtils.testGameServer(serverId)) {
//                String originalServerId = LookupContext.getCurrentServerId();
//                LookupContext.setCurrentServerId(serverId);
//                T t = logSqlSession.selectOne(statement, parameter);
//                LookupContext.setCurrentServerId(originalServerId);
//                return t;
//            }
//        }
//        catch(Exception e){
//            log.error("服务器serverId:[" + serverId + "] ERROR",e);
//        }
//        return null;
//    }
//
//    public <E> List<E> selectListByServerId(String serverId, String statement) {
//        return this.selectListByServerId(serverId, statement, null);
//    }
//
//    public <E> List<E> selectListByServerId(String serverId, String statement, Object parameter) {
//        try{
//            if (DbConnectionUtils.testGameServer(serverId)) {
//                String originalServerId = LookupContext.getCurrentServerId();
//                LookupContext.setCurrentServerId(serverId);
//                List<E> list = logSqlSession.selectList(statement, parameter);
//                LookupContext.setCurrentServerId(originalServerId);
//                return list;
//            }
//        }
//        catch(Exception e){
//            log.error("服务器serverId:[" + serverId + "] ERROR",e);
//        }
//        return Collections.EMPTY_LIST;
//    }
//
//    /**
//     * 返回所有服务器的结果集(同一个logDbUrl的serverId视为一个)
//     * @param serverIdList 服务器ID集合
//     * @param statement Mapping ID
//     * @param parameter 查询参数
//     * @return 所有服务器的List形式的查询结果的合集
//     */
//    public <E> List<E> selectListByServerIdList(List<String> serverIdList, String statement, Object parameter) {
//        if (CollectionUtils.isEmpty(serverIdList)) {
//            return Collections.EMPTY_LIST;
//        }
//        serverIdList = toolSqlSession.selectList("gameServer.getServerIdByLogDbUrlWithoutRepetition", serverIdList);//去重复gameDbUrl
//        List<E> resultList = new ArrayList();
//        Map<String, List<E>> resultMap = this.selectByServerIdList(serverIdList, statement, parameter);
//        for (List<E> list : resultMap.values()) {
//            resultList.addAll(list);
//        }
//        return resultList;
//    }
//    /**
//     * 返回所有服务器的结果集(同一个logDbUrl的serverId视为一个)
//     * @param serverIdList 服务器ID集合
//     * @param statement Mapping ID
//     * @param parameter 查询参数
//     * @return key:服务器Id value:对应serverId查询结果
//     */
//    public <E> Map<String, List<E>> selectMapByServerIdList(List<String> serverIdList, String statement, Object parameter) {
//        if (CollectionUtils.isEmpty(serverIdList)) {
//            return Collections.EMPTY_MAP;
//        }
//        serverIdList = toolSqlSession.selectList("gameServer.getServerIdByLogDbUrlWithoutRepetition", serverIdList);//去重复gameDbUrl
//        return this.selectByServerIdList(serverIdList, statement, parameter);
//    }
//
//    /**
//     * 返回所有服务器的结果集(同一个gameDbUrl的serverId视为一个)
//     * @param statement Mapping ID
//     * @return  key:服务器Id value:对应serverId查询结果
//     */
//    public <E> Map<String, List<E>> selectMapAllServers(String statement) {
//        return this.selectMapAllServers(statement, null);
//    }
//
//    /**
//     * 返回所有服务器的结果集(同一个logDbUrl的serverId视为一个)
//     * @param statement Mapping Id
//     * @param parameter 查询参数
//     * @return key:服务器Id value:对应serverId查询结果
//     */
//    public <E> Map<String, List<E>> selectMapAllServers(String statement, Object parameter) {
//        List<String> serverIdList = toolSqlSession.selectList("gameServer.getAllServerIdByLogDbUrlWithoutRepetition");//合并同样logDbUrl的serverId
//        log.info("查询所有服务器的数据 statement:[{}] parameter:[{}]", statement, parameter);
//        return this.selectByServerIdList(serverIdList, statement, parameter);
//    }
//
//    /**
//     * 返回所有未合服非测试服的数据
//     * @param statement
//     * @param parameter
//     * @param <E>
//     * @return
//     */
//    public <E> Map<String, List<E>> selectMapAllActiveServers(String statement, Object parameter) {
//        List<String> serverIdList = toolSqlSession.selectList("gameServer.getAllServerId");//合并同样logDbUrl的serverId
//        log.info("查询所有服务器的数据 statement:[{}] parameter:[{}]", statement, parameter);
//        return this.selectByServerIdList(serverIdList, statement, parameter);
//    }
//
//    /**
//     * 返回所有服务器的结果集(同一个gameDbUrl的serverId视为一个)
//     * @param statement Mapping Id
//     * @return  所有服务器的List形式的查询结果的合集
//     */
//    public <E> List<E>  selectListAllServers(String statement) {
//        List<E> resultList = new ArrayList();
//        Map<String, List<E>> resultMap = this.selectMapAllServers(statement);
//        for (List<E> list : resultMap.values()) {
//            resultList.addAll(list);
//        }
//        return resultList;
//    }

//    /**
//     * 返回所有服务器的结果集(同一个gameDbUrl的serverId视为一个)
//     * @param statement Mapping Id
//     * @param parameter 查询参数
//     * @return 所有服务器的List形式的查询结果的合集
//     */
//    public <E> List<E>  selectListAllServers(String statement, Object parameter) {
//        List<E> resultList = new ArrayList();
//        Map<String, List<E>> resultMap = this.selectMapAllServers(statement, parameter);
//        for (List<E> list : resultMap.values()) {
//            resultList.addAll(list);
//        }
//        return resultList;
//    }

    public <T> T selectOne(String statement) {
        return logSqlSession.selectOne(statement);
    }

    public <T> T selectOne(String statement, Object parameter) {
        return logSqlSession.selectOne(statement, parameter);
    }

    public int insert(String statement) {
        return logSqlSession.insert(statement);
    }

    public int insert(String statement, Object parameter) {
        return logSqlSession.insert(statement, parameter);
    }

    public int batchInsert(String statement, List list) {
        if (list == null) return 0;
        if (list.size() > 500) {
            int size = list.size();
            int divisor = size % 500 > 0 ? size / 500 : size / 500 + 1;
            for (int i = 0; i < divisor; i++) {
                int toindex = (i + 1) * 500;
                if (i == divisor - 1) {
                    toindex = size;
                }
                List tempList = list.subList(i * 500, toindex);
                insert(statement, tempList);
            }
        } else {
            insert(statement, list);
        }
        return list.size();
    }

    public int update(String statement) {
        return logSqlSession.update(statement);
    }

    public int update(String statement, Object parameter) {
        return logSqlSession.update(statement, parameter);
    }

    public int delete(String statement) {
        return logSqlSession.delete(statement);
    }

    public int delete(String statement, Object parameter) {
        return logSqlSession.delete(statement, parameter);
    }

//    /**
//     * 按serverIdList查询各个服务器数据(只按照serverId查询不做dburl去重)
//     * @param serverIdList 服务器ID集合
//     * @param statement Maping Id
//     * @param parameter 查询参数
//     * @return key:服务器Id value:对应serverId查询结果
//     */
//    private <E> Map<String, List<E>> selectByServerIdList(List<String> serverIdList, final String statement, final Object parameter) {
//        if (CollectionUtils.isEmpty(serverIdList)) {
//            return Collections.EMPTY_MAP;
//        }
//        StopWatch sw = new StopWatch();
//        sw.start();
//        Map<String, List<E>> resultMap = new LinkedHashMap();
//        List<Callable<Map<String, List<E>>>> callableList = new ArrayList();
//        for (final String serverIds : serverIdList) {
//            Callable<Map<String, List<E>>> callable = new Callable() {
//                @Override
//                public Map<String, List<E>> call() throws Exception {
//                    Map<String, List<E>> map = new HashMap();
//                    String serverId = StringUtils.substringBefore(serverIds, ",");
//                    LookupContext.setCurrentServerId(serverId);
//                    List<E> list = logSqlSession.selectList(statement, parameter);
//                    map.put(serverIds, list);
//                    return map;
//                }
//            };
//            callableList.add(callable);
//        }
//        try {
//            List<Future<Map<String, List<E>>>> futrueList= exec.invokeAll(callableList);
//            for (Future<Map<String, List<E>>> future : futrueList) {
//                try {
//                    resultMap.putAll(future.get());
//                } catch (Exception e) {
//                    log.error(null,e);
//                }
//            }
//        } catch (InterruptedException e) {
//            log.error(null,e);
//        }
//        log.info("服务器数量:{} statementName:{} 执行时间:{}", serverIdList.size(), statement, sw.getTime());
//        return resultMap;
//    }
}
