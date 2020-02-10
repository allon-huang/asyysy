DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.51'; -- 本升级文件的版本，每个升级文件必须修改
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
  
	  update bs_qxsz set name='资金账户流水',orderno=50 where sid='B00301' and mkid='B011520';
	   
	  -- 2014/05/12 hangl 货款结算单权限
	  -- start
	  num :=0;
	  select count(1) into num from bs_qxsz where mkid='B011550' and mid='B0115' and sid='B00201';
	  if num=0 then
	    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
	    values('B011550','B0115','订单管理','货款结算单','/exm/contract/bill/manage/list.do','/exm/contract/bill/manage/list.do',1,1000,2,'','B00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exm/contract/bill/manage' and method='list' and styp=2 and mkid='B011550' and sid='B00201';
	  if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B011550','/exm/contract/bill/manage','list',2,'货款结算单列表',2,'B00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exm/contract/bill/manage' and method='preview' and styp=2 and mkid='B011550' and sid='B00201';
	  if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B011550','/exm/contract/bill/manage','preview',2,'查看明细',2,'B00201');
	  end if;
	  -- end 

	  -- 2014/05/12 hangl 货款结算权限
	  num :=0;
	  select count(1) into num from bs_qxsz where mkid='B01154015' and parent='B011540' and mid='B0115' and sid='B00201';
	  if num=0 then
	    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
	    values('B01154015','B0115','订单管理','批量结算','','',2,200,2,'B011540','B00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exm/settle/contract/manage' and method='toMoreSettle' and styp=2 and mkid='B01154015' and sid='B00201';
	  if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B01154015','/exm/settle/contract/manage','toMoreSettle',2,'进入结算页面',2,'B00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exm/settle/contract/manage' and method='createBill' and styp=2 and mkid='B01154015' and sid='B00201';
	  if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B01154015','/exm/settle/contract/manage','createBill',2,'结算',2,'B00201');
	  end if;
	  -- end 

	  -- 2014/05/13 hangl 后台代理商选择方法
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/admin/publicfun' and method='wldwList' and sid='B00000';
	  if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('0','/admin/publicfun','wldwList',0,'后台代理商列表',2,'B00000');
	  end if;
    
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

