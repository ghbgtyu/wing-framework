package com.test.jdbc.pool.analysis.impl;

import com.test.jdbc.pool.analysis.AbsPoolAnalysis;
import com.test.jdbc.pool.business.IBusinessService;

/**
 * Created by nijia on 2017/11/9.
 */
public class InsertPoolAnalysis extends AbsPoolAnalysis {



    public String name ;
    public String version;



    public InsertPoolAnalysis(IBusinessService businessService,String name ,String version){
        super(businessService);
        this.name = name;
        this.version = version;
    }

    @Override
    public void startBusiness(IBusinessService businessService) throws Exception {
        businessService.businessInsert("insert into pool (NAME,VERSION) values(\""+name+"\",\"" + version + "\");");

    }



    @Override
    public String getName() {
        return "InsertAnalysisPool";
    }
}
