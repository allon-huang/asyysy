DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.58'; -- 本升级文件的版本，每个升级文件必须修改
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
	
	-- 2014/05/24 hanglong	待审核代理商列表
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/menber/wldw' and method='auditList' and styp=1 and mkid='M010035' and sid='M00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010035','/bsp/menber/wldw','auditList',2,'待审核代理商列表',1,'M00000');
	end if;
	
	-- 2014/05/25 hanglong	价格对比报表
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B018530' and mid='B0185' and sid='B00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B018530','B0185','统计分析报表','价格对比表','/exm/report/jgdb/list.do','/exm/report/jgdb/list.do',1,25,2,'','B00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/report/jgdb' and method='list' and styp=2 and mkid='B018530' and sid='B00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B018530','/exm/report/jgdb','list',2,'价格对比表',2,'B00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/report/jgdb' and method='export2Excel' and styp=2 and mkid='B018530' and sid='B00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B018530','/exm/report/jgdb','export2Excel',2,'价格对比表-导出',2,'B00201');
	end if;
	
	-- 2014/05/25 hanglong	设置参考价
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/sell/manage' and method='setCkj' and styp=1 and mkid='0' and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/contract/sell/manage','setCkj',1,'设置参考价',1,'M00201');
	end if;

	-- 2014/05/24 songb	注册验证手机号是否重复
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/menber/reg' and method='checkMbMobile' and styp=1  and sid='M00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/bsp/menber/reg','checkMbMobile',0,'供应商注册-验证手机号是否重复AJAX',1,'M00000');
	end if;

	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/menber/reg' and method='checkMbEmail' and styp=1  and sid='M00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/bsp/menber/reg','checkMbEmail',0,'供应商注册-验证邮箱是否重复AJAX',1,'M00000');
	end if;
	
	update bs_qxsz set inurl='/bsp/menber/wldw/list.do#/bsp/menber/wldw/auditList.do' where mkid='M010035' and mid='M0100' and sid='M00000';
	
	num :=0;
    select count(1) into num from bs_qxsz where name='配送跟踪' and sid='M00201';
    if num=1 then
       update bs_Qxsz set inurl='/exp/entrust/logistics/follow/index.do#/exp/entrust/logistics/follow/toDhqr.do#' where name='配送跟踪' and sid='M00201';
	end if;
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

