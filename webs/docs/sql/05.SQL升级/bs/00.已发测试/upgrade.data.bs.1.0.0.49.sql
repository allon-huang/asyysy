DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.49'; -- 本升级文件的版本，每个升级文件必须修改
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

  -- 2014/05/06 hangl 供应商管理权限
  -- start
  num :=0;
  select count(1) into num from bs_qxsz where mkid='B010090' and mid='B0100' and sid='B00000';
  if num=0 then
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
    values('B010090','B0100','会员管理','供应商管理','/bsm/supplier/manager/list.do','/bsm/supplier/manager/list.do',1,2,2,'','B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsm/supplier/manager' and method='list' and styp=2 and mkid='B010090' and sid='B00000';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B010090','/bsm/supplier/manager','list',2,'供应商管理列表',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='B01009005' and parent='B010090' and mid='B0100' and sid='B00000';
  if num=0 then
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
    values('B01009005','B0100','会员管理','设置结算期','','',2,900,2,'B010090','B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsm/supplier/manager' and method='toSettle' and styp=2 and mkid='B01009005' and sid='B00000';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B01009005','/bsm/supplier/manager','toSettle',2,'打开设置结算期页面',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsm/supplier/manager' and method='doSettle' and styp=2 and mkid='B01009005' and sid='B00000';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B01009005','/bsm/supplier/manager','doSettle',2,'设置结算期',2,'B00000');
  end if;
  
  -- end

  num :=0;
  select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='toFkqr' and styp=1 and sid='M00101';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01051505','/exp/contract/buy/manage','toFkqr',2,'买方付款确认',1,'M00101');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='doFkqr' and styp=1 and sid='M00101';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01051505','/exp/contract/buy/manage','doFkqr',2,'买方付款确认',1,'M00101');
  end if;
  
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='toFkqr' and styp=1 and sid='M00201';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M010810','/exp/contract/buy/manage','toFkqr',2,'买方付款确认',1,'M00201');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='doFkqr' and styp=1 and sid='M00201';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M010810','/exp/contract/buy/manage','doFkqr',2,'买方付款确认',1,'M00201');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/exm/collect/manager' and method='list' and styp=2 and sid='B00201';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('B020010','/exm/collect/manager','list',2,'收款管理-收款确认列表',2,'B00201');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/exm/collect/manager' and method='toSkqr' and styp=2 and sid='B00201';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('B02001005','/exm/collect/manager','toSkqr',2,'收款管理-跳转收款确认信息',2,'B00201');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/exm/collect/manager' and method='doSkqr' and styp=2 and sid='B00201';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('B02001005','/exm/collect/manager','doSkqr',2,'收款管理-收款确认',2,'B00201');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/exm/collect/manager' and method='doSkqrAll' and styp=2 and sid='B00201';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('B02001005','/exm/collect/manager','doSkqrAll',2,'收款管理-批量收款确认',2,'B00201');
  end if;
  
  num :=0;
  select count(1) into num from bs_xtmk where mid='B0200' and sid='B00201';
  if num=0 then
  insert into bs_xtmk(mid, mname, styp,ordby,sid)
  values('B0200','收款管理',2,'300','B00201');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='B020010' and sid='B00201';
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('B020010','B0200','收款管理','收款确认','/exm/collect/manager/list.do','/exm/collect/manager/list.do#',1,'100',2,'','B00201');
  end if;
  
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='B02001005' and sid='B00201';
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('B02001005','B0200','收款管理','编辑','','',2,'100',2,'B020010','B00201');
  end if;
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

