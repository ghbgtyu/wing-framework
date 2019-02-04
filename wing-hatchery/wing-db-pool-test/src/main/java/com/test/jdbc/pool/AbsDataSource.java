package com.test.jdbc.pool;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by nijia on 2017/11/7.
 */
public abstract class AbsDataSource<D extends DataSource> implements IDataSource {


    private DataSource dataSource;

    public AbsDataSource() {
        try {
            this.dataSource = this.createDataSource();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    /**
     * 创建连接池dataSource
     */
    public abstract D createDataSource() throws Exception;


    public Connection getConnection() throws SQLException {


        return dataSource.getConnection();
    }

    public void close() throws SQLException {
        dataSource.getConnection().close();
    }

    public abstract String getName();

    @Override
    public String toString() {
        return getName();
    }
}
