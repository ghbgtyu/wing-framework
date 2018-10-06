package com.test.jdbc.pool.datasource;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.test.jdbc.pool.AbsDataSource;
import com.test.jdbc.pool.JdcbConstants;

/**
 * Created by nijia on 2017/11/7.
 */
public class MyC3p0DataSource extends AbsDataSource<ComboPooledDataSource> {


    @Override
    public ComboPooledDataSource createDataSource() throws Exception {

        ComboPooledDataSource dataSource = new ComboPooledDataSource();
        try {
            dataSource.setDriverClass(JdcbConstants.JDBC_DRIVER);

        } catch (Exception e) {
            throw new Exception(e);
        }

        dataSource.setJdbcUrl(JdcbConstants.JDBC_URL);
        dataSource.setUser(JdcbConstants.MYSQL_USER_NAME);
        dataSource.setPassword(JdcbConstants.MYSQL_PASS_WORD);

        dataSource.setMaxPoolSize(JdcbConstants.MAX_ACTIVE);

        dataSource.setInitialPoolSize(JdcbConstants.INITIAL_SIZE);


        dataSource.setMinPoolSize(JdcbConstants.MIN_IDLE);
        dataSource.setPreferredTestQuery(JdcbConstants.VALIDATION_QUERY);


        //可以根据应用调用频率权衡一个检查pool的频率，这样可以在保证性能损耗不大情况下，尽可能的保证pool内connection的有效性
        //dataSource.setIdleConnectionTestPeriod(10);


        //要想保证网络和数据库瞬间的失效100%不会造成应用端getConnection失败必须开启 testConnectionOnCheckout。但此特性的代价巨大，建议在应用端做容错。
//        dataSource.setTestConnectionOnCheckout(true);
//
//        dataSource.setTestConnectionOnCheckin(true);
//        dataSource.setTestConnectionOnCheckout(true);

        dataSource.getConnection();

//        dataSource.setLoginTimeout();
//        dataSource.setAcquireIncrement();
//        dataSource.setAcquireRetryAttempts();
//        dataSource.setAcquireRetryDelay();
//        dataSource.setBreakAfterAcquireFailure();
//        dataSource.setCheckoutTimeout();
//        dataSource.setConnectionCustomizerClassName();
//        dataSource.setConnectionPoolDataSource();
//        dataSource.setDebugUnreturnedConnectionStackTraces();
//        dataSource.setExtensions();
//        dataSource.setNumHelperThreads();
//
//        dataSource.setNumHelperThreads(50);
//        dataSource.setPrivilegeSpawnedThreads(true);

        return dataSource;
    }

    @Override
    public String getName() {
        return "c3p0";
    }
}
