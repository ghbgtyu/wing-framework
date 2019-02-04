package com.test.jdbc.pool.test.impl;

import com.test.jdbc.pool.IDataSource;
import com.test.jdbc.pool.stage.IStage;
import com.test.jdbc.pool.stage.impl.InsertStage;
import com.test.jdbc.pool.test.AbsMultiThreadInsertTest;

/**
 * Created by nijia on 2017/11/10.
 */
public class MultiThreadInsertTest extends AbsMultiThreadInsertTest {

    private IDataSource dataSource;
    private String version;

    public MultiThreadInsertTest(IDataSource dataSource, int threadSize) {

        super(threadSize);
        this.dataSource = dataSource;
        version = String.valueOf(System.currentTimeMillis());
    }

    @Override
    public String getVersion() {
        return version;
    }

    public InsertStage getStage() {
        return new InsertStage(dataSource, dataSource.getName(), version);
    }


}
