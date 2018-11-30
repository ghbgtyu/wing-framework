package com.mokylin.cabal.common.game.api.impl;

import com.mokylin.cabal.common.persistence.Result;
import com.mokylin.cabal.common.utils.Reflections;
import com.mokylin.cabal.common.utils.URIBuilder;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.lang.reflect.Field;
import java.net.URI;
import java.util.List;
import java.util.concurrent.*;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/10/30 16:58
 * 项目: cabal-tools
 */
public class AbstractGameOperations {

    protected final Logger LOGGER = LoggerFactory.getLogger(getClass());

    private static final LinkedMultiValueMap<String, String> EMPTY_PARAMETERS = new LinkedMultiValueMap<String, String>();

    private static ExecutorService executors = Executors.newCachedThreadPool();

    private static CompletionService<Result> service = new ExecutorCompletionService<Result>(executors);

    protected  RestTemplate restTemplate;

    public AbstractGameOperations(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }


    public AbstractGameOperations() {
    }

    protected URI buildUri(String path) {
        return buildUri(path, EMPTY_PARAMETERS);
    }

    protected URI buildUri(String path, String parameterName,
                           Object parameterValue) {
        MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
        parameters.set(parameterName, parameterValue.toString());
        return buildUri(path, parameters);
    }

    protected URI buildUri(String path, MultiValueMap<String, String> parameters) {
        return URIBuilder.fromUri(path).queryParams(parameters)
                .build();
    }

    protected URIBuilder uriBuilder(String path) {
        return URIBuilder.fromUri(path);
    }

    protected Result execute(final Object obj, final URI uri){
        Result result;
        Future<Result> future = executors.submit(new Callable<Result>() {
            @Override
            public Result call() throws Exception {

                //去除无用的字段，该字段太长，而且没必要，其他属性字段较断，这里先忽略
                Field[] fields = obj.getClass().getDeclaredFields();
                try {
                    for (Field field : fields) {
                        if (field.getName().equals("serverIds")) {
                            Reflections.invokeSetter(obj, "serverIds", "");
                        }
                    }
                }catch (Exception e){
                    ExceptionUtils.getStackTrace(e);
                }

                return restTemplate.postForObject(uri,obj,Result.class);
            }
        });
        try {

            result = future.get(5,TimeUnit.SECONDS);
            LOGGER.info("当前URI：{},参数:{},返回结果集:{}",uri,obj,result);
            return result;
        } catch (Exception e) {

            LOGGER.error("操作失败，当前URI：{},参数：{},异常：{}",uri,obj,ExceptionUtils.getStackTrace(e));
            future.cancel(true);
            return new Result(false);
        }
    }


    protected Result execute(List<String> serverIdList,final Object obj, final URI uri){
        final CountDownLatch latch = new CountDownLatch(serverIdList.size());
        for(String serverId : serverIdList){
            service.submit(new Callable<Result>() {
                @Override
                public Result call() throws Exception {
                    //去除无用的字段，该字段太长，而且没必要，其他属性字段较断，这里先忽略
                    Field[] fields = obj.getClass().getDeclaredFields();
                    try {
                        for (Field field : fields) {
                            if (field.getName().equals("serverIds")) {
                                Reflections.invokeSetter(obj, "serverIds", "");
                            }
                        }
                    }catch (Exception e){
                        ExceptionUtils.getStackTrace(e);
                    }

                    return restTemplate.postForObject(uri,obj,Result.class);
                }
            });
            latch.countDown();
        }

        for(int i = 0; i < serverIdList.size(); i ++){
            try {
                Result result = service.take().get();
                LOGGER.info("当前URI：{},参数:{},返回结果集:{}",uri,obj,result);
            } catch (Exception e) {
                LOGGER.error("操作失败，当前URI：{},参数：{},异常：{}",uri,obj,ExceptionUtils.getStackTrace(e));
            }
        }
        return new Result(true);
    }
}
