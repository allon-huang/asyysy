DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.10'; -- 本升级文件的版本，每个升级文件必须修改
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
     
  num:=0;
  select count(1) into num from bs_qxmx where ACTION='/' and METHOD='querySupplier' and STYP='1' and SID='M00004';     
  if num = 0 then
    insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( '0', '/', 'querySupplier', 0, '供应商列表', 1, 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where ACTION='/' and METHOD='supplierDirectory' and STYP='1' and SID='M00004';     
  if num = 0 then
  insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( '0', '/', 'supplierDirectory', 0, '供应商列表页面', 1, 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where ACTION='/' and METHOD='getWzpztree' and STYP='1' and SID='M00004';     
  if num = 0 then
  insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( '0', '/', 'getWzpztree', 0, '物资品种树', 1, 'M00004'); 
  end if;


     num:=0;
    select count(1) into num from bs_qxmx where  sid='M00004' and action='/tdp/trail/send' and styp=1 and method='exportExcel';
    if num = 0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M01400505', '/tdp/trail/send', 'exportExcel', 2, '合同跟踪-发货登记-导出', 1, 'M00004');
    end if;

     num:=0;
    select count(1) into num from bs_qxmx where sid='M00004' and action='/tdp/trail/receive' and styp=1 and method='exportExcel';
    if num = 0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M01450505', '/tdp/trail/receive', 'exportExcel', 2, '合同跟踪-到货登记-导出', 1, 'M00004');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where   sid='M00004' and action='/tdp/trail/warehouse' and styp=1 and method='exportExcel';
    if num = 0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M01500505', '/tdp/trail/warehouse', 'exportExcel', 2, '合同跟踪-入库登记-导出', 1, 'M00004');
    end if;
    

     num:=0;
    select count(1) into num from bs_qxmx where  sid='M00004' and action='/tdp/trail/deliverDtl' and styp=1 and method='exportExcel';
    if num = 0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M013510', '/tdp/trail/deliverDtl', 'exportExcel', 2, '合同跟踪-交货登记-交货明细-导出', 1, 'M00004');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where sid='M00004' and action='/tdp/trail/sendDtl' and styp=1 and method='exportExcel';
    if num = 0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M014010', '/tdp/trail/sendDtl', 'exportExcel', 2, '合同跟踪-发货登记-发货明细-导出', 1, 'M00004');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where  sid='M00004' and action='/tdp/trail/receiveDtl' and styp=1 and method='exportExcel';
    if num = 0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M014510', '/tdp/trail/receiveDtl', 'exportExcel', 2, '合同跟踪-收货登记-收货明细-导出', 1, 'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  sid='M00004' and action='/tdp/trail/warehouseDtl' and styp=1 and method='exportExcel';
    if num = 0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M015015', '/tdp/trail/warehouseDtl', 'exportExcel', 2, '合同跟踪-入库登记-入库明细-导出', 1, 'M00004');
    end if;


     num:=0;
    select count(1) into num from bs_qxmx where  sid='M00004' and action='/tdp/trail/pccontractMx' and styp=1 and method='exportExcel';
    if num = 0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M013020', '/tdp/trail/pccontractMx', 'exportExcel', 2, '合同明细列表-导出', 1, 'M00004');
    end if;





    update bs_qxsz set isuse = 0 where mkid='B011540' and mid='B0100' and sid='B00000' and styp=2 and name='费用交纳审核';
    update bs_codes set isuse = 0 where typ='常用代码类别' and (code='车辆类型' or code='费用类型' or code='商铺类型');
    update bs_qxsz set isuse = 0 where sid='M00000' and name='费用缴纳' and mname='基本管理' and mkid='M010025';
    update bs_qxsz set isuse =0 where mkid='M010015' and name='部门管理' and mid='M0100';
    update bs_cssz set remark='若启用，前台注册的会员需要平台审核' where cskey='B_REG_USER_AUDIT';
  
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M022005' and sid='M00004' and action='/tdp/fee/manager' and method='toView';
    if num = 0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M022005', '/tdp/fee/manager', 'toView', 2, '查看费用信息', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where  mkid='M022005' and sid='M00004' and action='/tdp/fee/manager' and method='printView';
    if num = 0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M022005', '/tdp/fee/manager', 'printView', 2, '费用管理-打印接待申请单', 1, 'M00004');
    end if;
    
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/common' and method='getDxhy' and styp=1 and sid='M00004';
    if num = 0 then
      insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
      values (bs_qxmx_0.nextval, '0', '/exp/querybusiness/common', 'getDxhy', 1, 'ajax获取定向会员信息', 1, 'M00004');
    end if;
    -------------------------------------------------------------
  -- add 采购需求编制列表-导出权限 by zhangsiwei on 20140103
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M01150520' and action='/tdp/puc/req' and method='export2Excel' and sid='M00004';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
      values('M01150520','/tdp/puc/req','export2Excel','2','采购需求编制列表-导出',1,'M00004');
  end if;

  num := 0;
  select count(1) into num from bs_qxsz where mkid='M01150520' and mid='M0115' and sid='M00004';
  if num=0 then
    insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
     values('M01150520','M0115','采购需求','批量导出',2,400,1,'M011505','M00004');
  end if;
    -------------------------------------------------------------

    -------------------------------------------------------------
  ---采购计划、采购任务导出功能---
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M012505' and action='/tdp/puc/mission/manager' and method='exportExcel' and sid='M00004';
  if num=0 then
   insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
   values('M012505','/tdp/puc/mission/manager','exportExcel',2,'导出excel',1,'M00004');
  end if;

  num := 0;
  select count(1) into num from bs_qxmx where mkid='M012510' and action='/tdp/puc/mission/approve' and method='exportExcel' and sid='M00004';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M012510','/tdp/puc/mission/approve','exportExcel',2,'导出excel',1,'M00004');
  end if;

  num := 0;
  select count(1) into num from bs_qxmx where mkid='M012515' and action='/tdp/puc/mission/list' and method='exportExcel' and sid='M00004';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M012515','/tdp/puc/mission/list','exportExcel',2,'导出excel',1,'M00004');
  end if;

  num := 0;
  select count(1) into num from bs_qxmx where mkid='M012005' and action='/tdp/puc/plan/manager' and method='exportExcel' and sid='M00004';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M012005','/tdp/puc/plan/manager','exportExcel',2,'导出excel',1,'M00004');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M012010' and action='/tdp/puc/plan/approve' and method='exportExcel' and sid='M00004';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M012010','/tdp/puc/plan/approve','exportExcel',2,'导出excel',1,'M00004');
  end if;

  num := 0;
  select count(1) into num from bs_qxmx where mkid='M012015' and action='/tdp/puc/plan/list' and method='exportExcel' and sid='M00004';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M012015','/tdp/puc/plan/list','exportExcel',2,'导出excel',1,'M00004');
  end if;
    -------------------------------------------------------------
  -- add 采购需求-导出权限 by zhangsiwei on 20140103
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M011510' and action='/tdp/puc/req/approve' and method='export2Excel' and sid='M00004';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M011510','/tdp/puc/req/approve','export2Excel','2','采购需求审核列表-导出',1,'M00004');
  end if;

  num := 0;
  select count(1) into num from bs_qxmx where mkid='M011515' and action='/tdp/puc/req/query' and method='export2Excel' and sid='M00004';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M011515','/tdp/puc/req/query','export2Excel','2','采购需求明细列表-导出',1,'M00004');
  end if;
    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  