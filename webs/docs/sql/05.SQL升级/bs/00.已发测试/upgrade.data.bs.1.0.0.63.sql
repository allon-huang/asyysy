DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.63'; -- 本升级文件的版本，每个升级文件必须修改
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
	update bs_qxsz set isuse=1,name='合同明细报表',orderno='600',inurl='/exp/orders/pattern/list.do#/exp/orders/pattern/showInfo.do' where mkid='M027515' and mid='M0275' and name='理论订货模型' and sid='M00004';
	update bs_qxsz set isuse=1,name='执行情况报表',orderno='700' where mkid='M027510' and mid='M0275' and name='生产进度查询' and sid='M00004';
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/schedule' and method='exportExcel' and styp=1 and mkid='M027510' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027510','/exp/orders/schedule','exportExcel',2,'导出',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/schedule' and method='viewRequirement' and styp=1 and mkid='M027510' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027510','/exp/orders/schedule','viewRequirement',2,'导出',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/schedule' and method='viewPlan' and styp=1 and mkid='M027510' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027510','/exp/orders/schedule','viewPlan',2,'导出',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/schedule' and method='viewMission' and styp=1 and mkid='M027510' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027510','/exp/orders/schedule','viewMission',2,'导出',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/schedule' and method='getGoodsList' and styp=1 and mkid='M027510' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027510','/exp/orders/schedule','getGoodsList',2,'导出',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/pattern' and method='exportExcel' and styp=1 and mkid='M027515' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027515','/exp/orders/pattern','exportExcel',2,'导出',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/pattern' and method='showInfo' and styp=1 and mkid='M027515' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027515','/exp/orders/pattern','showInfo',2,'导出',1,'M00004');
	end if;
	
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/public/item' and method='queryBjCodeList' and styp=1 and mkid='0' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('0','/public/item','queryBjCodeList',1,'获取二级零部件列表AJAX',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/fixed' and method='showInfo' and styp=1 and mkid='M026505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M026505','/exp/stock/fixed','showInfo',2,'产品信息查看',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/parts' and method='ajaxQueryLjExtInfo' and styp=1 and mkid='M026510' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M026510','/exp/stock/parts','ajaxQueryLjExtInfo',2,'AJAX获得一级零部件EXT表里的信息',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/partsbj' and method='ajaxQueryBjExtInfo' and styp=1 and mkid='M026515' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M026515','/exp/stock/partsbj','ajaxQueryBjExtInfo',2,'AJAX获得二级零部件EXT表里的信息',1,'M00004');
	end if;
	
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/fixed' and method='downLoad' and styp=1 and mkid='M026505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M026505','/exp/stock/fixed','downLoad',2,'附件下载',1,'M00004');
	end if;
	
	
	update bs_qxsz set inurl='/exp/stock/fixed/list.do#/exp/stock/fixed/toAdd.do#/exp/stock/fixed/toEdit.do#/exp/stock/fixed/showInfo.do' where mkid='M026505' and mid='M0265' and name='产品' and sid='M00004';
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

