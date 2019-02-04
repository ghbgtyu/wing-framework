package com.test.jdbc.pool.test.impl;

import com.test.jdbc.pool.IDataSource;
import com.test.jdbc.pool.stage.IStage;
import com.test.jdbc.pool.stage.impl.EmptyStage;
import com.test.jdbc.pool.test.AbsMultiThreadTest;
import com.test.jdbc.pool.test.AbsTimeTest;

/**
 * Created by nijia on 2017/11/10.
 */
public class MultiThreadEmptyTest extends AbsMultiThreadTest {

    private IDataSource dataSource;

    public MultiThreadEmptyTest(IDataSource dataSource, int threadSize) {

        super(threadSize);
        this.dataSource = dataSource;

    }

    public IStage getStage() {
        return new EmptyStage(dataSource);
    }
}
