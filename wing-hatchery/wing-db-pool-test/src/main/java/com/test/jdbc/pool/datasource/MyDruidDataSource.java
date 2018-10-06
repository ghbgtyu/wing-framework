package com.test.jdbc.pool.datasource;

import com.alibaba.druid.pool.DruidDataSource;
import com.test.jdbc.pool.AbsDataSource;
import com.test.jdbc.pool.JdcbConstants;

/**
 * Created by nijia on 2017/11/7.
 */
public class MyDruidDataSource extends AbsDataSource<DruidDataSource> {


    @Override
    public DruidDataSource createDataSource() throws Exception {

        DruidDataSource dataSource = new DruidDataSource();
        try {
            dataSource.setDriverClassName(JdcbConstants.JDBC_DRIVER);
        } catch (Exception e) {
            throw new Exception(e);
        }
        dataSource.setUrl(JdcbConstants.JDBC_URL);
        dataSource.setUsername(JdcbConstants.MYSQL_USER_NAME);
        dataSource.setPassword(JdcbConstants.MYSQL_PASS_WORD);
        dataSource.setMaxActive(JdcbConstants.MAX_ACTIVE);
        dataSource.setInitialSize(JdcbConstants.INITIAL_SIZE);
        dataSource.setMinIdle(JdcbConstants.MIN_IDLE);
        dataSource.setMaxWait(JdcbConstants.MAX_WAIT);

        dataSource.setMinEvictableIdleTimeMillis(JdcbConstants.MIN_EVICTABLE_IDLE_TIME_MILLIS);
        dataSource.setValidationQuery(JdcbConstants.VALIDATION_QUERY);


//        dataSource.setTimeBetweenEvictionRunsMillis(JdcbConstants.TIME_BETWEEN_EVICTION_RUNS_MILLIS);
//        dataSource.setTestWhileIdle(JdcbConstants.TEST_WHILE_IDLE);
//
//        dataSource.setTestOnBorrow(JdcbConstants.ON_BORROW_TEST);
//        dataSource.setTestOnReturn(JdcbConstants.TEST_ON_RETURN);


        dataSource.setPoolPreparedStatements(true);
        dataSource.setMaxPoolPreparedStatementPerConnectionSize(100);




        //dataSource.setTestWhileIdle(JdcbConstants.TEST_WHILE_IDLE);



        dataSource.init();


        return dataSource;
    }

    @Override
    public String getName() {
        return "druid";
    }
}
