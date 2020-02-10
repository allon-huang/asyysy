DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.6'; -- 本升级文件的版本，每个升级文件必须修改
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
    num := 0;
   select count(1) into num from bs_qxmx where action='/bid/bulletin' and mkid='0' and method='zbggList' and styp=1 and sid='M00004';
    if num= 0 then 
      insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( '0', '/bid/bulletin', 'zbggList', 0, '招标公告列表', 1, 'M00004');
     end if;


    num := 0;
   select count(1) into num from bs_qxmx where action='/bid/bulletin' and mkid='0' and method='announcement' and styp=1 and sid='M00004';
    if num=0 then 
    insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( '0', '/bid/bulletin', 'announcement', 0, '招标公告详情', 1, 'M00004');
     end if;


     num := 0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/common' and mkid='M017005' and method='xjggList' and styp=1 and sid='M00004';
    if num= 0 then 
    insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( 'M017005', '/exp/querybusiness/common', 'xjggList', 0, '询价公告列表', 1, 'M00004');
    end if;

     num := 0;
    select count(1) into num from bs_qxmx where action='/' and mkid='0' and method='allAnnouncementList' and styp=1 and sid='M00004';
    if num= 0 then 
    insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( '0', '/', 'allAnnouncementList', 0, '全部公告列表', 1, 'M00004');
    end if;
  
    num := 0;
    select count(1) into num from bs_qxmx where action='/' and mkid='0' and method='jjggList' and styp=1 and sid='M00004';
    if num=0 then 
    insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( '0', '/', 'jjggList', 0, '竞价公告列表', 1, 'M00004');
    end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/req/approve' and method='batchAudit' and mkid='M011510' and sid='M00004';
  if num=0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M011510', '/tdp/puc/req/approve', 'batchAudit', 2, '批量审核', 1, 'M00004');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/mission/select' and method='list' and mkid='0' and sid='M00004';
  if num=0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/tdp/puc/mission/select', 'list', 1, '任务选择', 1, 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M01150510' and sid='M00004' and styp=1;
  if num=0 then
    insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
