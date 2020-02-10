DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.53'; -- 本升级文件的版本，每个升级文件必须修改
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
	  select count(1) into num from bs_qxmx where action='/manager/subaccount/ye' and method='export' and styp=2 and mkid='B011505' and sid='B00301';
	  if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B011505','/manager/subaccount/ye','export',2,'中信，账户余额导出',2,'B00301');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/manager/subaccount/inout' and method='export' and styp=2 and mkid='B011520' and sid='B00301';
	  if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B011520','/manager/subaccount/inout','export',2,'中信，账户余额导出',2,'B00301');
	  end if;
	  
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/manager/subaccount/mx' and method='export' and styp=2 and mkid='B011515' and sid='B00301';
	  if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B011515','/manager/subaccount/mx','export',2,'中信，账户余额导出',2,'B00301');
	  end if;
	  
	  update bs_qxsz set isuse=0 where mkid='B01154005' and parent='B011540' and sid='B00201';
	  update bs_qxsz set name='结算' where mkid='B01154015' and parent='B011540' and sid='B00201';
    

    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

