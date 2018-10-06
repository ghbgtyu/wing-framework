package com.test.jdbc.pool.datasource;

import com.test.jdbc.pool.AbsDataSource;
import com.test.jdbc.pool.JdcbConstants;
import com.zaxxer.hikari.HikariDataSource;

/**
 * Created by nijia on 2017/11/7.
 */
public class MyHikariDataSource extends AbsDataSource<HikariDataSource> {


    @Override
    public HikariDataSource  createDataSource() throws Exception {

        HikariDataSource  dataSource = new HikariDataSource ();
        try {
            dataSource.setDriverClassName(JdcbConstants.JDBC_DRIVER);

        } catch (Exception e) {
            throw new Exception(e);
        }

        dataSource.setJdbcUrl(JdcbConstants.JDBC_URL);
        dataSource.setUsername(JdcbConstants.MYSQL_USER_NAME);
        dataSource.setPassword(JdcbConstants.MYSQL_PASS_WORD);

        dataSource.setMaximumPoolSize(JdcbConstants.MAX_ACTIVE);
        dataSource.setMinimumIdle(JdcbConstants.MIN_IDLE);

        dataSource.setConnectionTestQuery(JdcbConstants.VALIDATION_QUERY);

//        dataSource.setMaxLifetime(2000);

        dataSource.validate();



        return dataSource;
    }

    @Override
    public String getName() {
        return "hikar";
    }
}
