package com.test.jdbc.pool.stage;

import com.test.jdbc.pool.analysis.AnalysisResultData;
import com.test.jdbc.pool.analysis.IAnalysis;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by nijia on 2017/11/10.
 * 以时间为压力推进点，每秒加强压力
 */
public abstract class AbsTimeStage implements IStage {


    private long startTime = System.currentTimeMillis();


    private StageResultVo stageResultVo = new StageResultVo();

    //并发量基础值
    public abstract int getNum();


    public abstract IAnalysis getAnalysis();


    public void execute() {
        IAnalysis analysis = getAnalysis();
        long nowTime = System.currentTimeMillis();

        float second = (nowTime - startTime) / 1000;

        int count = (int) (getNum() * (1 + second * 0.1));//每秒增加10%的压力
        //int count =(int)(getNum()*(1+0.1));//每秒增加10%的压力

        AnalysisResultData data = new AnalysisResultData();
        for (int i = 0; i < count; i++) {
            analysis.execute(data);
        }

        //    float tmp = data.getTime()/data.getCount()*getNum();
        float tmp = data.getCount() / data.getTime();
        if (stageResultVo.getMin() > tmp || stageResultVo.getMin() == 0) {
            stageResultVo.setMin(tmp);
        }

        if (stageResultVo.getMax() < tmp) {
            stageResultVo.setMax(tmp);
        }

        stageResultVo.setExceptionCount(stageResultVo.getExceptionCount() + data.getExceptionCount());

        stageResultVo.addResult(second, tmp, data.getCount(), data.getTime());

    }

    public StageResultVo getStageResult() {
        return stageResultVo;
    }

    @Override
    public String toString() {
        return getAnalysis().toString();
    }
}
