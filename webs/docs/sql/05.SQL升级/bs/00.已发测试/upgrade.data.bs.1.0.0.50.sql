DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.50'; -- 本升级文件的版本，每个升级文件必须修改
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
  update bs_xtmk set mname='交易账户' where mid='B0115' and sid='B00301' and styp=2;
  update bs_qxsz set name='交易账户余额' where mkid='B011505' and mid='B0115' and sid='B00301';
  update bs_qxsz set name='订单付款明细' where mkid='B011515' and mid='B0115' and sid='B00301';
  update bs_qxsz set inurl='#/exm/basesetup/setpz/list.do#/exm/basesetup/setpzChild/secondList.do' where mkid='B014005' and sid='B00201' and name='物资品种设置';
  update bs_qxmx set accesstag=0 where  action='/market/publicfun' and method='wldwList' and sid='M00000';
  update bs_Codes set isuse=0 where typ='常用代码类别' and code='公告类型';
  update bs_Codes set isuse=0 where typ='常用代码类别' and code='消息群组';
  
  update bs_qxsz set isuse=0 where mkid='B012015' and name='系统监控' and sid='B00000';
  update bs_qxsz set isuse=0 where mkid='B010020' and name='外部公告发布' and sid='B00000';
  update bs_qxsz set isuse=0 where mkid='B010025' and name='消息模板设置' and sid='B00000';
  update bs_qxsz set isuse=0 where mkid='B010030' and name='消息发布' and sid='B00000';
  update bs_qxsz set isuse=0 where mkid='B010027' and name='消息群设置' and sid='B00000';
  update bs_qxsz set isuse=0 where mkid='M010010' and name='我的消息' and sid='M00000';
  update bs_qxsz set isuse=0 where mkid='M011545' and name='我的消息' and sid='M00101';
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/manager/subaccount/inout' and method='list' and styp=2 and mkid='B011520' and sid='B00301';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B011520','/manager/subaccount/inout','list',2,'银行交易明细查询','2','B00301');
  end if;
  
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/manager/subaccount/inout' and method='sync' and styp=2 and mkid='B011520' and sid='B00301';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B011520','/manager/subaccount/inout','sync',2,'银行交易明细同步','2','B00301');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='B011520' and sid='B00301';
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
  values('B011520','B0115','资金账户','银行交易明细','/manager/subaccount/inout/list.do','/manager/subaccount/inout/list.do#',1,200,2,'B00301');
  end if;
  
  
    
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

