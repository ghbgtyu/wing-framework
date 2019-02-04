package com.test.jdbc.pool.datasource;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.test.jdbc.pool.AbsDataSource;
import com.test.jdbc.pool.JdcbConstants;
import org.logicalcobwebs.proxool.ProxoolDataSource;

/**
 * Created by nijia on 2017/11/7.
 */
public class MyProxoolDataSource extends AbsDataSource<ProxoolDataSource> {


    @Override
    public ProxoolDataSource createDataSource() throws Exception {

        ProxoolDataSource dataSource = new ProxoolDataSource();


        try {
            dataSource.setDriver(JdcbConstants.JDBC_DRIVER);

        } catch (Exception e) {
            throw new Exception(e);
        }

        dataSource.setDriverUrl(JdcbConstants.JDBC_URL);
        dataSource.setUser(JdcbConstants.MYSQL_USER_NAME);
        dataSource.setPassword(JdcbConstants.MYSQL_PASS_WORD);

        dataSource.setMaximumConnectionCount(JdcbConstants.MAX_ACTIVE);


        dataSource.setMinimumConnectionCount(JdcbConstants.MIN_IDLE);
        dataSource.setHouseKeepingTestSql(JdcbConstants.VALIDATION_QUERY);


        return dataSource;
    }

    @Override
    public String getName() {
        return "c3p0";
    }
}
