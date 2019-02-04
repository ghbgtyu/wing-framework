package com.test.jdbc.pool.datasource;

import com.test.jdbc.pool.AbsDataSource;
import com.test.jdbc.pool.JdcbConstants;
import org.apache.commons.dbcp2.BasicDataSource;
import org.logicalcobwebs.proxool.ProxoolDataSource;

/**
 * Created by nijia on 2017/11/7.
 */
public class MyDbcpDataSource extends AbsDataSource<BasicDataSource> {


    @Override
    public BasicDataSource createDataSource() throws Exception {

        BasicDataSource dataSource = new BasicDataSource();


        try {
            dataSource.setDriverClassName(JdcbConstants.JDBC_DRIVER);

        } catch (Exception e) {
            throw new Exception(e);
        }

        dataSource.setUrl(JdcbConstants.JDBC_URL);
        dataSource.setUsername(JdcbConstants.MYSQL_USER_NAME);
        dataSource.setPassword(JdcbConstants.MYSQL_PASS_WORD);

        dataSource.setMaxIdle(JdcbConstants.MAX_ACTIVE);


        dataSource.setMinIdle(JdcbConstants.MIN_IDLE);
        dataSource.setValidationQuery(JdcbConstants.VALIDATION_QUERY);


        return dataSource;
    }

    @Override
    public String getName() {
        return "c3p0";
    }
}
