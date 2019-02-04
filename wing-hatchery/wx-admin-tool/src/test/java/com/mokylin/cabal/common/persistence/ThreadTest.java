package com.mokylin.cabal.common.persistence;

import com.alibaba.fastjson.JSONObject;
import org.junit.Test;

import java.util.concurrent.*;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/10/30 18:34
 * 项目: cabal-tools
 */
public class ThreadTest {

    @Test
    public void testJson() throws Exception {
        JSONObject object = new JSONObject();
        object.put("announceId", "123123123");
        object.put("announceContent", "Hello");
        object.put("beginTime", "2014-10-01 10:00:00");
        object.put("endTime", "2014-10-30 11:00:00");
        object.put("interval", "1");
        System.out.println(object);
    }


    static class Task implements Callable<String> {
        private int i;

        public Task(int i) {
            this.i = i;
        }

        @Override
        public String call() throws Exception {
            Thread.sleep(10000);
            return Thread.currentThread().getName() + "执行完任务：" + i;
        }
    }

    public static void main(String[] args) throws InterruptedException, ExecutionException {
        testExecutorCompletionService();
    }

    private static void testExecutorCompletionService() throws InterruptedException, ExecutionException {
        int numThread = 5;
        ExecutorService executor = Executors.newFixedThreadPool(numThread);
        CompletionService<String> completionService = new ExecutorCompletionService<String>(executor);
        for (int i = 0; i < numThread; i++) {
            final int finalI = i;
            completionService.submit(new Callable<String>() {
                @Override
                public String call() throws Exception {
                    return Thread.currentThread().getName() + "执行完任务：" + finalI;
                }
            });
        }

        for (int i = 0; i < numThread; i++) {
            System.out.println(completionService.take().get());
        }
    }
}