values ('M01150510', 'M0115', '采购需求', '需求完成', null, null, 2, 100, 1, 'M011505', 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M01150515' and sid='M00004' and styp=1;
  if num=0 then
    insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
values ('M01150515', 'M0115', '采购需求', '需求取消完成', null, null, 2, 100, 1, 'M011505', 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M01151010' and sid='M00004' and styp=1;
  if num=0 then
    insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
values ('M01151010', 'M0115', '采购计划', '计划完成', null, null, 2, 100, 1, 'M011510', 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M01151015' and sid='M00004' and styp=1;
  if num=0 then
    insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
values ('M01151015', 'M0115', '采购计划', '计划取消完成', null, null, 2, 100, 1, 'M011510', 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M01151510' and sid='M00004' and styp=1;
  if num=0 then
    insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
values ('M01151510', 'M0115', '采购任务', '任务完成', null, null, 2, 100, 1, 'M011515', 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M01151515' and sid='M00004' and styp=1;
  if num=0 then
    insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
values ('M01151515', 'M0115', '采购任务', '任务取消完成', null, null, 2, 100, 1, 'M011515', 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/req' and method='complete' and sid='M00004';
  if num=0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M01150510', '/tdp/puc/req', 'complete', 2, '需求完成', 1, 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/req' and method='cancel' and sid='M00004';
  if num=0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M01150515', '/tdp/puc/req', 'cancel', 2, '需求取消完成', 1, 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/plan/manager' and method='complete' and sid='M00004';
  if num=0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M01151010', '/tdp/puc/plan/manager', 'complete', 2, '计划完成', 1, 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/plan/manager' and method='cancel' and sid='M00004';
  if num=0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M01151015', '/tdp/puc/plan/manager', 'cancel', 2, '计划取消完成', 1, 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/mission/manager' and method='complete' and sid='M00004';
  if num=0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M01151510', '/tdp/puc/mission/manager', 'complete', 2, '任务完成', 1, 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/mission/manager' and method='cancel' and sid='M00004';
  if num=0 then
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M01151515', '/tdp/puc/mission/manager', 'cancel', 2, '任务取消完成', 1, 'M00004');
  end if;
  
  
    num := 0;
  select count(1) into num from bs_qxsz where mkid='B010007' and sid='B00000';
  if num=0 then 
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
    values('B010007','B0100','会员管理','供应商审核','/bsp/supplier/regaudit/list.do','/bsp/supplier/regaudit/list.do#/bsp/supplier/regaudit/toAudit.do',1,10,2,null,'B00000');
  end if;
  
    num := 0;
  select count(1) into num from bs_qxsz where mkid='B01000705' and sid='B00000';
  if num=0 then 
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
    values('B01000705','B0100','会员管理','审核','','',2,10,2,'B010007','B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='list' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'B010007','/bsp/supplier/regaudit','list',2,'会员管理-供应商管理',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='toAudit' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'B01000705','/bsp/supplier/regaudit','toAudit',2,'会员管理-供应商审核-审核通过',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='agree' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'B01000705','/bsp/supplier/regaudit','agree',2,'会员管理-供应商审核-同意',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='reject' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'B01000705','/bsp/supplier/regaudit','reject',2,'会员管理-供应商审核-拒绝',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='del' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'B01000705','/bsp/supplier/regaudit','del',2,'会员管理-供应商审核-回收',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='checkUsname' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'0','/bsp/supplier/regaudit','checkUsname',0,'会员管理-供应商审核-检查会员全称(英文)',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='checkMbname' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'0','/bsp/supplier/regaudit','checkMbname',0,'会员管理-供应商审核-检查会员全称',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='checkLogid' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'0','/bsp/supplier/regaudit','checkLogid',0,'会员管理-供应商审核-检查管理员代码',2,'B00000');
  end if;

  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='delList' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'B010007','/bsp/supplier/regaudit','delList',2,'会员管理-供应商审核-回收站',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='del' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'B01000705','/bsp/supplier/regaudit','del',2,'会员管理-供应商审核-删除',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='restore' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'B01000705','/bsp/supplier/regaudit','restore',2,'会员管理-供应商审核-还原待审核',2,'B00000');
  end if;
  
  update bs_qxsz set orderno=2,inurl='/bsp/supplier/regaudit/list.do#/bsp/supplier/regaudit/toAudit.do#/bsp/supplier/regaudit/delList.do' where MKID = 'B010007' and SID='B00000';
  
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and method='showimg' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'0','/bsp/supplier/regaudit','showimg',0,'会员管理-供应商审核-查看附件',2,'B00000');
  end if;


    num := 0;
   select count(1) into num from bs_qxmx where action='/tdp/trail/pccontract' and mkid='M01300110' and method='showDeliveryPlan' and styp=1 and sid='M00004';
    if num= 0 then 
     insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
     values (bs_qxmx_0.nextval,'M01300110','/tdp/trail/pccontract','showDeliveryPlan',2,'交货计划：显示页',1,'M00004');
  end if;

    num := 0;
   select count(1) into num from bs_qxmx where action='/tdp/trail/pccontractMx' and mkid='M013020' and method='update' and styp=1 and sid='M00004';
    if num= 0 then 
     insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
     values (bs_qxmx_0.nextval, 'M013020', '/tdp/trail/pccontractMx', 'update', 2, '修改状态为完成', 1, 'M00004');
  end if;

    num := 0;
   select count(1) into num from bs_qxmx where action='/login'  and method='dopopLogin' ;
   if num= 0 then 
    insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('0', '/login', 'dopopLogin', 0, '前台登录', 1, 'M00000');
  end if;

    num := 0;
   select count(1) into num from bs_qxmx where action='/login'  and method='popIndex' ;
    if num = 0 then
  insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ('0', '/login', 'popIndex', 0, '前台登录', 1, 'M00000');
  end if;


  num :=0;
  select count(1) into num from bs_qxmx where action='/bsm/menber/manager' and method='toEditSupplier' and sid='B00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'B01000105','/bsm/menber/manager','toEditSupplier',2,'会员管理-供应商审核-修改供应商信息',2,'B00000');
  end if;
  
  update bs_qxsz set mname='订单管理' where  sid='B00201' and mid='B0115';
  update bs_qxsz set name='订单查询' where  sid='B00201' and mid='B0115' and mkid='B011505';
  update bs_xtmk set mname='订单管理' where mid ='B0115' and  sid='B00201';
  update BS_QXSZ t set t.name='上架商品统计表' where t.mkid='B018520' and t.sid='B00201';
 
  
    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  