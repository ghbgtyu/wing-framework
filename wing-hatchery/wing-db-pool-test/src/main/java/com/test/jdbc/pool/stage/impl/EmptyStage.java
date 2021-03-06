package com.test.jdbc.pool.stage.impl;

import com.test.jdbc.pool.IDataSource;
import com.test.jdbc.pool.analysis.IAnalysis;
import com.test.jdbc.pool.analysis.impl.EmptyPoolAnalysis;
import com.test.jdbc.pool.business.BaseBusinessService;
import com.test.jdbc.pool.dao.BaseDao;
import com.test.jdbc.pool.datasource.MyC3p0DataSource;
import com.test.jdbc.pool.stage.AbsTimeStage;

/**
 * Created by nijia on 2017/11/11.
 */
public class EmptyStage extends AbsTimeStage {


    private IAnalysis analysis;

    public EmptyStage(IDataSource dataSource) {
        analysis = new EmptyPoolAnalysis(new BaseBusinessService(new BaseDao(dataSource)));
    }


    @Override
    public int getNum() {
        return 10000;
    }


    @Override
    public IAnalysis getAnalysis() {
        return analysis;
    }
}
