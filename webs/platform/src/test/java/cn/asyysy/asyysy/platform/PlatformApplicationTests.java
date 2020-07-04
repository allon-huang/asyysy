package cn.asyysy.asyysy.platform;

import cn.asyysy.asyysy.common.utils.HttpUtil;
import cn.asyysy.asyysy.common.utils.MacAddressAPI;
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

    @Test
    public void getApiQqtest(){
        String s = HttpUtil.sendGet("https://graph.qq.com/oauth2.0/authorize", "response_type=code&client_id=101852685&state=100", "UTF-8");
        System.out.println(s);
    }

    @Test
    public static void main(String[] args) {
        Integer flag17 = null;
        System.out.println(flag17 == 1);
        System.out.println(1 == flag17);
    }

}
