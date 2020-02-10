DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.26'; -- 本升级文件的版本，每个升级文件必须修改
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
	
    update bs_qxsz set url='/exp/stock/fixed/list.do',inurl='/exp/stock/fixed/list.do#/exp/stock/fixed/toAdd.do#/exp/stock/fixed/toEdit.do' where mid='M0265' and mkid='M026505';	
    
    
      num := 0;
  select count(1) into num from bs_qxsz where mkid='B010525' and mid='B0105' and sid='B00004';
     if num=0 then
     insert into bs_qxsz(mkid,mid,mname,name,url,isuse,orderno,styp,parent,sid)
     values('B010525','B0105','基本设置','产品类别设置','/exm/basesetup/cplb/list.do',1,100,2,'','B00004');
  end if;
  num := 0;
  select count(1) into num from bs_qxsz where mkid='B01052505' and mid='B0105' and sid='B00004';
     if num=0 then
     insert into bs_qxsz(mkid,mid,mname,name,url,isuse,orderno,styp,parent,sid)
     values('B01052505','B0105','基本设置','编辑','',2,200,2,'B010525','B00004');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where mkid='B010525' and action='/exm/basesetup/cplb' and method='export2Excel' and sid='B00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B010525','/exm/basesetup/cplb','export2Excel',2,'导出excel',2,'B00004');
  end if;
  num := 0;
  select count(1) into num from bs_qxmx where mkid='B010525' and action='/exm/basesetup/cplb' and method='list' and sid='B00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B010525','/exm/basesetup/cplb','list',2,'列表',2,'B00004');
  end if;
  num := 0;
  select count(1) into num from bs_qxmx where mkid='B01052505' and action='/exm/basesetup/cplb' and method='add' and sid='B00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B01052505','/exm/basesetup/cplb','add',2,'新增',2,'B00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='B01052505' and action='/exm/basesetup/cplb' and method='edit' and sid='B00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B01052505','/exm/basesetup/cplb','edit',2,'编辑',2,'B00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='B01052505' and action='/exm/basesetup/cplb' and method='save' and sid='B00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B01052505','/exm/basesetup/cplb','save',2,'保存',2,'B00004');
  end if;
    


  update bs_qxsz set url='/exp/stock/parts/list.do' where mkid='M026510' and mid='M0265' and sid='M00004';
  update bs_qxsz set url='/exp/stock/partsbj/list.do' where mkid='M026515' and mid='M0265' and sid='M00004';

select count(1) into num from bs_qxmx where mkid='M026510' and action='/exp/stock/parts' and method='list' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026510','/exp/stock/parts','list',2,'分页列表',1,'M00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='M026510' and action='/exp/stock/parts' and method='toAdd' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026510','/exp/stock/parts','toAdd',2,'新增页面',1,'M00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='M026510' and action='/exp/stock/parts' and method='toEdit' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026510','/exp/stock/parts','toEdit',2,'编辑页面',1,'M00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='M026510' and action='/exp/stock/parts' and method='save' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026510','/exp/stock/parts','save',2,'新增保存',1,'M00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='M026510' and action='/exp/stock/parts' and method='update' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026510','/exp/stock/parts','update',2,'修改保存',1,'M00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='M026510' and action='/exp/stock/parts' and method='dodel' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026510','/exp/stock/parts','dodel',2,'删除',1,'M00004');
  end if;
  
  
  select count(1) into num from bs_qxmx where mkid='M026515' and action='/exp/stock/partsbj' and method='list' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026515','/exp/stock/partsbj','list',2,'分页列表',1,'M00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='M026515' and action='/exp/stock/partsbj' and method='toAdd' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026515','/exp/stock/partsbj','toAdd',2,'新增页面',1,'M00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='M026515' and action='/exp/stock/partsbj' and method='toEdit' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026515','/exp/stock/partsbj','toEdit',2,'编辑页面',1,'M00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='M026515' and action='/exp/stock/partsbj' and method='save' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026515','/exp/stock/partsbj','save',2,'新增保存',1,'M00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='M026515' and action='/exp/stock/partsbj' and method='update' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026515','/exp/stock/partsbj','update',2,'修改保存',1,'M00004');
  end if;
  select count(1) into num from bs_qxmx where mkid='M026515' and action='/exp/stock/partsbj' and method='dodel' and sid='M00004';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M026515','/exp/stock/partsbj','dodel',2,'删除',1,'M00004');
  end if;

  update  bs_qxmx set accesstag =0 where mkid='M026505' and action='/exp/stock/fixed' and method='getCategory' and sid='M00004';
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  