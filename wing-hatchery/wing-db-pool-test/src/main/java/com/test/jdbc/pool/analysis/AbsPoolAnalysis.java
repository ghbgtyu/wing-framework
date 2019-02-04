package com.test.jdbc.pool.analysis;

import com.test.jdbc.pool.business.IBusinessService;
import com.wing.common.util.LogUtil;

/**
 * Created by nijia on 2017/11/9.
 */
public abstract class AbsPoolAnalysis implements IAnalysis {

    protected IBusinessService businessService;


    public AbsPoolAnalysis(IBusinessService businessService) {
        this.businessService = businessService;
    }

    /**
     * 执行的对应业务
     */
    public abstract void startBusiness(IBusinessService businessService) throws Exception;


    public AnalysisResultData execute(AnalysisResultData data) {
        long nowTime = System.nanoTime();

        try {
            startBusiness(businessService);
        } catch (Exception e) {
            data.setExceptionCount(data.getExceptionCount() + 1);
            data.setCount(data.getCount() + 1);
            LogUtil.error(this.toString() + e);

            return data;
        }
        long endTime = System.nanoTime();
        float tmp = (endTime - nowTime) / 1000000f;
        data.setCount(data.getCount() + 1);
        data.setTime(data.getTime() + tmp);
        return data;

    }


    public abstract String getName();


    @Override
    public String toString() {
        return getName() + "_" + businessService.toString();
    }
}
