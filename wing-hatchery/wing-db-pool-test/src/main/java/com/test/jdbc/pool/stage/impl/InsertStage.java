package com.test.jdbc.pool.stage.impl;

import com.test.jdbc.pool.IDataSource;
import com.test.jdbc.pool.analysis.IAnalysis;
import com.test.jdbc.pool.analysis.impl.EmptyPoolAnalysis;
import com.test.jdbc.pool.analysis.impl.InsertPoolAnalysis;
import com.test.jdbc.pool.business.BaseBusinessService;
import com.test.jdbc.pool.business.IBusinessService;
import com.test.jdbc.pool.dao.BaseDao;
import com.test.jdbc.pool.stage.AbsFixedTimeStage;
import com.test.jdbc.pool.stage.AbsTimeStage;

/**
 * Created by nijia on 2017/11/11.
 */
public  class InsertStage extends AbsFixedTimeStage {



    private IAnalysis analysis ;



    private String querySql ;



    private IBusinessService businessService ;



    public InsertStage(IDataSource dataSource,String name,String version){
        businessService = new BaseBusinessService(new BaseDao(dataSource));
        analysis = new InsertPoolAnalysis(businessService,name,version);
        querySql = "select count(1) from pool where version='"+version+"' and"+" name='"+name+"';";

    }


    @Override
    public int getNum() {
        return 500;
    }

    public int getResult()throws  Exception{
        return businessService.businessQuery(querySql);
    }




    @Override
    public IAnalysis getAnalysis() {
        return analysis;
    }
}
