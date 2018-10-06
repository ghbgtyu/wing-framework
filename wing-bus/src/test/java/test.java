import com.wing.bus.external.config.BusServerConfigHandler;
import com.wing.bus.application.config.BusConfig;
import com.wing.common.config.container.FileConfigContainer;
import com.wing.common.config.interfaces.IStaticConfigHandler;
import org.junit.Test;

/**
 * Created by nijia on 2017/7/19.
 */
public class test {


//    public static void main(String args[]){
//        try {
//            ResourceLoader resourceLoader = new DefaultResourceLoader();
//            Resource resource = resourceLoader.getResource("bus.xml");
//            XMLConfiguration config = new XMLConfiguration(resource.getFile());
//
//            System.out.println(config.getString("server.innerPort"));
//
//
//        }catch (Exception e){
//            System.out.print(e.toString());
//        }
//
//    }




    @Test
    public void testRoute() throws Exception{
        TestServerTest testServerTest = new TestServerTest(null);
        testServerTest.onStart();
    }


    @Test
    public void testConfig() throws Exception{
        FileConfigContainer config = new FileConfigContainer("");
        IStaticConfigHandler t = new BusServerConfigHandler();
        config.registerHandler(t);
        config.parseStart();

        BusConfig s = config.get(BusConfig.class);
//
//        assert (s.getInnerPort()>0);
//        assert (s.getTcpPort()>0);
//        assert (s.getWebPort()>0);
    }
}
