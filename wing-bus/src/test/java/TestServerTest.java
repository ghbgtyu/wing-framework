import com.wing.bus.BusService;
import com.wing.common.service.AbstractService;
import junit.framework.Test;
import org.springframework.stereotype.Service;

import static org.junit.Assert.*;

/**
 * Created by nijia on 2017/9/11.
 */

public class TestServerTest extends AbstractService {


    public static void main(String []args)throws Exception{
        TestServerTest testServerTest = new TestServerTest(null);
        testServerTest.onStart();
    }


    TestServerTest(String[] args){
        super(args);
    }

    @Override
    public String getServiceName() {
        return "test";
    }

    @Override
    protected void onStart() throws Exception {
        BusService busService =new BusService();
        busService.onStart();
    }

    @Override
    protected void onRun() throws Exception {

    }

    @Override
    protected void onStop() throws Exception {

    }

    @Override
    protected void onPause() throws Exception {

    }

    @Override
    protected void onResume() throws Exception {

    }
}