package cn.asyysy.platform;

import cn.asyysy.common.MacAddressAPI;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class PlatformApplicationTests {

    @Test
    public void contextLoads() {
    }

    /**
     * 获取物理地址
     */
    @Test
    public void getWindows7MACAddress(){
        String windows7MACAddress = MacAddressAPI.getWindows7MACAddress();
        System.out.println(windows7MACAddress);
    }

}
