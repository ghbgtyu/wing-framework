package com.test.jdbc.pool.test;

import com.test.jdbc.pool.stage.IStage;
import com.wing.common.util.LogUtil;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * Created by nijia on 2017/11/10.
 */
public abstract class AbsTimeTest implements Runnable {


    public abstract IStage getStage();

    public void run() {
        IStage stage = exec();
        this.log(stage);
    }


    public IStage exec() {
        IStage stage = getStage();

        int allSecond = 60;

        stage.execute();
        while (allSecond > 0) {
            try {
                Random random = new Random();
                Thread.sleep(random.nextInt(1000));
                //Thread.sleep(1000l);
                allSecond--;
                stage.execute();
                LogUtil.info("lastTime:" + allSecond);

            } catch (Exception e) {
                LogUtil.error("AbsPoolTest:" + e);
            }

        }

        return stage;
    }

    public void log(IStage stage) {
        LogUtil.info(stage.toString());
        LogUtil.info(stage.getStageResult().toString());
        stage.getStageResult().toExcel(getLogPath(stage), 0, 0);
    }

    public String getLogPath(IStage stage) {

        DateFormat df = new SimpleDateFormat("yyyy-MM-dd-HH-mm");
        String fileName = stage.toString() + "_" + Thread.currentThread().getName() + "_" + df.format(new Date()) + ".xls";

        return "C:\\Users\\Administrator\\Desktop\\分享\\数据库连接池分享\\数据分析\\" + fileName;
    }
}
