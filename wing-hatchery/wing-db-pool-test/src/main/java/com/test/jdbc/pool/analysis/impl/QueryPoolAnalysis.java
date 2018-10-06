package com.test.jdbc.pool.analysis.impl;

import com.test.jdbc.pool.analysis.AbsPoolAnalysis;
import com.test.jdbc.pool.business.IBusinessService;

/**
 * Created by nijia on 2017/11/9.
 */
public class QueryPoolAnalysis extends AbsPoolAnalysis {


    public QueryPoolAnalysis(IBusinessService businessService){
        super(businessService);
    }

    @Override
    public void startBusiness(IBusinessService businessService) throws Exception {
      //  businessService.businessQuery("select count(1) from pool");
        businessService.businessQuery("select 1");
    }

    @Override
    public String getName() {
        return "QueryAnalysisPool";
    }
}
