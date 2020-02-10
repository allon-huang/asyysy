DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.42'; -- 本升级文件的版本，每个升级文件必须修改
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
  select count(1) into num from bs_qxmx where action='/tdp/logistics/index' and method='ysjg' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/index','ysjg',0,'物流平台-首页-参考价格',1,'M00004');
  end if;
	
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/index' and method='ysjgMore' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/index','ysjgMore',0,'物流平台-首页-参考价格',1,'M00004');
  end if;
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/index' and method='wlgz' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/index','wlgz',0,'物流平台-首页-物流跟踪',1,'M00004');
  end if;
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/scheme' and method='index' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/scheme','index',0,'物流平台-首页-物流跟踪',1,'M00004');
  end if;
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getVTdYsjgCs' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/ajax','getVTdYsjgCs',0,'物流平台-首页-查询运输价格城市',1,'M00004');
  end if;
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getVTdXqzyCol' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/ajax','getVTdXqzyCol',0,'物流平台-首页-查询运输价格城市',1,'M00004');
  end if;
  
  
  
  update bs_xtmk set qxrole='004-9' where sid='M00004' and mid='M0310';

  update bs_codes set typ='角色类型' where typ='企业类型';
  num :=0;
  select count(1) into num from bs_codes where TYP='常用代码类别' and CODE='角色类型';
  if num=0 then
  	insert into bs_codes (TYP, CODE, VALUE, ISUSE, ORDERNO, ISCANSET, FLAG0)
	values ('常用代码类别', '角色类型', '角色类型', 0, 7, 1, 1);
  end if;
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  