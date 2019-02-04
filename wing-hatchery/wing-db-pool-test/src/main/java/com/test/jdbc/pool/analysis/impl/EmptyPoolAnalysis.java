package com.test.jdbc.pool.analysis.impl;

import com.test.jdbc.pool.analysis.AbsPoolAnalysis;
import com.test.jdbc.pool.business.IBusinessService;

/**
 * Created by nijia on 2017/11/9.
 */
public class EmptyPoolAnalysis extends AbsPoolAnalysis {


    public EmptyPoolAnalysis(IBusinessService businessService) {
        super(businessService);
    }

    @Override
    public void startBusiness(IBusinessService businessService) throws Exception {
        businessService.businessEmpty();
    }


    @Override
    public String getName() {
        return "EmptyAnalysisPool";
    }
}
