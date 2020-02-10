DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.56'; -- 本升级文件的版本，每个升级文件必须修改
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
	
	update bs_qxsz set isuse=0 where mid='M0108' and sid='M00201' and parent='M010825' and mkid='M01082505' ;
	update bs_qxsz set isuse=0 where mid='M0108' and sid='M00201' and parent='M010825' and mkid='M01082510' ;
	update bs_qxsz set isuse=0 where mid='M0108' and sid='M00201' and parent='M010825' and mkid='M01082520' ;
	
	update bs_qxsz set isuse=0 where mkid='M01122020' and mid='M0112' and sid='M00201' and name='收款确认';
	update bs_qxsz set name='确认客户收货' where  mkid='M01122060' and mid='M0112' and sid='M00201' and name='确认收货';
	update bs_qxsz set name='确认客户到票' where  mkid='M01122070' and mid='M0112' and sid='M00201' and name='确认到票';
	update bs_qxsz set isuse=0 where mkid='B010035' and sid='B00000';
	update bs_qxsz set isuse=0 where mkid='B010080' and sid='B00000';
	delete bs_qxsz where mkid='M01050520' and sid='M00201';
	
	num :=0;
	select count(1) into num from bs_qxsz where name='版本比较' and sid='M00004';
	if num=1 then
  	 	update bs_Qxsz set inurl='/exp/hangsource/sell/hangadmin/index.do#/exp/hangsource/sell/publish/info.do#' where name='我的商品' and sid='M00201';
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='M027020' and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M027020','M0270','产量管理','产量版本比较','/exp/output/compare/list.do','/exp/output/compare/list.do',1,'400',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/compare' and method='list' and styp=1 and mkid='M027020' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M027020','/exp/output/compare','list',2,'月度计划版本比较',1,'M00004');
	end if;
	
	-- 2014/05/23 hanglong	后台订单市场价维护
	-- start
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01150520' and mid='B0115' and parent='B011505' and sid='B00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01150520','B0115','订单管理','市场价维护','','',2,120,2,'B011505','B00201');
	end if;
  
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/contract/shop/manage' and method='toScj' and styp=2 and mkid='B01150520' and sid='B00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01150520','/exm/contract/shop/manage','toScj',2,'进入市场价维护页面',2,'B00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/contract/shop/manage' and method='setScj' and styp=2 and mkid='B01150520' and sid='B00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01150520','/exm/contract/shop/manage','setScj',2,'市场价维护',2,'B00201');
	end if;
	-- end
	
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

