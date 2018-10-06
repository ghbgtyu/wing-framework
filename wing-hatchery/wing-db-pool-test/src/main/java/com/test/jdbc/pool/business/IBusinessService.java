package com.test.jdbc.pool.business;

/**
 * Created by nijia on 2017/11/9.
 */
public interface IBusinessService {

    /**业务查询*/
    public int businessQuery(String sql) throws Exception;


    public void businessInsert(String sql) throws Exception;

    public void businessEmpty() throws Exception;
}
