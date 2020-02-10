DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.65'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from bs_qxmx where action='/exp/stock/partsbj' and method='showPartsBj' and styp=1 and mkid='M026515' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M026515','/exp/stock/partsbj','showPartsBj',2,'查看二级零部件信息',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/partsbj' and method='downLoad' and styp=1 and mkid='M026515' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M026515','/exp/stock/partsbj','downLoad',2,'附件下载',1,'M00004');
	end if;
	
	update bs_qxsz set mname='采购计划管理' where mkid='M027510' and mid='M0275' and sid='M00004';
	update bs_qxsz set mname='采购计划管理' where mkid='M027515' and mid='M0275' and sid='M00004';
	update bs_qxsz set mname='采购计划管理' where mkid='M027505' and mid='M0275' and sid='M00004';
	update bs_qxsz set mname='采购计划管理' where mkid='M027520' and mid='M0275' and sid='M00004';
	update bs_qxsz set mname='采购计划管理',name='采购计划编制' where mkid='M027525' and mid='M0275' and sid='M00004';
	
  	num :=0;
	select count(1) into num from bs_qxsz where mname = '采购计划管理' and name = '采购计划管理' and isuse = 1 and styp = 1 and sid = 'M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) values('M027530','M0275','采购计划管理','采购计划管理','/exp/orders/mproc/list.do','/exp/orders/mproc/list.do',1,550,1,'','M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/mproc' and method='list' and styp=1 and mkid='M027530' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027530','/exp/orders/mproc','list',2,'采购计划管理列表',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/procurement' and method='toAdd' and styp=1 and mkid='M027525' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027525','/exp/orders/procurement','toAdd',2,'跳转到采购计划编制界面',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/procurement' and method='save' and styp=1 and mkid='M027525' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027525','/exp/orders/procurement','save',2,'保存采购计划编制',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/procurement' and method='stockPointList' and styp=1 and mkid='M027525' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027525','/exp/orders/procurement','stockPointList',2,'采购计划断点列表',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/procurement' and method='stockPlanList' and styp=1 and mkid='M027525' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027525','/exp/orders/procurement','stockPlanList',2,'采购编制列表',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/procurement' and method='seeStockPlanInfo' and styp=1 and mkid='M027525' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027525','/exp/orders/procurement','seeStockPlanInfo',2,'查看采购编制详情',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/mproc' and method='save' and styp=1 and mkid='M027530' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027530','/exp/orders/mproc','save',2,'修改采购计划明细',1,'M00004');
	end if;
	
	--2014/06/18 hanglong 上架审核
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/hangsource/hangadmin' and method='doAudit' and styp=2 and mkid='B010505' and sid='B00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('B010505','/exm/hangsource/hangadmin','doAudit',2,'商品上架审核',2,'B00201');
	end if;
    
    
    update bs_qxsz set inurl='/exp/orders/procurement/list.do#/exp/orders/procurement/stockPlanList.do#/exp/orders/procurement/toAdd.do#/exp/orders/procurement/stockPointList.do' where mkid='M027525' and mid='M0275' and sid='M00004';
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

