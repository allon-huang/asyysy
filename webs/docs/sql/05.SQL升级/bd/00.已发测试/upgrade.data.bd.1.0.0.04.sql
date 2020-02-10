DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.04'; -- 本升级文件的版本，每个升级文件必须修改
    P_VERSION(SYSID=>'BD',NEWVERSION=>CURVERSION,REF_MSG=>MSG); -- 判断数据版本
    IF (NVL(MSG,'-')<>'success') THEN
        RAISE_APPLICATION_ERROR(-20000,MSG);
    END IF;
    -- 获取当前数据用户
    -- SELECT MAX(USERNAME) INTO CURDB FROM USER_USERS; -- BSDB、FDDB、ECDB
    -------------------------------------------------------------
    -- 日期 人员 功能简单说明，不要写COMMIT，统一由模块提交
    -- 所有SQL升级代码按下面的模版进行增加，不允许超出本模版
    -- 范围的SQL出现。
    -- 模版见：UPGRADE.TEMPLATE.SQL
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    -- 请注意：不要在本文件中填写对数据库表结构或者存储过程、视图等非数据类操作的脚本
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    ------------------------------------------------------------- 
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='评标专家确认方式';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','评标专家确认方式','评标专家确认方式', 1, 200, 1);
    end if;
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='履约担保形式';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','履约担保形式','履约担保形式', 1, 210, 1);
    end if;
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='履约担保金额单位';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','履约担保金额单位','履约担保金额单位', 1, 220, 1);
    end if;
    
    DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.04'; -- 本升级文件的版本，每个升级文件必须修改
    P_VERSION(SYSID=>'BD',NEWVERSION=>CURVERSION,REF_MSG=>MSG); -- 判断数据版本
    IF (NVL(MSG,'-')<>'success') THEN
        RAISE_APPLICATION_ERROR(-20000,MSG);
    END IF;
    -- 获取当前数据用户
    -- SELECT MAX(USERNAME) INTO CURDB FROM USER_USERS; -- BSDB、FDDB、ECDB
    -------------------------------------------------------------
    -- 日期 人员 功能简单说明，不要写COMMIT，统一由模块提交
    -- 所有SQL升级代码按下面的模版进行增加，不允许超出本模版
    -- 范围的SQL出现。
    -- 模版见：UPGRADE.TEMPLATE.SQL
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    -- 请注意：不要在本文件中填写对数据库表结构或者存储过程、视图等非数据类操作的脚本
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    ------------------------------------------------------------- 
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='评标专家确认方式';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','评标专家确认方式','评标专家确认方式', 1, 200, 1);
    end if;
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='履约担保形式';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','履约担保形式','履约担保形式', 1, 210, 1);
    end if;
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='履约担保金额单位';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','履约担保金额单位','履约担保金额单位', 1, 220, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_cssz where cskey='MAX_BID_PRICE';
    if num = 0 then
      insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz) 
      values('ISCONFIRM','报名是否确认','0','','系统管理员','0-不需要审核，1-需要审核价','1',3100,'0-不需要审核，1-需要审核');
	 end if; 
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  