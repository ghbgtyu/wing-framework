package com.test.jdbc.pool.dao;

/**
 * Created by nijia on 2017/11/9.
 */
public interface IDao {


    public int query(String sql) throws Exception;

    public void insert(String sql) throws Exception;

    public void empty() throws Exception;
}
