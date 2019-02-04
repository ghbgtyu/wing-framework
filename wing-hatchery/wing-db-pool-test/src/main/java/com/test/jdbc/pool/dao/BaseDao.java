package com.test.jdbc.pool.dao;


import com.test.jdbc.pool.IDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Created by nijia on 2017/11/9.
 */
public class BaseDao implements IDao {

    private IDataSource dataSource;

    public BaseDao(IDataSource dataSource) {
        this.dataSource = dataSource;
    }


    public void insert(String sql) throws Exception {
        Connection connection = dataSource.getConnection();
        PreparedStatement pstmt = connection.prepareStatement(sql);
        pstmt.execute(sql);

        pstmt.close();
        connection.close();
    }

    public int query(String sql) throws Exception {
        int result = 0;
        Connection connection = dataSource.getConnection();
        PreparedStatement pstmt = connection.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            result = rs.getInt(1);
        }


        rs.close();
        pstmt.close();
        connection.close();
        return result;

    }

    public void empty() throws Exception {
        Connection connection = dataSource.getConnection();
        connection.close();
    }

    @Override
    public String toString() {
        return dataSource.toString();
    }
}
