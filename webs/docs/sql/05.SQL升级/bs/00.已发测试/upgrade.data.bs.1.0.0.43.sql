﻿DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.43'; -- 本升级文件的版本，每个升级文件必须修改
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG); -- 判断数据版本
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
	
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='queryAllDdcs' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/ajax','queryAllDdcs',0,'物流平台-首页-运输价格查询所有到达车站',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='queryAllQscs' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/ajax','queryAllQscs',0,'物流平台-首页-运输价格查询所有起始',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='queryAllLb' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/ajax','queryAllLb',0,'物流平台-首页-运输价格查询所有类别',1,'M00004');
  end if;
	
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='queryAllDl' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/ajax','queryAllDl',0,'物流平台-首页-查询需求资源大类',1,'M00004');
  end if;
	
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='queryAllMc' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/ajax','queryAllMc',0,'物流平台-首页-查询需求资源名称',1,'M00004');
  end if;
	
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='queryAllFbdw' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/ajax','queryAllFbdw',0,'物流平台-首页-查询需求资源名称',1,'M00004');
  end if;
	
  
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  