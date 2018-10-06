package com.test.jdbc.pool.test.impl;

import com.test.jdbc.pool.IDataSource;
import com.test.jdbc.pool.datasource.MyC3p0DataSource;
import com.test.jdbc.pool.stage.IStage;
import com.test.jdbc.pool.stage.impl.EmptyStage;
import com.test.jdbc.pool.stage.impl.QueryStage;
import com.test.jdbc.pool.test.AbsTimeTest;

/**
 * Created by nijia on 2017/11/10.
 */
public class QueryTest extends AbsTimeTest {



    private IDataSource dataSource;

    public QueryTest(IDataSource dataSource){
        this.dataSource = dataSource;
    }

    public IStage getStage() {
        return new QueryStage(dataSource);
    }
}
