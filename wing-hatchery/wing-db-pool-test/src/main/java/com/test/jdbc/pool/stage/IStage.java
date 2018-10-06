package com.test.jdbc.pool.stage;

/**
 * Created by nijia on 2017/11/10.
 */
public interface IStage {

    /**执行*/
    public void execute();
    /**得到分析结果*/
    public StageResultVo getStageResult();
}
