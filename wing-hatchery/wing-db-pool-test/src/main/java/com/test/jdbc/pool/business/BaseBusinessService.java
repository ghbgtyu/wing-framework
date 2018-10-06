package com.test.jdbc.pool.business;

import com.test.jdbc.pool.IDataSource;
import com.test.jdbc.pool.dao.IDao;

/**
 * Created by nijia on 2017/11/9.
 */
public class BaseBusinessService implements IBusinessService{


    private IDao dao;

    public BaseBusinessService(IDao dao){
        this.dao = dao;
    }


    public int businessQuery(String sql)throws Exception {
        return dao.query(sql);
    }


    public void businessEmpty() throws Exception {
        dao.empty();
    }

    public void businessInsert(String sql) throws Exception {
        dao.insert(sql);
    }

    @Override
    public String toString() {
        return dao.toString();
    }
}
