package com.test.jdbc.pool.datasource;

import com.test.jdbc.pool.AbsDataSource;
import com.test.jdbc.pool.JdcbConstants;
import org.apache.tomcat.jdbc.pool.DataSource;

/**
 * Created by nijia on 2017/11/11.
 */
public class MyTomcatJdbcDataSource extends AbsDataSource<DataSource> {


    @Override
    public DataSource createDataSource() throws Exception {
        DataSource dataSource = new DataSource();
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
        dataSource.setMaxIdle(JdcbConstants.MAX_ACTIVE);
        dataSource.setMinIdle(JdcbConstants.MIN_IDLE);
        dataSource.setValidationQuery(JdcbConstants.VALIDATION_QUERY);


//        dataSource.setTimeBetweenEvictionRunsMillis(1000);
//        dataSource.setTestWhileIdle(true);

//        dataSource.setTestOnBorrow(true);
//        dataSource.setTestOnReturn(true);

        //        dataSource.setTestOnConnect(true);
        dataSource.testIdle();


        return dataSource;
    }

    @Override
    public String getName() {
        return "tomcat_jdbc";
    }
}
