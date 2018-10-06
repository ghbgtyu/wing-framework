package com.test.jdbc.pool;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by nijia on 2017/11/7.
 */
public interface IDataSource {


    public Connection getConnection()throws SQLException;

    public void close() throws  SQLException;

    public String getName();
}
