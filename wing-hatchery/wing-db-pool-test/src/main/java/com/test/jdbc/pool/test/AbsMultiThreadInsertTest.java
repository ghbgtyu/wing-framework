package com.test.jdbc.pool.test;

import com.test.jdbc.pool.stage.IStage;
import com.test.jdbc.pool.stage.StageResultVo;
import com.test.jdbc.pool.stage.impl.InsertStage;
import com.wing.common.util.LogUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

/**
 * Created by nijia on 2017/11/14.
 * 多线程测试
 */
public abstract class AbsMultiThreadInsertTest extends AbsTimeTest {


    public ExecutorService service ;
    /**线程数*/
    private int threadSize;

    public AbsMultiThreadInsertTest(int threadSize){
        this.threadSize  = threadSize;
        service =  Executors.newFixedThreadPool(threadSize);
    }

    public abstract String getVersion();

    private class MyCallable implements Callable<StageResultVo>{

        private IStage stage ;
        MyCallable(IStage stage){
            this.stage = stage;
        }

        public IStage getStage() {
            return stage;
        }

        public void setStage(IStage stage) {
            this.stage = stage;
        }

        public StageResultVo call() throws Exception {
            return exec().getStageResult();
        }
    }


    public void run() {

        List<StageResultVo> stageResultVoList = new ArrayList<StageResultVo>();
        List<MyCallable>runnableList = new ArrayList();
        for(int i = 0;i<threadSize;i++){
            IStage stage = getStage();

            MyCallable myCallable = new MyCallable(stage);
            runnableList.add(myCallable);

        }

        try {
            StageResultVo stageResultVo = new StageResultVo();
            List<Future<StageResultVo>> futureList = service.invokeAll(runnableList);
            for( Future<StageResultVo> future:futureList ){
                stageResultVo.mergeResult(future.get());

            }
            InsertStage stage = (InsertStage)getStage();

            //成功插入多少次
            int reslutNum = stage.getResult();
            int allNum = stageResultVo.getAllCount();



            LogUtil.info(stageResultVo.toString());
            stageResultVo.toExcel(getLogPath(getStage()),reslutNum,allNum);
            LogUtil.info("test end");

        }catch (Exception e){
            LogUtil.error("AbsMultiThreadTest"+e);
        }
        service.shutdown();



    }
}
