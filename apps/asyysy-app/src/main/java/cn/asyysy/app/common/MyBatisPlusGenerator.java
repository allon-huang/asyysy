package cn.asyysy.app.common;

import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.GlobalConfig;
import com.baomidou.mybatisplus.generator.config.PackageConfig;
import com.baomidou.mybatisplus.generator.config.StrategyConfig;
import com.baomidou.mybatisplus.generator.config.rules.DbType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;

import java.sql.SQLException;

/**
 * @author huangyaoyu
 */
public class MyBatisPlusGenerator {

    /**
     * 执行该方法即可自动
     * @param args
     * @throws SQLException
     */
    public static void main(String[] args) throws SQLException {

        //1. 全局配置
        GlobalConfig config = new GlobalConfig();
        // 是否支持AR模式
        config.setActiveRecord(true)
                // 作者
                .setAuthor("huangyaoyu")
                // 生成路径
                .setOutputDir("D:\\codes\\asyysy\\apps\\asyysy-app\\src\\main\\java")
                //.setOutputDir("F:\\stsworkspace\\MyBatisPlusGenerator\\src\\main\\java") // 生成路径
                // 文件覆盖
                .setFileOverride(true)
                // 主键策略
                .setIdType(IdType.AUTO)
                // 设置生成的service接口的名字的首字母是否为I
                .setServiceName("%sService")
                // IEmployeeService
                //生成基本的resultMap
                .setBaseResultMap(true)
                //生成基本的SQL片段
                .setBaseColumnList(true);

        //2. 数据源配置
        DataSourceConfig  dsConfig  = new DataSourceConfig();
        // 设置数据库类型
        dsConfig.setDbType(DbType.MYSQL)
                .setDriverName("com.mysql.jdbc.Driver")
                .setUrl("jdbc:mysql://localhost:3306/asyysy_core?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=UTC&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true")
                .setUsername("root")
                .setPassword("123123112233");

        //3. 策略配置globalConfiguration中
        StrategyConfig stConfig = new StrategyConfig();
                //全局大写命名
                stConfig.setCapitalMode(true)
                // 指定表名 字段名是否使用下划线
                .setDbColumnUnderline(true)
                // 数据库表映射到实体的命名策略
                .setNaming(NamingStrategy.underline_to_camel)
                //.setTablePrefix("tbl_")
                // 生成的表
                .setInclude("cron");

        //4. 包名策略配置
        PackageConfig pkConfig = new PackageConfig();
        pkConfig.setParent("cn.asyysy.app")
                //dao
                .setMapper("mapper")
                //servcie
                .setService("service")
                //controller
                .setController("controller")
                .setEntity("model")
                //mapper.xml
                .setXml("mapper");

        //5. 整合配置
        AutoGenerator  ag = new AutoGenerator();
        ag.setGlobalConfig(config)
                .setDataSource(dsConfig)
                .setStrategy(stConfig)
                .setPackageInfo(pkConfig);

        //6. 执行
        ag.execute();
    }

}