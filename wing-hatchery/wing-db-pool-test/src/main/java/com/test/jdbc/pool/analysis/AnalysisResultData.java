package com.test.jdbc.pool.analysis;

/**
 * Created by nijia on 2017/11/9.
 */
public class AnalysisResultData {

    /**执行数量*/
    private int count;
    /**执行花费时间*/
    private float time;
    /**异常数量*/
    private int exceptionCount;


    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public float getTime() {
        return time;
    }

    public void setTime(float time) {
        this.time = time;
    }


    public int getExceptionCount() {
        return exceptionCount;
    }

    public void setExceptionCount(int exceptionCount) {
        this.exceptionCount = exceptionCount;
    }
}
