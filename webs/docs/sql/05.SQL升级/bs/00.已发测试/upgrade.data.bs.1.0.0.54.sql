DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.54'; -- 本升级文件的版本，每个升级文件必须修改
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
	  select count(1) into num from bs_qxsz where mkid='M01122060' and sid='M00201';
	  if num=0 then
			insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
			values('M01122060','M0112','销售订单','确认收货',2,'100',1,'M011220','M00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxsz where mkid='M01122070' and sid='M00201';
	  if num=0 then
			insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
			values('M01122070','M0112','销售订单','确认到票',2,'100',1,'M011220','M00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxsz where mkid='M01081050' and sid='M00201';
	  if num=0 then
			insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
			values('M01081050','M0108','采购订单','申请延时支付',2,'100',1,'M010810','M00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exp/contract/sell/manage' and method='toDhqr' and styp=1 and mkid='M01122060' and sid='M00201';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01122060','/exp/contract/sell/manage','toDhqr',2,'合同管理-跳转确认收货页面',1,'M00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exp/contract/sell/manage' and method='doDhqr' and styp=1 and mkid='M01122060' and sid='M00201';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01122060','/exp/contract/sell/manage','doDhqr',2,'合同管理-确认收货',1,'M00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exp/contract/sell/manage' and method='toDpqr' and styp=1 and mkid='M01122070' and sid='M00201';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01122070','/exp/contract/sell/manage','toDpqr',2,'合同管理-跳转确认到票页面',1,'M00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exp/contract/sell/manage' and method='doDpqr' and styp=1 and mkid='M01122070' and sid='M00201';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01122070','/exp/contract/sell/manage','doDpqr',2,'合同管理-确认到票',1,'M00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='toYszf' and styp=1 and mkid='M01081050' and sid='M00201';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01081050','/exp/contract/buy/manage','toYszf',2,'合同管理-申请延时支付',1,'M00201');
	  end if;
	  
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='doYszf' and styp=1 and mkid='M01081050' and sid='M00201';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01081050','/exp/contract/buy/manage','doYszf',2,'合同管理-申请延时支付',1,'M00201');
	  end if;
	  
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exp/entrust/logistics/follow' and method='toDhqr' and styp=1 and mkid='M01601005' and sid='M00201';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01601005','/exp/entrust/logistics/follow','toDhqr',2,'合同管理-跳转确认到票页面',1,'M00201');
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exp/entrust/logistics/follow' and method='doDhqr' and styp=1 and mkid='M01601005' and sid='M00201';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01601005','/exp/entrust/logistics/follow','doDhqr',2,'合同管理-确认到票',1,'M00201');
	  end if;
	  
  	-- 2014/05/20 hangl 支付申请审核
	-- start
	num :=0;
	select count(1) into num from bs_qxsz where mkid='M010830' and mid='M0108' and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M010830','M0108','采购订单','支付申请审核','/exp/contract/buy/payRequest/audit/list.do','/exp/contract/buy/payRequest/audit/list.do',1,600,1,'','M00201');
	end if;
  
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/payRequest/audit' and method='list' and styp=1 and mkid='M010830' and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010830','/exp/contract/buy/payRequest/audit','list',2,'支付申请审核列表',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/payRequest/audit' and method='toAudit' and styp=1 and mkid='M010830' and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010830','/exp/contract/buy/payRequest/audit','toAudit',2,'进入支付申请审核页面',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/payRequest/audit' and method='audit' and styp=1 and mkid='M010830' and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010830','/exp/contract/buy/payRequest/audit','audit',2,'支付申请审核',1,'M00201');
	end if;
	--产量管理-月度计划
	update  bs_qxsz set url='/exp/output/mplan/list.do',inurl='/exp/output/mplan/list.do#/exp/output/mplan/toAdd.do#/exp/output/mplan/toEdit.do' where mname='产量管理' and sid='M00004' and mkid='M027005' ;
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/mplan' and method='list' and styp=1 and mkid='M027005' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M027005','/exp/output/mplan','list',2,'月度计划列表查询',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/mplan' and method='toAdd' and styp=1 and mkid='M027005' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M027005','/exp/output/mplan','toAdd',2,'月度计划-跳转到新增界面',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/mplan' and method='toEdit' and styp=1 and mkid='M027005' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M027005','/exp/output/mplan','toEdit',2,'月度计划-跳转到编辑界面',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/mplan' and method='save' and styp=1 and mkid='M027005' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M027005','/exp/output/mplan','save',2,'月度计划-保存信息',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/mplan' and method='delete' and styp=1 and mkid='M027005' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M027005','/exp/output/mplan','delete',2,'月度计划-删除',1,'M00004');
	end if;
  
  
	  num :=0;
	  select count(1) into num from bs_qxsz where mkid='B01150515' and sid='B00201';
	  if num=0 then
			insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
			values('B01150515','B0115','订单管理','纠纷处理',2,'100',2,'B011505','B00201');
	  end if;
	  
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/contract/shop/manage' and method='toYsqqqr' and styp=2 and mkid='B01150515' and sid='B00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01150515','/exm/contract/shop/manage','toYsqqqr',2,'订单管理-纠纷处理',2,'B00201');
	end if;
	  
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/contract/shop/manage' and method='doYssqqr' and styp=2 and mkid='B01150515' and sid='B00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01150515','/exm/contract/shop/manage','doYssqqr',2,'订单管理-纠纷处理',2,'B00201');
	end if;
	  
    -- end

    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

