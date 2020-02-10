DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.59'; -- 本升级文件的版本，每个升级文件必须修改
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
	update bs_qxsz set url='/exp/output/compare/trendAnalyse.do',inurl='/exp/output/compare/trendAnalyse.do' where mkid='M027010' and name='产量走势分析' and sid='M00004';
	update bs_qxsz set orderno='500',isuse=0 where mkid='M027015' and name='产量维护' and sid='M00004';
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/compare' and method='trendAnalyse' and styp=1 and mkid='M027010' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027010','/exp/output/compare','trendAnalyse',2,'产量走势分析图形',1,'M00004');
	end if;
	
	-- 2014/05/25 hanglong	前台进入参考价设置页面
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/sell/manage' and method='toCkj' and styp=1 and mkid='0' and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/contract/sell/manage','toCkj',1,'设置参考价',1,'M00201');
	end if;
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

